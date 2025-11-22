// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SimpleVoting.sol";

contract SimpleVotingTest is Test {
    SimpleVoting public voting;
    address public owner;
    address public voter1;
    address public voter2;
    address public voter3;

    event ProposalCreated(uint256 indexed proposalId, string description, uint256 deadline);
    event VoteCast(uint256 indexed proposalId, address indexed voter);
    event ProposalExecuted(uint256 indexed proposalId);

    function setUp() public {
        owner = address(this);
        voter1 = address(0x1);
        voter2 = address(0x2);
        voter3 = address(0x3);

        voting = new SimpleVoting();
    }

    function testInitialState() public {
        assertEq(voting.owner(), owner);
        assertEq(voting.proposalCount(), 0);
    }

    function testCreateProposal() public {
        vm.expectEmit(true, false, false, true);
        emit ProposalCreated(0, "Test Proposal", block.timestamp + 7 days);

        voting.createProposal("Test Proposal", 7);

        assertEq(voting.proposalCount(), 1);

        (string memory description, uint256 voteCount, uint256 deadline, bool executed) =
            voting.getProposal(0);

        assertEq(description, "Test Proposal");
        assertEq(voteCount, 0);
        assertEq(deadline, block.timestamp + 7 days);
        assertEq(executed, false);
    }

    function testCreateProposalFailsForNonOwner() public {
        vm.prank(voter1);
        vm.expectRevert("Only owner can call this function");
        voting.createProposal("Test", 7);
    }

    function testVote() public {
        voting.createProposal("Test Proposal", 7);

        vm.prank(voter1);
        vm.expectEmit(true, true, false, false);
        emit VoteCast(0, voter1);

        voting.vote(0);

        (, uint256 voteCount, , ) = voting.getProposal(0);
        assertEq(voteCount, 1);
        assertTrue(voting.hasVoted(0, voter1));
    }

    function testMultipleVotes() public {
        voting.createProposal("Test Proposal", 7);

        vm.prank(voter1);
        voting.vote(0);

        vm.prank(voter2);
        voting.vote(0);

        vm.prank(voter3);
        voting.vote(0);

        (, uint256 voteCount, , ) = voting.getProposal(0);
        assertEq(voteCount, 3);
    }

    function testVoteFailsForNonExistentProposal() public {
        vm.prank(voter1);
        vm.expectRevert("Proposal does not exist");
        voting.vote(0);
    }

    function testVoteFailsWhenAlreadyVoted() public {
        voting.createProposal("Test Proposal", 7);

        vm.prank(voter1);
        voting.vote(0);

        vm.prank(voter1);
        vm.expectRevert("Already voted");
        voting.vote(0);
    }

    function testVoteFailsAfterDeadline() public {
        voting.createProposal("Test Proposal", 7);

        // Fast forward time beyond deadline
        vm.warp(block.timestamp + 8 days);

        vm.prank(voter1);
        vm.expectRevert("Voting has ended");
        voting.vote(0);
    }

    function testVoteFailsOnExecutedProposal() public {
        voting.createProposal("Test Proposal", 7);

        // Fast forward past deadline
        vm.warp(block.timestamp + 8 days);

        // Execute proposal
        voting.executeProposal(0);

        // Try to vote
        vm.prank(voter1);
        vm.expectRevert("Proposal already executed");
        voting.vote(0);
    }

    function testExecuteProposal() public {
        voting.createProposal("Test Proposal", 7);

        // Fast forward past deadline
        vm.warp(block.timestamp + 8 days);

        vm.expectEmit(true, false, false, false);
        emit ProposalExecuted(0);

        voting.executeProposal(0);

        (, , , bool executed) = voting.getProposal(0);
        assertTrue(executed);
    }

    function testExecuteProposalFailsForNonOwner() public {
        voting.createProposal("Test Proposal", 7);
        vm.warp(block.timestamp + 8 days);

        vm.prank(voter1);
        vm.expectRevert("Only owner can call this function");
        voting.executeProposal(0);
    }

    function testExecuteProposalFailsBeforeDeadline() public {
        voting.createProposal("Test Proposal", 7);

        vm.expectRevert("Voting still ongoing");
        voting.executeProposal(0);
    }

    function testExecuteProposalFailsWhenAlreadyExecuted() public {
        voting.createProposal("Test Proposal", 7);
        vm.warp(block.timestamp + 8 days);

        voting.executeProposal(0);

        vm.expectRevert("Already executed");
        voting.executeProposal(0);
    }

    function testTransferOwnership() public {
        voting.transferOwnership(voter1);
        assertEq(voting.owner(), voter1);
    }

    function testTransferOwnershipFailsForNonOwner() public {
        vm.prank(voter1);
        vm.expectRevert("Only owner can call this function");
        voting.transferOwnership(voter2);
    }

    function testTransferOwnershipFailsForZeroAddress() public {
        vm.expectRevert("New owner cannot be zero address");
        voting.transferOwnership(address(0));
    }

    function testHasVoted() public {
        voting.createProposal("Test Proposal", 7);

        assertFalse(voting.hasVoted(0, voter1));

        vm.prank(voter1);
        voting.vote(0);

        assertTrue(voting.hasVoted(0, voter1));
        assertFalse(voting.hasVoted(0, voter2));
    }

    function testCompleteProposalLifecycle() public {
        // Create proposal
        voting.createProposal("Upgrade Protocol", 7);

        // Multiple votes
        vm.prank(voter1);
        voting.vote(0);

        vm.prank(voter2);
        voting.vote(0);

        vm.prank(voter3);
        voting.vote(0);

        // Check votes
        (, uint256 voteCount, , ) = voting.getProposal(0);
        assertEq(voteCount, 3);

        // Fast forward
        vm.warp(block.timestamp + 8 days);

        // Execute
        voting.executeProposal(0);

        // Verify execution
        (, , , bool executed) = voting.getProposal(0);
        assertTrue(executed);
    }
}
