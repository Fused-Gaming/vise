# VISE Smart Contract Demonstrations

This directory contains educational smart contract demonstrations for the VISE curriculum, organized by module. All contracts are built with Foundry and include comprehensive tests.

## 📚 Contents

- **Module 2**: Solidity Fundamentals
- **Module 3**: NFTs and Token Standards
- **Module 4**: Governance and DAOs
- **Module 5**: Smart Contract Security

## 🚀 Quick Start

```bash
# Install Foundry (if not already installed)
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Install dependencies
forge install

# Run all tests
forge test

# Run tests with gas report
forge test --gas-report

# Run tests with coverage
forge coverage

# Deploy to Sepolia testnet
forge script script/DeployAll.s.sol:DeployAll --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
```

## 📋 Module 2: Solidity Fundamentals

### HelloWorld.sol

**Purpose**: Introduction to basic Solidity concepts

**Features**:
- State variables (string, address, uint256)
- Constructor initialization
- Public functions and view functions
- Events (MessageUpdated, OwnershipTransferred)
- Access control (owner-only functions)
- Update counting

**Key Learning Points**:
- Contract structure
- Function visibility (public, view)
- Event emission
- Basic access control patterns

**Usage**:
```solidity
HelloWorld hello = new HelloWorld("Initial Message");
hello.updateMessage("New Message");
string memory msg = hello.getMessage();
```

### SimpleVoting.sol

**Purpose**: Demonstrate structs, mappings, and time-based logic

**Features**:
- Proposal struct with nested mapping
- Time-based voting deadlines
- One vote per address enforcement
- Proposal execution after deadline
- Owner-only proposal creation

**Key Learning Points**:
- Structs and mappings
- Time-based logic (block.timestamp)
- Access control with modifiers
- State management

**Usage**:
```solidity
SimpleVoting voting = new SimpleVoting();
voting.createProposal("Upgrade Protocol", 7); // 7 days
voting.vote(0); // Vote on proposal 0
// After deadline:
voting.executeProposal(0);
```

### SimpleStaking.sol

**Purpose**: ETH staking with reward calculations

**Features**:
- Payable functions (stake)
- ETH transfers
- Reward calculation (10% APY)
- Time-based rewards
- Automatic reward claiming on re-stake

**Key Learning Points**:
- Payable functions
- ETH handling
- Time-based calculations
- Checks-Effects-Interactions pattern

**Usage**:
```solidity
SimpleStaking staking = new SimpleStaking();
staking.stake{value: 10 ether}();

// Wait some time...
uint256 reward = staking.calculateReward(userAddress);

staking.unstake(); // Get stake + rewards
```

## 🎨 Module 3: NFTs

### VISEAchievementNFT.sol

**Purpose**: Soulbound achievement NFTs for course completion

**Features**:
- ERC-721 implementation
- Soulbound (non-transferable)
- Multiple achievement types
- Educator role management
- Module completion tracking
- Batch minting support

**Achievement Types**:
- MODULE_COMPLETION
- PERFECT_SCORE
- EARLY_COMPLETION
- COMMUNITY_CONTRIBUTION
- SPECIAL_RECOGNITION

**Key Learning Points**:
- ERC-721 standard
- Role-based access control
- Enums and structs
- Soulbound token implementation

**Usage**:
```solidity
VISEAchievementNFT nft = new VISEAchievementNFT("ipfs://base/");
nft.addEducator(educatorAddress);

// As educator:
nft.mintAchievement(
    studentAddress,
    1, // module ID
    VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
    "ipfs://metadata"
);
```

### DynamicProgressNFT.sol

**Purpose**: On-chain dynamic NFT that visualizes student progress

**Features**:
- Dynamic on-chain SVG generation
- Progress tracking (modules, score, level)
- Level system (100 points per level)
- Real-time metadata updates
- Soulbound (non-transferable)
- Color changes based on level

**Key Learning Points**:
- On-chain SVG generation
- Base64 encoding
- Dynamic metadata
- String manipulation in Solidity

**Usage**:
```solidity
DynamicProgressNFT nft = new DynamicProgressNFT();
nft.mintProgressNFT(studentAddress);
nft.updateProgress(studentAddress, 3, 150); // 3 modules, 150 points

string memory svg = nft.generateSVG(tokenId);
string memory tokenURI = nft.tokenURI(tokenId);
```

## 🏛️ Module 4: Governance

### VISEGovernanceToken.sol

**Purpose**: ERC-20 governance token with voting power

**Features**:
- ERC-20 with ERC-20Votes extension
- Permit (gasless approvals)
- Airdrop mechanism
- Educator allocations
- Max supply cap (10M tokens)
- Delegation for voting power

**Key Learning Points**:
- ERC-20 standard
- Governance token patterns
- Delegation mechanisms
- Permit/EIP-2612

**Usage**:
```solidity
VISEGovernanceToken token = new VISEGovernanceToken();

// Claim airdrop
token.claimAirdrop();

// Delegate voting power (required for governance)
token.delegate(myAddress);

// Set educator allocation
token.setEducatorAllocation(educator, 10000 * 10**18);
```

### VISEGovernor.sol

**Purpose**: OpenZeppelin Governor for DAO governance

**Features**:
- Proposal creation and voting
- Timelock integration
- Quorum requirements (4%)
- Voting delay and period
- Proposal threshold (100 tokens)

**Key Learning Points**:
- Governor pattern
- Timelock security
- Quorum and voting mechanics
- DAO governance

**Usage**:
```solidity
// Create proposal
address[] memory targets = new address[](1);
uint256[] memory values = new uint256[](1);
bytes[] memory calldatas = new bytes[](1);

governor.propose(targets, values, calldatas, "Description");

// Vote
governor.castVote(proposalId, 1); // 1 = For

// After voting period + timelock
governor.execute(targets, values, calldatas, descriptionHash);
```

## 🔒 Module 5: Security

### VulnerableBank.sol

**Purpose**: ⚠️ Intentionally vulnerable contract for education

**Vulnerabilities**:
1. **Reentrancy Attack**: withdraw() calls external address before updating state
2. **No Access Control**: emergencyWithdraw() can be called by anyone
3. **Unchecked External Calls**: No validation on call recipients

**⚠️ WARNING**: This contract is INTENTIONALLY INSECURE. Deploy ONLY to testnets for educational purposes. NEVER use in production!

**Educational Value**:
- Demonstrates real reentrancy vulnerability
- Shows impact of missing access control
- Includes ReentrancyAttacker contract for demonstrations

**Usage** (Educational Only):
```solidity
VulnerableBank bank = new VulnerableBank();
bank.deposit{value: 1 ether}();

// Demonstrate reentrancy attack
ReentrancyAttacker attacker = new ReentrancyAttacker(address(bank));
attacker.attack{value: 1 ether}();
// Attacker steals funds through reentrancy!
```

### SecureBank.sol

**Purpose**: Secure implementation demonstrating best practices

**Security Features**:
1. **ReentrancyGuard**: Prevents reentrancy attacks
2. **Access Control**: Ownable for administrative functions
3. **Checks-Effects-Interactions**: State updates before external calls
4. **Pausable**: Circuit breaker pattern
5. **Withdrawal Limits**: Prevents large unauthorized withdrawals
6. **Input Validation**: Min/max deposit amounts

**Key Learning Points**:
- Reentrancy protection
- Access control patterns
- Circuit breakers
- Safe ETH handling

**Usage**:
```solidity
SecureBank bank = new SecureBank();
bank.deposit{value: 1 ether}();
bank.withdraw(0.5 ether);

// Owner functions
bank.setWithdrawalLimit(20 ether);
bank.pause(); // Emergency stop
bank.emergencyWithdraw(); // Only works when paused
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
forge test

# Run specific test file
forge test --match-path test/HelloWorld.t.sol

# Run with verbosity
forge test -vvv

# Run with gas reporting
forge test --gas-report

# Run with coverage
forge coverage

# Run specific test function
forge test --match-test testReentrancyAttackSucceeds
```

### Test Coverage

All contracts have comprehensive test coverage including:
- ✅ Happy path scenarios
- ✅ Edge cases
- ✅ Failure cases
- ✅ Access control
- ✅ Fuzz testing
- ✅ Event emission
- ✅ State transitions

### Coverage Report

```bash
forge coverage --report summary
```

Expected coverage: >95% for all contracts

## 🚀 Deployment

### Prerequisites

1. Set up environment variables:

```bash
# Copy example env file
cp ../.env.example .env

# Edit .env with your values
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_KEY
PRIVATE_KEY=0x...
ETHERSCAN_API_KEY=...
NFT_BASE_URI=ipfs://...
```

2. Ensure you have testnet ETH (get from Sepolia faucet)

### Deploy Individual Modules

```bash
# Module 2
forge script script/DeployModule2.s.sol:DeployModule2 \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast \
  --verify

# Module 3
forge script script/DeployModule3.s.sol:DeployModule3 \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast \
  --verify

# Module 4
forge script script/DeployModule4.s.sol:DeployModule4 \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast \
  --verify

# Module 5
forge script script/DeployModule5.s.sol:DeployModule5 \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast \
  --verify
```

### Deploy All Contracts

```bash
forge script script/DeployAll.s.sol:DeployAll \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast \
  --verify
```

Deployment addresses will be saved to `./deployments/*.json`

## 📊 Contract Sizes

```bash
forge build --sizes
```

All contracts are optimized to stay within the 24KB deployment limit.

## 🔍 Verification

Contracts are automatically verified on Etherscan if you include `--verify` flag and set `ETHERSCAN_API_KEY`.

Manual verification:
```bash
forge verify-contract \
  --chain-id 11155111 \
  --compiler-version v0.8.20 \
  CONTRACT_ADDRESS \
  src/ContractName.sol:ContractName
```

## 📝 Contract Interactions

### Using Cast

```bash
# Call a view function
cast call CONTRACT_ADDRESS "getMessage()(string)"

# Send a transaction
cast send CONTRACT_ADDRESS \
  "updateMessage(string)" \
  "New Message" \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY

# Check balance
cast balance ADDRESS
```

## 🏗️ Development

### Compile Contracts

```bash
forge build
```

### Format Code

```bash
forge fmt
```

### Update Dependencies

```bash
forge update
```

## 📚 Additional Resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Docs](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Ethereum.org](https://ethereum.org/developers)

## 🤝 Contributing

When adding new demonstration contracts:

1. Follow existing naming conventions
2. Add comprehensive tests (>95% coverage)
3. Include NatSpec documentation
4. Add deployment script
5. Update this README
6. Ensure contracts are educational and well-commented

## ⚠️ Important Notes

- **VulnerableBank** is intentionally insecure - testnet only!
- All NFTs are soulbound (non-transferable)
- Governance requires delegation for voting power
- Always test on testnets before any mainnet deployment
- Keep private keys secure and never commit them

## 📄 License

MIT License - See LICENSE file for details

---

**Built for VISE Curriculum** | Last Updated: 2025-11-22
