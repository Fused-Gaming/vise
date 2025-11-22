// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VISEAchievementNFT.sol";

contract VISEAchievementNFTTest is Test {
    VISEAchievementNFT public achievementNFT;
    address public owner;
    address public educator1;
    address public educator2;
    address public student1;
    address public student2;

    event AchievementMinted(
        address indexed recipient,
        uint256 indexed tokenId,
        uint256 moduleId,
        VISEAchievementNFT.AchievementType achievementType
    );

    event EducatorAdded(address indexed educator);
    event EducatorRemoved(address indexed educator);

    function setUp() public {
        owner = address(this);
        educator1 = address(0x1);
        educator2 = address(0x2);
        student1 = address(0x3);
        student2 = address(0x4);

        achievementNFT = new VISEAchievementNFT("ipfs://base-uri/");
    }

    function testInitialState() public {
        assertEq(achievementNFT.owner(), owner);
        assertTrue(achievementNFT.educators(owner)); // Owner is default educator
        assertEq(achievementNFT.totalSupply(), 0);
    }

    function testMintAchievement() public {
        vm.expectEmit(true, true, false, true);
        emit AchievementMinted(
            student1,
            1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION
        );

        uint256 tokenId = achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://achievement-metadata"
        );

        assertEq(tokenId, 1);
        assertEq(achievementNFT.ownerOf(tokenId), student1);
        assertEq(achievementNFT.totalSupply(), 1);

        // Check achievement data
        (
            uint256 moduleId,
            VISEAchievementNFT.AchievementType achievementType,
            uint256 timestamp,
            string memory metadata
        ) = achievementNFT.getAchievement(tokenId);

        assertEq(moduleId, 1);
        assertTrue(achievementType == VISEAchievementNFT.AchievementType.MODULE_COMPLETION);
        assertEq(timestamp, block.timestamp);
        assertEq(metadata, "ipfs://achievement-metadata");
    }

    function testMintAchievementFailsForNonEducator() public {
        vm.prank(student1);
        vm.expectRevert("Only educators can perform this action");
        achievementNFT.mintAchievement(
            student2,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://metadata"
        );
    }

    function testMintAchievementFailsForZeroAddress() public {
        vm.expectRevert("Cannot mint to zero address");
        achievementNFT.mintAchievement(
            address(0),
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://metadata"
        );
    }

    function testModuleCompletionTracking() public {
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://metadata"
        );

        assertTrue(achievementNFT.hasCompletedModule(student1, 1));
        assertFalse(achievementNFT.hasCompletedModule(student1, 2));
    }

    function testGetUserAchievements() public {
        // Mint multiple achievements
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://module1"
        );

        achievementNFT.mintAchievement(
            student1,
            2,
            VISEAchievementNFT.AchievementType.PERFECT_SCORE,
            "ipfs://perfect"
        );

        achievementNFT.mintAchievement(
            student1,
            3,
            VISEAchievementNFT.AchievementType.EARLY_COMPLETION,
            "ipfs://early"
        );

        uint256[] memory achievements = achievementNFT.getUserAchievements(student1);

        assertEq(achievements.length, 3);
        assertEq(achievements[0], 1);
        assertEq(achievements[1], 2);
        assertEq(achievements[2], 3);
    }

    function testBatchMintAchievements() public {
        address[] memory recipients = new address[](3);
        recipients[0] = student1;
        recipients[1] = student2;
        recipients[2] = address(0x5);

        achievementNFT.batchMintAchievements(
            recipients,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://batch-metadata"
        );

        assertEq(achievementNFT.totalSupply(), 3);
        assertEq(achievementNFT.getUserAchievements(student1).length, 1);
        assertEq(achievementNFT.getUserAchievements(student2).length, 1);
    }

    function testAddEducator() public {
        vm.expectEmit(true, false, false, false);
        emit EducatorAdded(educator1);

        achievementNFT.addEducator(educator1);

        assertTrue(achievementNFT.educators(educator1));
    }

    function testAddEducatorFailsForNonOwner() public {
        vm.prank(student1);
        vm.expectRevert();
        achievementNFT.addEducator(educator1);
    }

    function testAddEducatorFailsForZeroAddress() public {
        vm.expectRevert("Invalid educator address");
        achievementNFT.addEducator(address(0));
    }

    function testAddEducatorFailsIfAlreadyEducator() public {
        achievementNFT.addEducator(educator1);

        vm.expectRevert("Already an educator");
        achievementNFT.addEducator(educator1);
    }

    function testRemoveEducator() public {
        achievementNFT.addEducator(educator1);

        vm.expectEmit(true, false, false, false);
        emit EducatorRemoved(educator1);

        achievementNFT.removeEducator(educator1);

        assertFalse(achievementNFT.educators(educator1));
    }

    function testRemoveEducatorFailsForOwner() public {
        vm.expectRevert("Cannot remove owner");
        achievementNFT.removeEducator(owner);
    }

    function testRemoveEducatorFailsIfNotEducator() public {
        vm.expectRevert("Not an educator");
        achievementNFT.removeEducator(educator1);
    }

    function testEducatorCanMint() public {
        achievementNFT.addEducator(educator1);

        vm.prank(educator1);
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://metadata"
        );

        assertEq(achievementNFT.totalSupply(), 1);
    }

    function testSetBaseURI() public {
        achievementNFT.setBaseURI("ipfs://new-base-uri/");

        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "metadata.json"
        );

        string memory tokenURI = achievementNFT.tokenURI(1);
        // Should start with new base URI
        assertEq(
            keccak256(abi.encodePacked(tokenURI)),
            keccak256(abi.encodePacked("ipfs://new-base-uri/1"))
        );
    }

    function testSoulboundNonTransferable() public {
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://metadata"
        );

        // Try to transfer - should fail
        vm.prank(student1);
        vm.expectRevert("Soulbound: Transfer not allowed");
        achievementNFT.transferFrom(student1, student2, 1);
    }

    function testSoulboundNonTransferableWithSafeTransfer() public {
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://metadata"
        );

        // Try to safeTransfer - should fail
        vm.prank(student1);
        vm.expectRevert("Soulbound: Transfer not allowed");
        achievementNFT.safeTransferFrom(student1, student2, 1);
    }

    function testDifferentAchievementTypes() public {
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://completion"
        );

        achievementNFT.mintAchievement(
            student1,
            2,
            VISEAchievementNFT.AchievementType.PERFECT_SCORE,
            "ipfs://perfect"
        );

        achievementNFT.mintAchievement(
            student1,
            3,
            VISEAchievementNFT.AchievementType.EARLY_COMPLETION,
            "ipfs://early"
        );

        achievementNFT.mintAchievement(
            student1,
            4,
            VISEAchievementNFT.AchievementType.COMMUNITY_CONTRIBUTION,
            "ipfs://community"
        );

        achievementNFT.mintAchievement(
            student1,
            5,
            VISEAchievementNFT.AchievementType.SPECIAL_RECOGNITION,
            "ipfs://special"
        );

        assertEq(achievementNFT.totalSupply(), 5);

        // Verify each type
        (, VISEAchievementNFT.AchievementType type1, , ) = achievementNFT.getAchievement(1);
        assertTrue(type1 == VISEAchievementNFT.AchievementType.MODULE_COMPLETION);

        (, VISEAchievementNFT.AchievementType type2, , ) = achievementNFT.getAchievement(2);
        assertTrue(type2 == VISEAchievementNFT.AchievementType.PERFECT_SCORE);
    }

    function testMultipleStudentsMultipleModules() public {
        // Student1 completes modules 1, 2, 3
        achievementNFT.mintAchievement(
            student1,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://s1m1"
        );
        achievementNFT.mintAchievement(
            student1,
            2,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://s1m2"
        );
        achievementNFT.mintAchievement(
            student1,
            3,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://s1m3"
        );

        // Student2 completes modules 1, 2
        achievementNFT.mintAchievement(
            student2,
            1,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://s2m1"
        );
        achievementNFT.mintAchievement(
            student2,
            2,
            VISEAchievementNFT.AchievementType.MODULE_COMPLETION,
            "ipfs://s2m2"
        );

        // Verify student1
        assertTrue(achievementNFT.hasCompletedModule(student1, 1));
        assertTrue(achievementNFT.hasCompletedModule(student1, 2));
        assertTrue(achievementNFT.hasCompletedModule(student1, 3));
        assertEq(achievementNFT.getUserAchievements(student1).length, 3);

        // Verify student2
        assertTrue(achievementNFT.hasCompletedModule(student2, 1));
        assertTrue(achievementNFT.hasCompletedModule(student2, 2));
        assertFalse(achievementNFT.hasCompletedModule(student2, 3));
        assertEq(achievementNFT.getUserAchievements(student2).length, 2);
    }
}
