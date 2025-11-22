// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SimpleVoting
 * @notice Voting contract demonstration for VISE Module 2
 * @dev Demonstrates:
 *      - Structs
 *      - Mappings
 *      - Access control (Ownable pattern)
 *      - Time-based logic
 */
contract SimpleVoting {
    // Struct to represent a proposal
    struct Proposal {
        string description;
        uint256 voteCount;
        uint256 deadline;
        bool executed;
        mapping(address => bool) voters;
    }

    // State variables
    address public owner;
    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;

    // Events
    event ProposalCreated(
        uint256 indexed proposalId,
        string description,
        uint256 deadline
    );

    event VoteCast(uint256 indexed proposalId, address indexed voter);

    event ProposalExecuted(uint256 indexed proposalId);

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    /**
     * @notice Contract constructor
     */
    constructor() {
        owner = msg.sender;
        proposalCount = 0;
    }

    /**
     * @notice Create a new proposal
     * @param description The proposal description
     * @param durationInDays How long voting should be open (in days)
     */
    function createProposal(string memory description, uint256 durationInDays)
        public
        onlyOwner
    {
        uint256 proposalId = proposalCount;
        Proposal storage newProposal = proposals[proposalId];

        newProposal.description = description;
        newProposal.voteCount = 0;
        newProposal.deadline = block.timestamp + (durationInDays * 1 days);
        newProposal.executed = false;

        proposalCount++;

        emit ProposalCreated(proposalId, description, newProposal.deadline);
    }

    /**
     * @notice Vote on a proposal
     * @param proposalId The ID of the proposal to vote on
     */
    function vote(uint256 proposalId) public {
        require(proposalId < proposalCount, "Proposal does not exist");

        Proposal storage proposal = proposals[proposalId];

        require(block.timestamp < proposal.deadline, "Voting has ended");
        require(!proposal.voters[msg.sender], "Already voted");
        require(!proposal.executed, "Proposal already executed");

        proposal.voters[msg.sender] = true;
        proposal.voteCount++;

        emit VoteCast(proposalId, msg.sender);
    }

    /**
     * @notice Execute a proposal (owner only)
     * @param proposalId The ID of the proposal to execute
     */
    function executeProposal(uint256 proposalId) public onlyOwner {
        require(proposalId < proposalCount, "Proposal does not exist");

        Proposal storage proposal = proposals[proposalId];

        require(block.timestamp >= proposal.deadline, "Voting still ongoing");
        require(!proposal.executed, "Already executed");

        proposal.executed = true;
        emit ProposalExecuted(proposalId);
    }

    /**
     * @notice Get proposal details
     * @param proposalId The ID of the proposal
     * @return description The proposal description
     * @return voteCount Number of votes
     * @return deadline Voting deadline
     * @return executed Whether the proposal has been executed
     */
    function getProposal(uint256 proposalId)
        public
        view
        returns (
            string memory description,
            uint256 voteCount,
            uint256 deadline,
            bool executed
        )
    {
        require(proposalId < proposalCount, "Proposal does not exist");
        Proposal storage proposal = proposals[proposalId];

        return (
            proposal.description,
            proposal.voteCount,
            proposal.deadline,
            proposal.executed
        );
    }

    /**
     * @notice Check if an address has voted on a proposal
     * @param proposalId The proposal ID
     * @param voter The address to check
     * @return Whether the address has voted
     */
    function hasVoted(uint256 proposalId, address voter)
        public
        view
        returns (bool)
    {
        require(proposalId < proposalCount, "Proposal does not exist");
        return proposals[proposalId].voters[voter];
    }

    /**
     * @notice Transfer ownership
     * @param newOwner The new owner address
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
    }
}
