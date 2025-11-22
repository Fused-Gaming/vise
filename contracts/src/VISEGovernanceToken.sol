// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title VISEGovernanceToken
 * @notice Governance token for VISE DAO (Module 4 demonstration)
 * @dev Demonstrates:
 *      - ERC-20 token standard
 *      - Voting power delegation
 *      - Permit (gasless approvals)
 *      - Token distribution
 */
contract VISEGovernanceToken is ERC20, ERC20Permit, ERC20Votes, Ownable {
    // Token configuration
    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 10**18; // 1 million tokens
    uint256 public constant MAX_SUPPLY = 10_000_000 * 10**18; // 10 million tokens

    // Distribution tracking
    mapping(address => uint256) public educatorAllocations;
    mapping(address => bool) public hasClaimedAirdrop;

    uint256 public airdropAmount = 100 * 10**18; // 100 tokens per airdrop
    bool public airdropActive = true;

    // Events
    event AirdropClaimed(address indexed recipient, uint256 amount);
    event EducatorAllocationSet(address indexed educator, uint256 amount);
    event TokensMinted(address indexed to, uint256 amount);
    event AirdropStatusChanged(bool active);

    /**
     * @notice Contract constructor
     */
    constructor()
        ERC20("VISE Governance Token", "VISE")
        ERC20Permit("VISE Governance Token")
        Ownable(msg.sender)
    {
        // Mint initial supply to owner
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /**
     * @notice Claim airdrop tokens (one-time per address)
     */
    function claimAirdrop() public {
        require(airdropActive, "Airdrop is not active");
        require(!hasClaimedAirdrop[msg.sender], "Already claimed airdrop");
        require(totalSupply() + airdropAmount <= MAX_SUPPLY, "Would exceed max supply");

        hasClaimedAirdrop[msg.sender] = true;
        _mint(msg.sender, airdropAmount);

        emit AirdropClaimed(msg.sender, airdropAmount);
    }

    /**
     * @notice Set educator allocation (owner only)
     * @param educator The educator's address
     * @param amount The allocation amount
     */
    function setEducatorAllocation(address educator, uint256 amount) public onlyOwner {
        require(educator != address(0), "Invalid educator address");
        educatorAllocations[educator] = amount;

        emit EducatorAllocationSet(educator, amount);
    }

    /**
     * @notice Educator claims their allocation
     */
    function claimEducatorAllocation() public {
        uint256 allocation = educatorAllocations[msg.sender];
        require(allocation > 0, "No allocation available");
        require(totalSupply() + allocation <= MAX_SUPPLY, "Would exceed max supply");

        educatorAllocations[msg.sender] = 0;
        _mint(msg.sender, allocation);

        emit TokensMinted(msg.sender, allocation);
    }

    /**
     * @notice Mint new tokens (owner only)
     * @param to The recipient address
     * @param amount The amount to mint
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Would exceed max supply");
        _mint(to, amount);

        emit TokensMinted(to, amount);
    }

    /**
     * @notice Set airdrop status (owner only)
     * @param active Whether airdrop is active
     */
    function setAirdropActive(bool active) public onlyOwner {
        airdropActive = active;
        emit AirdropStatusChanged(active);
    }

    /**
     * @notice Set airdrop amount (owner only)
     * @param amount The new airdrop amount
     */
    function setAirdropAmount(uint256 amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than 0");
        airdropAmount = amount;
    }

    /**
     * @notice Get voting power of an account
     * @param account The account to check
     * @return The voting power
     */
    function getVotingPower(address account) public view returns (uint256) {
        return getVotes(account);
    }

    /**
     * @notice Check if address has claimed airdrop
     * @param account The account to check
     * @return Whether airdrop was claimed
     */
    function hasAirdropClaimed(address account) public view returns (bool) {
        return hasClaimedAirdrop[account];
    }

    // Required overrides for multiple inheritance

    function _update(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, amount);
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
