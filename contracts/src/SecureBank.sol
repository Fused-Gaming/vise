// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title SecureBank
 * @notice Secure bank contract demonstrating security best practices (Module 5)
 * @dev Demonstrates:
 *      - Reentrancy protection (ReentrancyGuard)
 *      - Access control (Ownable)
 *      - Checks-Effects-Interactions pattern
 *      - Pausable functionality
 *      - Safe ETH transfers
 */
contract SecureBank is ReentrancyGuard, Ownable, Pausable {
    // State variables
    mapping(address => uint256) public balances;
    uint256 public totalDeposits;

    // Configuration
    uint256 public constant MIN_DEPOSIT = 0.001 ether;
    uint256 public constant MAX_DEPOSIT = 100 ether;
    uint256 public withdrawalLimit = 10 ether;

    // Events
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);
    event WithdrawalLimitUpdated(uint256 newLimit);
    event EmergencyWithdrawal(address indexed owner, uint256 amount);

    /**
     * @notice Contract constructor
     */
    constructor() Ownable(msg.sender) {}

    /**
     * @notice Deposit ETH into the bank
     * ✅ SECURE: Input validation
     * ✅ SECURE: Pausable check
     */
    function deposit() public payable whenNotPaused {
        require(msg.value >= MIN_DEPOSIT, "Deposit too small");
        require(msg.value <= MAX_DEPOSIT, "Deposit too large");

        // ✅ SECURE: State updates before external interactions
        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    /**
     * @notice Withdraw funds (SECURE VERSION)
     * @param amount The amount to withdraw
     *
     * ✅ SECURE: Uses ReentrancyGuard
     * ✅ SECURE: Follows Checks-Effects-Interactions pattern
     * ✅ SECURE: Updates state before external call
     */
    function withdraw(uint256 amount) public nonReentrant whenNotPaused {
        // ✅ CHECKS: Validate inputs and conditions
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(amount <= withdrawalLimit, "Exceeds withdrawal limit");

        // ✅ EFFECTS: Update state BEFORE external call
        balances[msg.sender] -= amount;
        totalDeposits -= amount;

        // ✅ INTERACTIONS: External call happens last
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawal(msg.sender, amount, block.timestamp);
    }

    /**
     * @notice Withdraw all funds for a user
     * ✅ SECURE: Protected against reentrancy
     */
    function withdrawAll() public nonReentrant whenNotPaused {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        require(amount <= withdrawalLimit, "Exceeds withdrawal limit");

        // Update state before transfer
        balances[msg.sender] = 0;
        totalDeposits -= amount;

        // Transfer
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawal(msg.sender, amount, block.timestamp);
    }

    /**
     * @notice Set withdrawal limit (owner only)
     * @param newLimit The new withdrawal limit
     *
     * ✅ SECURE: Access control via onlyOwner
     */
    function setWithdrawalLimit(uint256 newLimit) public onlyOwner {
        require(newLimit > 0, "Limit must be greater than 0");
        withdrawalLimit = newLimit;

        emit WithdrawalLimitUpdated(newLimit);
    }

    /**
     * @notice Emergency withdrawal (owner only)
     *
     * ✅ SECURE: Access control via onlyOwner
     * ✅ SECURE: Only works when paused
     */
    function emergencyWithdraw() public onlyOwner whenPaused {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");

        emit EmergencyWithdrawal(msg.sender, contractBalance);

        (bool success, ) = msg.sender.call{value: contractBalance}("");
        require(success, "Transfer failed");
    }

    /**
     * @notice Pause the contract (owner only)
     * ✅ SECURE: Circuit breaker pattern
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @notice Unpause the contract (owner only)
     * ✅ SECURE: Circuit breaker pattern
     */
    function unpause() public onlyOwner {
        _unpause();
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
     * @notice Get detailed account info
     * @param user The user's address
     * @return balance User's balance
     * @return contractBalance Total contract balance
     * @return canWithdraw Whether user has funds to withdraw
     */
    function getAccountInfo(address user)
        public
        view
        returns (
            uint256 balance,
            uint256 contractBalance,
            bool canWithdraw
        )
    {
        balance = balances[user];
        contractBalance = address(this).balance;
        canWithdraw = balance > 0 && balance <= withdrawalLimit && !paused();
    }

    /**
     * @notice Receive function to accept ETH
     * ✅ SECURE: Controlled entry point
     */
    receive() external payable {
        deposit();
    }
}
