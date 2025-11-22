// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld public helloWorld;
    address public owner;
    address public user1;
    address public user2;

    event MessageUpdated(
        string indexed oldMessage,
        string indexed newMessage,
        address indexed updater,
        uint256 timestamp
    );

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);

        helloWorld = new HelloWorld("Hello, VISE!");
    }

    function testInitialState() public {
        assertEq(helloWorld.message(), "Hello, VISE!");
        assertEq(helloWorld.owner(), owner);
        assertEq(helloWorld.updateCount(), 0);
    }

    function testUpdateMessage() public {
        vm.expectEmit(true, true, true, true);
        emit MessageUpdated("Hello, VISE!", "New message", address(this), block.timestamp);

        helloWorld.updateMessage("New message");

        assertEq(helloWorld.message(), "New message");
        assertEq(helloWorld.updateCount(), 1);
    }

    function testUpdateMessageMultipleTimes() public {
        helloWorld.updateMessage("Message 1");
        assertEq(helloWorld.updateCount(), 1);

        helloWorld.updateMessage("Message 2");
        assertEq(helloWorld.updateCount(), 2);

        helloWorld.updateMessage("Message 3");
        assertEq(helloWorld.updateCount(), 3);

        assertEq(helloWorld.message(), "Message 3");
    }

    function testGetMessage() public {
        string memory message = helloWorld.getMessage();
        assertEq(message, "Hello, VISE!");
    }

    function testGetOwner() public {
        address contractOwner = helloWorld.getOwner();
        assertEq(contractOwner, owner);
    }

    function testGetUpdateCount() public {
        uint256 count = helloWorld.getUpdateCount();
        assertEq(count, 0);

        helloWorld.updateMessage("Update 1");
        count = helloWorld.getUpdateCount();
        assertEq(count, 1);
    }

    function testTransferOwnership() public {
        vm.expectEmit(true, true, false, false);
        emit OwnershipTransferred(owner, user1);

        helloWorld.transferOwnership(user1);
        assertEq(helloWorld.owner(), user1);
    }

    function testTransferOwnershipFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert("Only owner can transfer ownership");
        helloWorld.transferOwnership(user2);
    }

    function testTransferOwnershipFailsForZeroAddress() public {
        vm.expectRevert("New owner cannot be zero address");
        helloWorld.transferOwnership(address(0));
    }

    function testMessageUpdateFromDifferentUsers() public {
        vm.prank(user1);
        helloWorld.updateMessage("Message from user1");
        assertEq(helloWorld.message(), "Message from user1");

        vm.prank(user2);
        helloWorld.updateMessage("Message from user2");
        assertEq(helloWorld.message(), "Message from user2");

        assertEq(helloWorld.updateCount(), 2);
    }

    function testFuzzUpdateMessage(string memory newMessage) public {
        helloWorld.updateMessage(newMessage);
        assertEq(helloWorld.message(), newMessage);
        assertEq(helloWorld.updateCount(), 1);
    }
}
