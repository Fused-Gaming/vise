// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title HelloWorld
 * @notice First smart contract demonstration for VISE Module 2
 * @dev Simple contract demonstrating:
 *      - State variables
 *      - Constructor
 *      - Public functions
 *      - Events
 *      - Access tracking
 */
contract HelloWorld {
    // State variables
    string public message;
    address public owner;
    uint256 public updateCount;

    // Events
    event MessageUpdated(
        string indexed oldMessage,
        string indexed newMessage,
        address indexed updater,
        uint256 timestamp
    );

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @notice Contract constructor
     * @param initialMessage The initial message to store
     */
    constructor(string memory initialMessage) {
        message = initialMessage;
        owner = msg.sender;
        updateCount = 0;

        emit MessageUpdated("", initialMessage, msg.sender, block.timestamp);
    }

    /**
     * @notice Update the stored message
     * @param newMessage The new message to store
     */
    function updateMessage(string memory newMessage) public {
        string memory oldMessage = message;
        message = newMessage;
        updateCount++;

        emit MessageUpdated(oldMessage, newMessage, msg.sender, block.timestamp);
    }

    /**
     * @notice Get the current message
     * @return The stored message
     */
    function getMessage() public view returns (string memory) {
        return message;
    }

    /**
     * @notice Get the contract owner
     * @return The owner's address
     */
    function getOwner() public view returns (address) {
        return owner;
    }

    /**
     * @notice Get the number of times the message has been updated
     * @return The update count
     */
    function getUpdateCount() public view returns (uint256) {
        return updateCount;
    }

    /**
     * @notice Transfer ownership to a new address
     * @param newOwner The address of the new owner
     */
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only owner can transfer ownership");
        require(newOwner != address(0), "New owner cannot be zero address");

        address oldOwner = owner;
        owner = newOwner;

        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
