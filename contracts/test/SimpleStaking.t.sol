// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SimpleStaking.sol";

contract SimpleStakingTest is Test {
    SimpleStaking public staking;
    address public user1;
    address public user2;

    event Staked(address indexed user, uint256 amount, uint256 timestamp);
    event Unstaked(address indexed user, uint256 amount, uint256 reward);
    event RewardClaimed(address indexed user, uint256 reward);

    function setUp() public {
        staking = new SimpleStaking();
        user1 = address(0x1);
        user2 = address(0x2);

        // Fund users
        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);

        // Fund contract for rewards
        vm.deal(address(staking), 10 ether);
    }

    function testStake() public {
        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit Staked(user1, 1 ether, block.timestamp);

        staking.stake{value: 1 ether}();

        assertEq(staking.stakedAmount(user1), 1 ether);
        assertEq(staking.totalStaked(), 1 ether);
        assertEq(staking.stakingTimestamp(user1), block.timestamp);
    }

    function testStakeMultipleTimes() public {
        vm.startPrank(user1);

        staking.stake{value: 1 ether}();
        assertEq(staking.stakedAmount(user1), 1 ether);

        // Fast forward 1 day
        vm.warp(block.timestamp + 1 days);

        staking.stake{value: 2 ether}();
        assertEq(staking.stakedAmount(user1), 3 ether);

        vm.stopPrank();
    }

    function testStakeFailsWithZeroValue() public {
        vm.prank(user1);
        vm.expectRevert("Cannot stake 0");
        staking.stake{value: 0}();
    }

    function testCalculateReward() public {
        vm.prank(user1);
        staking.stake{value: 10 ether}();

        // Fast forward 1 year
        vm.warp(block.timestamp + 365 days);

        uint256 reward = staking.calculateReward(user1);

        // 10% APY = 1 ether reward for 10 ether staked for 1 year
        assertEq(reward, 1 ether);
    }

    function testCalculateRewardHalfYear() public {
        vm.prank(user1);
        staking.stake{value: 10 ether}();

        // Fast forward 6 months (182.5 days)
        vm.warp(block.timestamp + 182 days + 12 hours);

        uint256 reward = staking.calculateReward(user1);

        // Approximately 0.5 ether for half year
        assertApproxEqAbs(reward, 0.5 ether, 0.01 ether);
    }

    function testCalculateRewardNoStake() public {
        uint256 reward = staking.calculateReward(user1);
        assertEq(reward, 0);
    }

    function testUnstake() public {
        vm.prank(user1);
        staking.stake{value: 10 ether}();

        // Fast forward 1 year
        vm.warp(block.timestamp + 365 days);

        uint256 balanceBefore = user1.balance;

        vm.prank(user1);
        vm.expectEmit(true, false, false, false);
        emit Unstaked(user1, 10 ether, 1 ether);

        staking.unstake();

        // User should receive stake + reward
        assertEq(user1.balance, balanceBefore + 11 ether);
        assertEq(staking.stakedAmount(user1), 0);
        assertEq(staking.totalStaked(), 0);
    }

    function testUnstakeFailsWithNoStake() public {
        vm.prank(user1);
        vm.expectRevert("No stake to withdraw");
        staking.unstake();
    }

    function testMultipleUsersStaking() public {
        vm.prank(user1);
        staking.stake{value: 5 ether}();

        vm.prank(user2);
        staking.stake{value: 10 ether}();

        assertEq(staking.totalStaked(), 15 ether);

        // Fast forward 1 year
        vm.warp(block.timestamp + 365 days);

        uint256 reward1 = staking.calculateReward(user1);
        uint256 reward2 = staking.calculateReward(user2);

        // user1: 5 ether * 10% = 0.5 ether
        // user2: 10 ether * 10% = 1 ether
        assertEq(reward1, 0.5 ether);
        assertEq(reward2, 1 ether);
    }

    function testGetStakeInfo() public {
        vm.prank(user1);
        staking.stake{value: 10 ether}();

        vm.warp(block.timestamp + 365 days);

        (uint256 amount, uint256 timestamp, uint256 reward) = staking.getStakeInfo(user1);

        assertEq(amount, 10 ether);
        assertEq(timestamp, block.timestamp - 365 days);
        assertEq(reward, 1 ether);
    }

    function testGetContractBalance() public {
        uint256 balance = staking.getContractBalance();
        assertEq(balance, 10 ether); // From setUp funding
    }

    function testReceiveFunction() public {
        uint256 balanceBefore = address(staking).balance;

        vm.prank(user1);
        (bool success, ) = address(staking).call{value: 1 ether}("");

        assertTrue(success);
        assertEq(staking.stakedAmount(user1), 1 ether);
        assertEq(address(staking).balance, balanceBefore + 1 ether);
    }

    function testRewardClaimOnReStake() public {
        // Initial stake
        vm.startPrank(user1);
        staking.stake{value: 10 ether}();

        // Fast forward 1 year
        vm.warp(block.timestamp + 365 days);

        uint256 balanceBefore = user1.balance;

        // Stake again (should claim existing rewards)
        vm.expectEmit(true, false, false, false);
        emit RewardClaimed(user1, 1 ether);

        staking.stake{value: 5 ether}();

        // User should have received the reward
        assertEq(user1.balance, balanceBefore - 5 ether + 1 ether);

        // Total stake should be 15 ether
        assertEq(staking.stakedAmount(user1), 15 ether);

        vm.stopPrank();
    }

    function testFuzzStake(uint96 amount) public {
        vm.assume(amount > 0);
        vm.deal(user1, amount);

        vm.prank(user1);
        staking.stake{value: amount}();

        assertEq(staking.stakedAmount(user1), amount);
        assertEq(staking.totalStaked(), amount);
    }

    function testFuzzCalculateReward(uint96 stakeAmount, uint32 timeElapsed) public {
        vm.assume(stakeAmount > 0);
        vm.assume(timeElapsed > 0);
        vm.deal(user1, stakeAmount);

        vm.prank(user1);
        staking.stake{value: stakeAmount}();

        vm.warp(block.timestamp + timeElapsed);

        uint256 reward = staking.calculateReward(user1);
        uint256 expectedReward = (uint256(stakeAmount) * 10 * timeElapsed) /
            (100 * 365 days);

        assertEq(reward, expectedReward);
    }
}
