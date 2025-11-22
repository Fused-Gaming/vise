// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableBank.sol";

contract VulnerableBankTest is Test {
    VulnerableBank public bank;
    ReentrancyAttacker public attacker;
    address public user1;
    address public user2;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);
    event AttackStarted(uint256 initialDeposit);
    event ReentrancyExecuted(uint256 count, uint256 balance);
    event AttackCompleted(uint256 stolenAmount);

    function setUp() public {
        user1 = address(0x1);
        user2 = address(0x2);

        bank = new VulnerableBank();

        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);
    }

    function testDeposit() public {
        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit Deposit(user1, 1 ether);

        bank.deposit{value: 1 ether}();

        assertEq(bank.balances(user1), 1 ether);
        assertEq(bank.totalDeposits(), 1 ether);
    }

    function testDepositFailsWithZero() public {
        vm.prank(user1);
        vm.expectRevert("Must deposit something");
        bank.deposit{value: 0}();
    }

    function testWithdraw() public {
        vm.startPrank(user1);
        bank.deposit{value: 5 ether}();

        uint256 balanceBefore = user1.balance;

        vm.expectEmit(true, false, false, true);
        emit Withdrawal(user1, 2 ether);

        bank.withdraw(2 ether);

        assertEq(user1.balance, balanceBefore + 2 ether);
        assertEq(bank.balances(user1), 3 ether);

        vm.stopPrank();
    }

    function testWithdrawFailsInsufficientBalance() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(2 ether);
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

    function testReceiveFunction() public {
        vm.prank(user1);
        (bool success, ) = address(bank).call{value: 1 ether}("");

        assertTrue(success);
        assertEq(bank.balances(user1), 1 ether);
    }

    // ⚠️ VULNERABILITY TEST: Reentrancy Attack
    function testReentrancyAttackSucceeds() public {
        // Setup: Add legitimate deposits from other users
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        vm.prank(user2);
        bank.deposit{value: 10 ether}();

        assertEq(bank.getContractBalance(), 20 ether);

        // Deploy attacker contract
        attacker = new ReentrancyAttacker(address(bank));
        vm.deal(address(attacker), 5 ether);

        console.log("Bank balance before attack:", bank.getContractBalance());
        console.log("Attacker balance before attack:", address(attacker).balance);

        // Execute reentrancy attack
        attacker.attack{value: 1 ether}();

        console.log("Bank balance after attack:", bank.getContractBalance());
        console.log("Attacker balance after attack:", address(attacker).balance);

        // Attacker should have stolen more than they deposited
        // They deposited 1 ether but withdrew it 3 times = 3 ether total
        assertGt(address(attacker).balance, 5 ether);

        // Bank should have less than expected
        assertLt(bank.getContractBalance(), 20 ether);
    }

    function testReentrancyAttackDetails() public {
        // Fund bank with victim deposits
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        // Deploy and fund attacker
        attacker = new ReentrancyAttacker(address(bank));
        vm.deal(address(attacker), 10 ether);

        uint256 bankBalanceBefore = bank.getContractBalance();
        uint256 attackerBalanceBefore = address(attacker).balance;

        // Attack with 1 ether
        vm.expectEmit(false, false, false, true);
        emit AttackStarted(1 ether);

        attacker.attack{value: 1 ether}();

        // Calculate stolen amount
        uint256 stolen = address(attacker).balance - attackerBalanceBefore;

        console.log("Initial bank balance:", bankBalanceBefore);
        console.log("Amount deposited by attacker:", 1 ether);
        console.log("Amount stolen:", stolen);
        console.log("Times reentered:", attacker.attackCount());

        // Attacker deposited 1 ether but withdrew multiple times
        assertEq(stolen, 2 ether); // Withdrew 3 times (3 ether) - deposited (1 ether) = 2 ether profit
    }

    // ⚠️ VULNERABILITY TEST: No Access Control on Emergency Withdraw
    function testEmergencyWithdrawNoAccessControl() public {
        // Fund the bank
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        // Malicious user can drain the bank!
        vm.prank(user2);
        bank.emergencyWithdraw();

        // user2 stole all funds
        assertEq(user2.balance, 110 ether); // 100 initial + 10 stolen
        assertEq(bank.getContractBalance(), 0);
    }

    function testMultipleDepositsAndWithdrawals() public {
        vm.prank(user1);
        bank.deposit{value: 5 ether}();

        vm.prank(user2);
        bank.deposit{value: 3 ether}();

        assertEq(bank.totalDeposits(), 8 ether);

        vm.prank(user1);
        bank.withdraw(2 ether);

        assertEq(bank.balances(user1), 3 ether);
        assertEq(bank.totalDeposits(), 6 ether);
    }

    function testCompleteReentrancyScenario() public {
        // Scenario: Multiple victims deposit, then attacker drains
        vm.prank(user1);
        bank.deposit{value: 5 ether}();

        vm.prank(user2);
        bank.deposit{value: 5 ether}();

        console.log("=== Before Attack ===");
        console.log("User1 balance in bank:", bank.getBalance(user1));
        console.log("User2 balance in bank:", bank.getBalance(user2));
        console.log("Total bank balance:", bank.getContractBalance());

        // Deploy attacker
        attacker = new ReentrancyAttacker(address(bank));
        vm.deal(address(attacker), 10 ether);

        // Execute attack
        attacker.attack{value: 2 ether}();

        console.log("=== After Attack ===");
        console.log("Bank balance:", bank.getContractBalance());
        console.log("Attacker balance:", address(attacker).balance);
        console.log("Attacker profit:", address(attacker).balance - 10 ether);

        // Victims can no longer withdraw their full amounts
        vm.prank(user1);
        if (bank.getContractBalance() >= 5 ether) {
            bank.withdraw(5 ether);
        } else {
            // Bank doesn't have enough funds - user1 loses money
            console.log("User1 cannot withdraw full amount!");
        }
    }
}
