// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VISEGovernanceToken.sol";

contract VISEGovernanceTokenTest is Test {
    VISEGovernanceToken public token;
    address public owner;
    address public educator1;
    address public user1;
    address public user2;

    event AirdropClaimed(address indexed recipient, uint256 amount);
    event EducatorAllocationSet(address indexed educator, uint256 amount);
    event TokensMinted(address indexed to, uint256 amount);
    event AirdropStatusChanged(bool active);

    function setUp() public {
        owner = address(this);
        educator1 = address(0x1);
        user1 = address(0x2);
        user2 = address(0x3);

        token = new VISEGovernanceToken();
    }

    function testInitialState() public {
        assertEq(token.name(), "VISE Governance Token");
        assertEq(token.symbol(), "VISE");
        assertEq(token.totalSupply(), 1_000_000 * 10**18);
        assertEq(token.balanceOf(owner), 1_000_000 * 10**18);
        assertTrue(token.airdropActive());
        assertEq(token.airdropAmount(), 100 * 10**18);
    }

    function testClaimAirdrop() public {
        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit AirdropClaimed(user1, 100 * 10**18);

        token.claimAirdrop();

        assertEq(token.balanceOf(user1), 100 * 10**18);
        assertTrue(token.hasAirdropClaimed(user1));
    }

    function testClaimAirdropFailsIfAlreadyClaimed() public {
        vm.startPrank(user1);
        token.claimAirdrop();

        vm.expectRevert("Already claimed airdrop");
        token.claimAirdrop();
        vm.stopPrank();
    }

    function testClaimAirdropFailsWhenInactive() public {
        token.setAirdropActive(false);

        vm.prank(user1);
        vm.expectRevert("Airdrop is not active");
        token.claimAirdrop();
    }

    function testMultipleUsersClaimAirdrop() public {
        vm.prank(user1);
        token.claimAirdrop();

        vm.prank(user2);
        token.claimAirdrop();

        assertEq(token.balanceOf(user1), 100 * 10**18);
        assertEq(token.balanceOf(user2), 100 * 10**18);
    }

    function testSetEducatorAllocation() public {
        vm.expectEmit(true, false, false, true);
        emit EducatorAllocationSet(educator1, 1000 * 10**18);

        token.setEducatorAllocation(educator1, 1000 * 10**18);

        assertEq(token.educatorAllocations(educator1), 1000 * 10**18);
    }

    function testSetEducatorAllocationFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        token.setEducatorAllocation(educator1, 1000 * 10**18);
    }

    function testSetEducatorAllocationFailsForZeroAddress() public {
        vm.expectRevert("Invalid educator address");
        token.setEducatorAllocation(address(0), 1000 * 10**18);
    }

    function testClaimEducatorAllocation() public {
        token.setEducatorAllocation(educator1, 5000 * 10**18);

        vm.prank(educator1);
        vm.expectEmit(true, false, false, true);
        emit TokensMinted(educator1, 5000 * 10**18);

        token.claimEducatorAllocation();

        assertEq(token.balanceOf(educator1), 5000 * 10**18);
        assertEq(token.educatorAllocations(educator1), 0);
    }

    function testClaimEducatorAllocationFailsWithoutAllocation() public {
        vm.prank(educator1);
        vm.expectRevert("No allocation available");
        token.claimEducatorAllocation();
    }

    function testMint() public {
        vm.expectEmit(true, false, false, true);
        emit TokensMinted(user1, 5000 * 10**18);

        token.mint(user1, 5000 * 10**18);

        assertEq(token.balanceOf(user1), 5000 * 10**18);
    }

    function testMintFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        token.mint(user2, 1000 * 10**18);
    }

    function testMintFailsExceedingMaxSupply() public {
        // Try to mint more than max supply
        vm.expectRevert("Would exceed max supply");
        token.mint(user1, 10_000_000 * 10**18); // Max is 10M, already minted 1M
    }

    function testSetAirdropActive() public {
        vm.expectEmit(false, false, false, true);
        emit AirdropStatusChanged(false);

        token.setAirdropActive(false);

        assertFalse(token.airdropActive());
    }

    function testSetAirdropActiveFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        token.setAirdropActive(false);
    }

    function testSetAirdropAmount() public {
        token.setAirdropAmount(200 * 10**18);

        assertEq(token.airdropAmount(), 200 * 10**18);

        // New claims should use new amount
        vm.prank(user1);
        token.claimAirdrop();

        assertEq(token.balanceOf(user1), 200 * 10**18);
    }

    function testSetAirdropAmountFailsForZero() public {
        vm.expectRevert("Amount must be greater than 0");
        token.setAirdropAmount(0);
    }

    function testSetAirdropAmountFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        token.setAirdropAmount(200 * 10**18);
    }

    function testGetVotingPower() public {
        // Mint tokens to user1
        token.mint(user1, 1000 * 10**18);

        // User needs to delegate to themselves to have voting power
        vm.prank(user1);
        token.delegate(user1);

        assertEq(token.getVotingPower(user1), 1000 * 10**18);
    }

    function testVotingPowerRequiresDelegation() public {
        token.mint(user1, 1000 * 10**18);

        // Without delegation, voting power is 0
        assertEq(token.getVotingPower(user1), 0);

        // After delegation
        vm.prank(user1);
        token.delegate(user1);

        assertEq(token.getVotingPower(user1), 1000 * 10**18);
    }

    function testDelegateToOther() public {
        token.mint(user1, 1000 * 10**18);

        // User1 delegates to user2
        vm.prank(user1);
        token.delegate(user2);

        assertEq(token.getVotingPower(user1), 0);
        assertEq(token.getVotingPower(user2), 1000 * 10**18);
    }

    function testTransfer() public {
        token.mint(user1, 1000 * 10**18);

        vm.prank(user1);
        token.transfer(user2, 500 * 10**18);

        assertEq(token.balanceOf(user1), 500 * 10**18);
        assertEq(token.balanceOf(user2), 500 * 10**18);
    }

    function testPermit() public {
        uint256 privateKey = 0xA11CE;
        address alice = vm.addr(privateKey);

        token.mint(alice, 1000 * 10**18);

        // Create permit
        uint256 deadline = block.timestamp + 1 hours;
        uint256 nonce = token.nonces(alice);

        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                alice,
                user1,
                500 * 10**18,
                nonce,
                deadline
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                token.DOMAIN_SEPARATOR(),
                structHash
            )
        );

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);

        // Execute permit
        token.permit(alice, user1, 500 * 10**18, deadline, v, r, s);

        assertEq(token.allowance(alice, user1), 500 * 10**18);
    }

    function testHasAirdropClaimed() public {
        assertFalse(token.hasAirdropClaimed(user1));

        vm.prank(user1);
        token.claimAirdrop();

        assertTrue(token.hasAirdropClaimed(user1));
    }

    function testCompleteTokenDistributionFlow() public {
        // Owner sets up educator allocation
        token.setEducatorAllocation(educator1, 10000 * 10**18);

        // Educator claims
        vm.prank(educator1);
        token.claimEducatorAllocation();

        // Students claim airdrops
        vm.prank(user1);
        token.claimAirdrop();

        vm.prank(user2);
        token.claimAirdrop();

        // Verify balances
        assertEq(token.balanceOf(educator1), 10000 * 10**18);
        assertEq(token.balanceOf(user1), 100 * 10**18);
        assertEq(token.balanceOf(user2), 100 * 10**18);

        // Total supply should be initial + minted
        uint256 expectedSupply = 1_000_000 * 10**18 + 10000 * 10**18 + 200 * 10**18;
        assertEq(token.totalSupply(), expectedSupply);
    }

    function testFuzzMint(uint96 amount) public {
        vm.assume(amount <= 9_000_000 * 10**18); // Leave room under max supply

        token.mint(user1, amount);

        assertEq(token.balanceOf(user1), amount);
    }

    function testFuzzAirdropAmount(uint96 amount) public {
        vm.assume(amount > 0 && amount <= 1000 * 10**18);

        token.setAirdropAmount(amount);

        vm.prank(user1);
        token.claimAirdrop();

        assertEq(token.balanceOf(user1), amount);
    }
}
