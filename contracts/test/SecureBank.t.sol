// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SecureBank.sol";

contract SecureBankTest is Test {
    SecureBank public bank;
    address public owner;
    address public user1;
    address public user2;

    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);
    event WithdrawalLimitUpdated(uint256 newLimit);
    event EmergencyWithdrawal(address indexed owner, uint256 amount);

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);

        bank = new SecureBank();

        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);
    }

    function testDeposit() public {
        vm.prank(user1);
        vm.expectEmit(true, false, false, false);
        emit Deposit(user1, 1 ether, block.timestamp);

        bank.deposit{value: 1 ether}();

        assertEq(bank.balances(user1), 1 ether);
        assertEq(bank.totalDeposits(), 1 ether);
    }

    function testDepositFailsBelowMinimum() public {
        vm.prank(user1);
        vm.expectRevert("Deposit too small");
        bank.deposit{value: 0.0001 ether}();
    }

    function testDepositFailsAboveMaximum() public {
        vm.prank(user1);
        vm.expectRevert("Deposit too large");
        bank.deposit{value: 101 ether}();
    }

    function testDepositWhenPaused() public {
        bank.pause();

        vm.prank(user1);
        vm.expectRevert();
        bank.deposit{value: 1 ether}();
    }

    function testWithdraw() public {
        vm.startPrank(user1);
        bank.deposit{value: 5 ether}();

        uint256 balanceBefore = user1.balance;

        vm.expectEmit(true, false, false, false);
        emit Withdrawal(user1, 2 ether, block.timestamp);

        bank.withdraw(2 ether);

        assertEq(user1.balance, balanceBefore + 2 ether);
        assertEq(bank.balances(user1), 3 ether);
        assertEq(bank.totalDeposits(), 3 ether);

        vm.stopPrank();
    }

    function testWithdrawFailsInsufficientBalance() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(2 ether);
    }

    function testWithdrawFailsExceedsLimit() public {
        vm.prank(user1);
        bank.deposit{value: 20 ether}();

        vm.prank(user1);
        vm.expectRevert("Exceeds withdrawal limit");
        bank.withdraw(15 ether);
    }

    function testWithdrawFailsZeroAmount() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        vm.prank(user1);
        vm.expectRevert("Amount must be greater than 0");
        bank.withdraw(0);
    }

    function testWithdrawWhenPaused() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        bank.pause();

        vm.prank(user1);
        vm.expectRevert();
        bank.withdraw(1 ether);
    }

    function testWithdrawAll() public {
        vm.startPrank(user1);
        bank.deposit{value: 5 ether}();

        uint256 balanceBefore = user1.balance;

        bank.withdrawAll();

        assertEq(user1.balance, balanceBefore + 5 ether);
        assertEq(bank.balances(user1), 0);
        assertEq(bank.totalDeposits(), 0);

        vm.stopPrank();
    }

    function testWithdrawAllFailsNoBalance() public {
        vm.prank(user1);
        vm.expectRevert("No balance to withdraw");
        bank.withdrawAll();
    }

    function testWithdrawAllFailsExceedsLimit() public {
        vm.prank(user1);
        bank.deposit{value: 15 ether}();

        vm.prank(user1);
        vm.expectRevert("Exceeds withdrawal limit");
        bank.withdrawAll();
    }

    function testSetWithdrawalLimit() public {
        vm.expectEmit(false, false, false, true);
        emit WithdrawalLimitUpdated(20 ether);

        bank.setWithdrawalLimit(20 ether);
        assertEq(bank.withdrawalLimit(), 20 ether);
    }

    function testSetWithdrawalLimitFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        bank.setWithdrawalLimit(20 ether);
    }

    function testSetWithdrawalLimitFailsForZero() public {
        vm.expectRevert("Limit must be greater than 0");
        bank.setWithdrawalLimit(0);
    }

    function testEmergencyWithdraw() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        bank.pause();

        uint256 balanceBefore = owner.balance;

        vm.expectEmit(true, false, false, true);
        emit EmergencyWithdrawal(owner, 10 ether);

        bank.emergencyWithdraw();

        assertEq(owner.balance, balanceBefore + 10 ether);
    }

    function testEmergencyWithdrawFailsForNonOwner() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        bank.pause();

        vm.prank(user1);
        vm.expectRevert();
        bank.emergencyWithdraw();
    }

    function testEmergencyWithdrawFailsWhenNotPaused() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        vm.expectRevert();
        bank.emergencyWithdraw();
    }

    function testPause() public {
        bank.pause();
        assertTrue(bank.paused());
    }

    function testPauseFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        bank.pause();
    }

    function testUnpause() public {
        bank.pause();
        bank.unpause();
        assertFalse(bank.paused());
    }

    function testUnpauseFailsForNonOwner() public {
        bank.pause();

        vm.prank(user1);
        vm.expectRevert();
        bank.unpause();
    }

    function testGetBalance() public {
        vm.prank(user1);
        bank.deposit{value: 5 ether}();

        assertEq(bank.getBalance(user1), 5 ether);
    }

    function testGetContractBalance() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        assertEq(bank.getContractBalance(), 10 ether);
    }

    function testGetAccountInfo() public {
        vm.prank(user1);
        bank.deposit{value: 5 ether}();

        (uint256 balance, uint256 contractBalance, bool canWithdraw) = bank.getAccountInfo(user1);

        assertEq(balance, 5 ether);
        assertEq(contractBalance, 5 ether);
        assertTrue(canWithdraw);
    }

    function testGetAccountInfoWhenPaused() public {
        vm.prank(user1);
        bank.deposit{value: 5 ether}();

        bank.pause();

        (, , bool canWithdraw) = bank.getAccountInfo(user1);
        assertFalse(canWithdraw);
    }

    function testReceiveFunction() public {
        vm.prank(user1);
        (bool success, ) = address(bank).call{value: 1 ether}("");

        assertTrue(success);
        assertEq(bank.balances(user1), 1 ether);
    }

    function testReentrancyProtection() public {
        // Deploy malicious contract
        MaliciousReentrancy attacker = new MaliciousReentrancy(address(bank));
        vm.deal(address(attacker), 10 ether);

        // Attempt attack
        vm.expectRevert();
        attacker.attack{value: 1 ether}();
    }

    function testMultipleUsersDepositsAndWithdrawals() public {
        // User1 deposits
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        // User2 deposits
        vm.prank(user2);
        bank.deposit{value: 5 ether}();

        assertEq(bank.totalDeposits(), 15 ether);

        // User1 withdraws
        vm.prank(user1);
        bank.withdraw(3 ether);

        assertEq(bank.balances(user1), 7 ether);
        assertEq(bank.totalDeposits(), 12 ether);

        // User2 withdraws all
        vm.prank(user2);
        bank.withdrawAll();

        assertEq(bank.balances(user2), 0);
        assertEq(bank.totalDeposits(), 7 ether);
    }

    function testFuzzDeposit(uint96 amount) public {
        vm.assume(amount >= 0.001 ether && amount <= 100 ether);

        vm.prank(user1);
        bank.deposit{value: amount}();

        assertEq(bank.balances(user1), amount);
    }

    function testFuzzWithdraw(uint96 depositAmount, uint96 withdrawAmount) public {
        vm.assume(depositAmount >= 0.001 ether && depositAmount <= 100 ether);
        vm.assume(withdrawAmount > 0 && withdrawAmount <= depositAmount);
        vm.assume(withdrawAmount <= 10 ether); // withdrawal limit

        vm.startPrank(user1);
        bank.deposit{value: depositAmount}();
        bank.withdraw(withdrawAmount);
        vm.stopPrank();

        assertEq(bank.balances(user1), depositAmount - withdrawAmount);
    }
}

// Malicious contract to test reentrancy protection
contract MaliciousReentrancy {
    SecureBank public bank;

    constructor(address _bank) {
        bank = SecureBank(payable(_bank));
    }

    function attack() public payable {
        bank.deposit{value: msg.value}();
        bank.withdraw(msg.value);
    }

    receive() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw(1 ether);
        }
    }
}
