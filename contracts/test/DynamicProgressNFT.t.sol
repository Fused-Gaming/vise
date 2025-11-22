// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/DynamicProgressNFT.sol";

contract DynamicProgressNFTTest is Test {
    DynamicProgressNFT public progressNFT;
    address public owner;
    address public student1;
    address public student2;

    event NFTMinted(address indexed student, uint256 indexed tokenId);
    event ProgressUpdated(
        uint256 indexed tokenId,
        uint256 modulesCompleted,
        uint256 totalScore,
        uint256 level
    );

    function setUp() public {
        owner = address(this);
        student1 = address(0x1);
        student2 = address(0x2);

        progressNFT = new DynamicProgressNFT();
    }

    function testInitialState() public {
        assertEq(progressNFT.owner(), owner);
    }

    function testMintProgressNFT() public {
        vm.expectEmit(true, true, false, false);
        emit NFTMinted(student1, 1);

        uint256 tokenId = progressNFT.mintProgressNFT(student1);

        assertEq(tokenId, 1);
        assertEq(progressNFT.ownerOf(tokenId), student1);
        assertEq(progressNFT.studentTokenId(student1), 1);

        // Check initial progress
        (uint256 modules, uint256 score, uint256 level, uint256 lastUpdate) =
            progressNFT.getProgress(student1);

        assertEq(modules, 0);
        assertEq(score, 0);
        assertEq(level, 1);
        assertEq(lastUpdate, block.timestamp);
    }

    function testMintProgressNFTFailsForZeroAddress() public {
        vm.expectRevert("Cannot mint to zero address");
        progressNFT.mintProgressNFT(address(0));
    }

    function testMintProgressNFTFailsIfAlreadyHasNFT() public {
        progressNFT.mintProgressNFT(student1);

        vm.expectRevert("Student already has NFT");
        progressNFT.mintProgressNFT(student1);
    }

    function testMintProgressNFTFailsForNonOwner() public {
        vm.prank(student1);
        vm.expectRevert();
        progressNFT.mintProgressNFT(student2);
    }

    function testUpdateProgress() public {
        progressNFT.mintProgressNFT(student1);

        vm.expectEmit(true, false, false, true);
        emit ProgressUpdated(1, 2, 50, 1);

        progressNFT.updateProgress(student1, 2, 50);

        (uint256 modules, uint256 score, uint256 level, ) = progressNFT.getProgress(student1);

        assertEq(modules, 2);
        assertEq(score, 50);
        assertEq(level, 1);
    }

    function testUpdateProgressLevelUp() public {
        progressNFT.mintProgressNFT(student1);

        // Add 150 points - should reach level 2
        progressNFT.updateProgress(student1, 3, 150);

        (, uint256 score, uint256 level, ) = progressNFT.getProgress(student1);

        assertEq(score, 150);
        assertEq(level, 2); // 150 / 100 + 1 = 2
    }

    function testUpdateProgressMultipleLevelUps() public {
        progressNFT.mintProgressNFT(student1);

        // Add 350 points - should reach level 4
        progressNFT.updateProgress(student1, 5, 350);

        (, uint256 score, uint256 level, ) = progressNFT.getProgress(student1);

        assertEq(score, 350);
        assertEq(level, 4); // 350 / 100 + 1 = 4
    }

    function testUpdateProgressFailsForNonOwner() public {
        progressNFT.mintProgressNFT(student1);

        vm.prank(student1);
        vm.expectRevert();
        progressNFT.updateProgress(student1, 1, 50);
    }

    function testUpdateProgressFailsWithoutNFT() public {
        vm.expectRevert("Student does not have NFT");
        progressNFT.updateProgress(student1, 1, 50);
    }

    function testUpdateProgressFailsInvalidModuleCount() public {
        progressNFT.mintProgressNFT(student1);

        vm.expectRevert("Invalid module count");
        progressNFT.updateProgress(student1, 6, 50); // MAX_MODULES is 5
    }

    function testGenerateSVG() public {
        progressNFT.mintProgressNFT(student1);
        progressNFT.updateProgress(student1, 3, 150);

        string memory svg = progressNFT.generateSVG(1);

        // Basic checks that SVG contains expected elements
        assertTrue(bytes(svg).length > 0);
        // SVG should contain typical SVG tags
        assertGt(
            bytes(svg).length,
            100,
            "SVG should have substantial content"
        );
    }

    function testTokenURI() public {
        progressNFT.mintProgressNFT(student1);
        progressNFT.updateProgress(student1, 2, 100);

        string memory uri = progressNFT.tokenURI(1);

        // Should be a data URI
        assertTrue(bytes(uri).length > 0);
        // Check it starts with data URI prefix
        assertEq(
            keccak256(abi.encodePacked(substring(uri, 0, 29))),
            keccak256(abi.encodePacked("data:application/json;base64,"))
        );
    }

    function testTokenURIFailsForNonExistentToken() public {
        vm.expectRevert("Token does not exist");
        progressNFT.tokenURI(1);
    }

    function testGetProgress() public {
        progressNFT.mintProgressNFT(student1);
        progressNFT.updateProgress(student1, 3, 250);

        (uint256 modules, uint256 score, uint256 level, uint256 lastUpdate) =
            progressNFT.getProgress(student1);

        assertEq(modules, 3);
        assertEq(score, 250);
        assertEq(level, 3); // 250 / 100 + 1 = 3
        assertEq(lastUpdate, block.timestamp);
    }

    function testGetProgressFailsWithoutNFT() public {
        vm.expectRevert("Student does not have NFT");
        progressNFT.getProgress(student1);
    }

    function testGetStudentTokenId() public {
        assertEq(progressNFT.getStudentTokenId(student1), 0);

        progressNFT.mintProgressNFT(student1);

        assertEq(progressNFT.getStudentTokenId(student1), 1);
    }

    function testSoulboundNonTransferable() public {
        progressNFT.mintProgressNFT(student1);

        vm.prank(student1);
        vm.expectRevert("Soulbound: Transfer not allowed");
        progressNFT.transferFrom(student1, student2, 1);
    }

    function testMultipleStudentsProgress() public {
        // Mint for both students
        progressNFT.mintProgressNFT(student1);
        progressNFT.mintProgressNFT(student2);

        // Update student1 - advanced
        progressNFT.updateProgress(student1, 5, 400);

        // Update student2 - beginner
        progressNFT.updateProgress(student2, 2, 80);

        // Check student1
        (uint256 modules1, uint256 score1, uint256 level1, ) = progressNFT.getProgress(student1);
        assertEq(modules1, 5);
        assertEq(score1, 400);
        assertEq(level1, 5);

        // Check student2
        (uint256 modules2, uint256 score2, uint256 level2, ) = progressNFT.getProgress(student2);
        assertEq(modules2, 2);
        assertEq(score2, 80);
        assertEq(level2, 1);
    }

    function testProgressUpdatesTimestamp() public {
        progressNFT.mintProgressNFT(student1);

        uint256 initialTime = block.timestamp;
        progressNFT.updateProgress(student1, 1, 50);

        // Fast forward time
        vm.warp(block.timestamp + 1 days);

        progressNFT.updateProgress(student1, 2, 30);

        (, , , uint256 lastUpdate) = progressNFT.getProgress(student1);

        assertEq(lastUpdate, initialTime + 1 days);
        assertGt(lastUpdate, initialTime);
    }

    function testIncrementalProgress() public {
        progressNFT.mintProgressNFT(student1);

        // Module 1 completed
        progressNFT.updateProgress(student1, 1, 80);
        (uint256 modules, uint256 score, uint256 level, ) = progressNFT.getProgress(student1);
        assertEq(modules, 1);
        assertEq(score, 80);
        assertEq(level, 1);

        // Module 2 completed (cumulative score)
        progressNFT.updateProgress(student1, 2, 30);
        (modules, score, level, ) = progressNFT.getProgress(student1);
        assertEq(modules, 2);
        assertEq(score, 110); // 80 + 30
        assertEq(level, 2); // 110 / 100 + 1 = 2

        // Module 3 completed
        progressNFT.updateProgress(student1, 3, 50);
        (modules, score, level, ) = progressNFT.getProgress(student1);
        assertEq(modules, 3);
        assertEq(score, 160); // 110 + 50
        assertEq(level, 2); // 160 / 100 + 1 = 2
    }

    function testMaxModulesCompletion() public {
        progressNFT.mintProgressNFT(student1);

        // Complete all 5 modules
        progressNFT.updateProgress(student1, 5, 500);

        (uint256 modules, uint256 score, uint256 level, ) = progressNFT.getProgress(student1);

        assertEq(modules, 5);
        assertEq(score, 500);
        assertEq(level, 6); // 500 / 100 + 1 = 6
    }

    function testFuzzUpdateProgress(uint8 moduleCount, uint16 scoreAmount) public {
        vm.assume(moduleCount <= 5);

        progressNFT.mintProgressNFT(student1);

        progressNFT.updateProgress(student1, moduleCount, scoreAmount);

        (uint256 modules, uint256 score, uint256 level, ) = progressNFT.getProgress(student1);

        assertEq(modules, moduleCount);
        assertEq(score, scoreAmount);
        assertEq(level, (scoreAmount / 100) + 1);
    }

    // Helper function to extract substring
    function substring(
        string memory str,
        uint256 startIndex,
        uint256 endIndex
    ) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }
}
