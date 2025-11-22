// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorTimelockControl.sol";

/**
 * @title VISEGovernor
 * @notice DAO Governor contract for VISE (Module 4 demonstration)
 * @dev Demonstrates:
 *      - Governance mechanisms
 *      - Proposal creation and voting
 *      - Timelock for security
 *      - Quorum requirements
 */
contract VISEGovernor is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction,
    GovernorTimelockControl
{
    // Proposal tracking
    mapping(uint256 => string) public proposalDescriptions;

    // Events
    event ProposalCreatedWithDetails(
        uint256 proposalId,
        address proposer,
        string description,
        uint256 voteStart,
        uint256 voteEnd
    );

    /**
     * @notice Contract constructor
     * @param _token The governance token
     * @param _timelock The timelock controller
     */
    constructor(IVotes _token, TimelockController _timelock)
        Governor("VISE Governor")
        GovernorSettings(
            1, /* 1 block voting delay */
            50400, /* 1 week voting period (assuming 12s blocks) */
            100e18 /* 100 tokens proposal threshold */
        )
        GovernorVotes(_token)
        GovernorVotesQuorumFraction(4) /* 4% quorum */
        GovernorTimelockControl(_timelock)
    {}

    /**
     * @notice Create a proposal with metadata
     * @param targets Target addresses for proposal calls
     * @param values ETH values for proposal calls
     * @param calldatas Calldata for proposal calls
     * @param description Proposal description
     * @return proposalId The ID of the created proposal
     */
    function propose(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        string memory description
    ) public override(Governor) returns (uint256) {
        uint256 proposalId = super.propose(targets, values, calldatas, description);

        proposalDescriptions[proposalId] = description;

        emit ProposalCreatedWithDetails(
            proposalId,
            msg.sender,
            description,
            proposalSnapshot(proposalId),
            proposalDeadline(proposalId)
        );

        return proposalId;
    }

    /**
     * @notice Get proposal description
     * @param proposalId The proposal ID
     * @return The description
     */
    function getProposalDescription(uint256 proposalId) public view returns (string memory) {
        return proposalDescriptions[proposalId];
    }

    /**
     * @notice Get proposal state with details
     * @param proposalId The proposal ID
     * @return state The current state
     * @return forVotes Votes in favor
     * @return againstVotes Votes against
     * @return abstainVotes Abstain votes
     */
    function getProposalDetails(uint256 proposalId)
        public
        view
        returns (
            ProposalState state,
            uint256 forVotes,
            uint256 againstVotes,
            uint256 abstainVotes
        )
    {
        state = state(proposalId);
        (againstVotes, forVotes, abstainVotes) = proposalVotes(proposalId);
    }

    // Required overrides

    function votingDelay() public view override(Governor, GovernorSettings) returns (uint256) {
        return super.votingDelay();
    }

    function votingPeriod() public view override(Governor, GovernorSettings) returns (uint256) {
        return super.votingPeriod();
    }

    function quorum(uint256 blockNumber)
        public
        view
        override(Governor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function state(uint256 proposalId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (ProposalState)
    {
        return super.state(proposalId);
    }

    function proposalNeedsQueuing(uint256 proposalId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (bool)
    {
        return super.proposalNeedsQueuing(proposalId);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }

    function _queueOperations(
        uint256 proposalId,
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override(Governor, GovernorTimelockControl) returns (uint48) {
        return super._queueOperations(proposalId, targets, values, calldatas, descriptionHash);
    }

    function _executeOperations(
        uint256 proposalId,
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override(Governor, GovernorTimelockControl) {
        super._executeOperations(proposalId, targets, values, calldatas, descriptionHash);
    }

    function _cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override(Governor, GovernorTimelockControl) returns (uint256) {
        return super._cancel(targets, values, calldatas, descriptionHash);
    }

    function _executor()
        internal
        view
        override(Governor, GovernorTimelockControl)
        returns (address)
    {
        return super._executor();
    }
}
