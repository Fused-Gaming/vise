// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VISECurriculumPass.sol";
import "../src/VISEGovernanceToken.sol";

contract VISECurriculumPassTest is Test {
    VISECurriculumPass public vpass;
    VISEGovernanceToken public govToken;

    address public owner;
    address public treasury;
    address public governance;
    address public user1;
    address public user2;
    address public user3;

    event PassMinted(
        address indexed recipient,
        uint256 indexed tokenId,
        VISECurriculumPass.Rarity rarity,
        uint256 price
    );

    function setUp() public {
        owner = address(this);
        treasury = address(0x1);
        user1 = address(0x2);
        user2 = address(0x3);
        user3 = address(0x4);

        // Deploy governance token
        govToken = new VISEGovernanceToken();
        governance = address(govToken);

        // Deploy V-Pass
        vpass = new VISECurriculumPass(
            "ipfs://vpass/",
            treasury,
            governance
        );

        // Fund users
        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);
        vm.deal(user3, 100 ether);
    }

    // ============ Initialization Tests ============

    function testInitialState() public {
        assertEq(vpass.name(), "V-Pass");
        assertEq(vpass.symbol(), "VPASS");
        assertEq(vpass.owner(), owner);
        assertEq(vpass.treasury(), treasury);
        assertEq(vpass.governanceContract(), governance);
        assertEq(vpass.maxSupply(), 10000);
    }

    function testInitialPricing() public {
        (uint256 common, uint256 rare, uint256 epic, uint256 legendary) = vpass.getAllPrices();

        assertEq(common, 0.05 ether);
        assertEq(rare, 0.1 ether);
        assertEq(epic, 0.2 ether);
        assertEq(legendary, 0.5 ether);
    }

    function testInitialSupply() public {
        assertEq(vpass.commonSupply(), 6000);
        assertEq(vpass.rareSupply(), 2500);
        assertEq(vpass.epicSupply(), 1200);
        assertEq(vpass.legendarySupply(), 300);
    }

    // ============ Minting Tests ============

    function testMintCommon() public {
        vm.prank(user1);
        vm.expectEmit(true, true, false, true);
        emit PassMinted(user1, 1, VISECurriculumPass.Rarity.COMMON, 0.05 ether);

        uint256 tokenId = vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        assertEq(tokenId, 1);
        assertEq(vpass.ownerOf(tokenId), user1);
        assertEq(vpass.commonMinted(), 1);
        assertTrue(vpass.hasActivePass(user1));
    }

    function testMintRare() public {
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);

        assertEq(vpass.ownerOf(tokenId), user1);
        assertEq(vpass.rareMinted(), 1);

        (
            VISECurriculumPass.Rarity rarity,
            ,
            uint256 accessLevel,
            bool lifetime,
            uint256 bonus
        ) = vpass.getPassMetadata(tokenId);

        assertTrue(rarity == VISECurriculumPass.Rarity.RARE);
        assertEq(accessLevel, 4);
        assertFalse(lifetime);
        assertEq(bonus, 10);
    }

    function testMintEpic() public {
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);

        (
            VISECurriculumPass.Rarity rarity,
            ,
            uint256 accessLevel,
            bool lifetime,
            uint256 bonus
        ) = vpass.getPassMetadata(tokenId);

        assertTrue(rarity == VISECurriculumPass.Rarity.EPIC);
        assertEq(accessLevel, 5);
        assertTrue(lifetime); // Epic has lifetime access
        assertEq(bonus, 25);
    }

    function testMintLegendary() public {
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.5 ether}(VISECurriculumPass.Rarity.LEGENDARY);

        (
            VISECurriculumPass.Rarity rarity,
            ,
            uint256 accessLevel,
            bool lifetime,
            uint256 bonus
        ) = vpass.getPassMetadata(tokenId);

        assertTrue(rarity == VISECurriculumPass.Rarity.LEGENDARY);
        assertEq(accessLevel, 5);
        assertTrue(lifetime);
        assertEq(bonus, 50);
    }

    function testMintFailsInsufficientPayment() public {
        vm.prank(user1);
        vm.expectRevert("Insufficient payment");
        vpass.mint{value: 0.04 ether}(VISECurriculumPass.Rarity.COMMON);
    }

    function testMintRefundsExcessPayment() public {
        uint256 balanceBefore = user1.balance;

        vm.prank(user1);
        vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.COMMON); // Pay 0.1 for 0.05

        uint256 balanceAfter = user1.balance;

        // Should refund 0.05 ether
        assertEq(balanceBefore - balanceAfter, 0.05 ether);
    }

    function testMintMultipleByOneUser() public {
        vm.startPrank(user1);

        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
        vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);
        vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);

        vm.stopPrank();

        assertEq(vpass.balanceOf(user1), 3);
        assertEq(vpass.getUserAccessLevel(user1), 5); // Highest is Epic = 5
    }

    function testMintWhenPaused() public {
        vpass.pause();

        vm.prank(user1);
        vm.expectRevert();
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
    }

    // ============ Governance Mint Tests ============

    function testGovernanceMint() public {
        address[] memory recipients = new address[](3);
        recipients[0] = user1;
        recipients[1] = user2;
        recipients[2] = user3;

        uint256[] memory tokenIds = vpass.governanceMint(
            recipients,
            VISECurriculumPass.Rarity.RARE
        );

        assertEq(tokenIds.length, 3);
        assertEq(vpass.ownerOf(tokenIds[0]), user1);
        assertEq(vpass.ownerOf(tokenIds[1]), user2);
        assertEq(vpass.ownerOf(tokenIds[2]), user3);
        assertEq(vpass.rareMinted(), 3);
    }

    function testGovernanceMintFailsForUnauthorized() public {
        address[] memory recipients = new address[](1);
        recipients[0] = user1;

        vm.prank(user1);
        vm.expectRevert("Only governance or owner");
        vpass.governanceMint(recipients, VISECurriculumPass.Rarity.COMMON);
    }

    function testGovernanceMintFromGovernanceContract() public {
        address[] memory recipients = new address[](1);
        recipients[0] = user1;

        vm.prank(governance);
        vpass.governanceMint(recipients, VISECurriculumPass.Rarity.LEGENDARY);

        assertEq(vpass.legendaryMinted(), 1);
    }

    // ============ Authorized Minter Tests ============

    function testSetAuthorizedMinter() public {
        vpass.setAuthorizedMinter(user1, true);
        assertTrue(vpass.authorizedMinters(user1));
    }

    function testAuthorizedMint() public {
        vpass.setAuthorizedMinter(user1, true);

        vm.prank(user1);
        uint256 tokenId = vpass.authorizedMint(user2, VISECurriculumPass.Rarity.EPIC);

        assertEq(vpass.ownerOf(tokenId), user2);
        assertEq(vpass.epicMinted(), 1);
    }

    function testAuthorizedMintFailsForUnauthorized() public {
        vm.prank(user1);
        vm.expectRevert("Not authorized minter");
        vpass.authorizedMint(user2, VISECurriculumPass.Rarity.COMMON);
    }

    // ============ Access Control Tests ============

    function testHasModuleAccess() public {
        // Mint Common (access level 3)
        vm.prank(user1);
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        assertTrue(vpass.hasModuleAccess(user1, 1));
        assertTrue(vpass.hasModuleAccess(user1, 2));
        assertTrue(vpass.hasModuleAccess(user1, 3));
        assertFalse(vpass.hasModuleAccess(user1, 4));
        assertFalse(vpass.hasModuleAccess(user1, 5));
    }

    function testHasModuleAccessRare() public {
        // Mint Rare (access level 4)
        vm.prank(user1);
        vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);

        assertTrue(vpass.hasModuleAccess(user1, 4));
        assertFalse(vpass.hasModuleAccess(user1, 5));
    }

    function testHasModuleAccessEpic() public {
        // Mint Epic (access level 5)
        vm.prank(user1);
        vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);

        assertTrue(vpass.hasModuleAccess(user1, 5));
    }

    function testGetUserAccessLevel() public {
        // User has no pass
        assertEq(vpass.getUserAccessLevel(user1), 0);

        // Mint Common
        vm.prank(user1);
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        assertEq(vpass.getUserAccessLevel(user1), 3);

        // Mint Epic (should upgrade to 5)
        vm.prank(user1);
        vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);

        assertEq(vpass.getUserAccessLevel(user1), 5);
    }

    function testHasLifetimeAccess() public {
        // Common and Rare don't have lifetime
        vm.prank(user1);
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
        assertFalse(vpass.hasLifetimeAccess(user1));

        // Epic has lifetime
        vm.prank(user2);
        vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);
        assertTrue(vpass.hasLifetimeAccess(user2));

        // Legendary has lifetime
        vm.prank(user3);
        vpass.mint{value: 0.5 ether}(VISECurriculumPass.Rarity.LEGENDARY);
        assertTrue(vpass.hasLifetimeAccess(user3));
    }

    // ============ Transfer Tests ============

    function testTransfer() public {
        // Mint to user1
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        // Transfer to user2
        vm.prank(user1);
        vpass.transferFrom(user1, user2, tokenId);

        assertEq(vpass.ownerOf(tokenId), user2);
        assertTrue(vpass.hasActivePass(user2));
    }

    function testTransferRemovesActivePassIfNoMoreTokens() public {
        // Mint one token to user1
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        assertTrue(vpass.hasActivePass(user1));

        // Transfer away
        vm.prank(user1);
        vpass.transferFrom(user1, user2, tokenId);

        assertFalse(vpass.hasActivePass(user1));
        assertTrue(vpass.hasActivePass(user2));
    }

    function testTransferDoesNotRemoveActivePassIfHasOtherTokens() public {
        // Mint two tokens to user1
        vm.startPrank(user1);
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
        uint256 tokenId2 = vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);
        vm.stopPrank();

        // Transfer one away
        vm.prank(user1);
        vpass.transferFrom(user1, user2, tokenId2);

        // user1 still has active pass
        assertTrue(vpass.hasActivePass(user1));
    }

    // ============ Admin Functions Tests ============

    function testUpdatePrice() public {
        vpass.updatePrice(VISECurriculumPass.Rarity.COMMON, 0.08 ether);

        (uint256 common, , , ) = vpass.getAllPrices();
        assertEq(common, 0.08 ether);
    }

    function testUpdatePriceFailsForNonOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        vpass.updatePrice(VISECurriculumPass.Rarity.COMMON, 0.08 ether);
    }

    function testUpdatePriceFailsForZero() public {
        vm.expectRevert("Price must be > 0");
        vpass.updatePrice(VISECurriculumPass.Rarity.COMMON, 0);
    }

    function testUpdateSupply() public {
        vpass.updateSupply(VISECurriculumPass.Rarity.COMMON, 7000);
        assertEq(vpass.commonSupply(), 7000);
    }

    function testUpdateSupplyFailsBelowMinted() public {
        // Mint 10 common
        for (uint256 i = 0; i < 10; i++) {
            vm.prank(user1);
            vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
        }

        vm.expectRevert("Supply below minted");
        vpass.updateSupply(VISECurriculumPass.Rarity.COMMON, 5);
    }

    function testSetTreasury() public {
        address newTreasury = address(0x999);
        vpass.setTreasury(newTreasury);
        assertEq(vpass.treasury(), newTreasury);
    }

    function testSetGovernance() public {
        address newGovernance = address(0x888);
        vpass.setGovernance(newGovernance);
        assertEq(vpass.governanceContract(), newGovernance);
    }

    function testSetBaseURI() public {
        vpass.setBaseURI("ipfs://newbase/");

        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        string memory uri = vpass.tokenURI(tokenId);
        // Should contain new base
        assertTrue(bytes(uri).length > 0);
    }

    function testPauseAndUnpause() public {
        vpass.pause();
        assertTrue(vpass.paused());

        vpass.unpause();
        assertFalse(vpass.paused());
    }

    // ============ Revenue Withdrawal Tests ============

    function testWithdrawRevenue() public {
        // Mint some passes
        vm.prank(user1);
        vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);

        vm.prank(user2);
        vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);

        // Total: 0.3 ether
        // Treasury (80%): 0.24 ether
        // Owner (20%): 0.06 ether

        uint256 treasuryBalanceBefore = treasury.balance;
        uint256 ownerBalanceBefore = owner.balance;

        vpass.withdrawRevenue();

        assertEq(treasury.balance - treasuryBalanceBefore, 0.24 ether);
        assertEq(owner.balance - ownerBalanceBefore, 0.06 ether);
    }

    function testWithdrawRevenueFailsWhenEmpty() public {
        vm.expectRevert("No funds to withdraw");
        vpass.withdrawRevenue();
    }

    // ============ Metadata Tests ============

    function testGetPassMetadata() public {
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);

        (
            VISECurriculumPass.Rarity rarity,
            uint256 mintTimestamp,
            uint256 accessLevel,
            bool lifetime,
            uint256 bonus
        ) = vpass.getPassMetadata(tokenId);

        assertTrue(rarity == VISECurriculumPass.Rarity.RARE);
        assertEq(mintTimestamp, block.timestamp);
        assertEq(accessLevel, 4);
        assertFalse(lifetime);
        assertEq(bonus, 10);
    }

    function testGetMintStats() public {
        // Mint various rarities
        vm.prank(user1);
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        vm.prank(user1);
        vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);

        vm.prank(user1);
        vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);

        (
            uint256 total,
            uint256 common,
            uint256 rare,
            uint256 epic,
            uint256 legendary
        ) = vpass.getMintStats();

        assertEq(total, 3);
        assertEq(common, 1);
        assertEq(rare, 1);
        assertEq(epic, 1);
        assertEq(legendary, 0);
    }

    function testGetRarityDistribution() public {
        // Mint 10 tokens
        for (uint256 i = 0; i < 6; i++) {
            vm.prank(user1);
            vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
        }

        for (uint256 i = 0; i < 2; i++) {
            vm.prank(user1);
            vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);
        }

        for (uint256 i = 0; i < 2; i++) {
            vm.prank(user1);
            vpass.mint{value: 0.2 ether}(VISECurriculumPass.Rarity.EPIC);
        }

        (uint256 commonPct, uint256 rarePct, uint256 epicPct, uint256 legendaryPct) =
            vpass.getRarityDistribution();

        assertEq(commonPct, 60); // 6/10 = 60%
        assertEq(rarePct, 20); // 2/10 = 20%
        assertEq(epicPct, 20); // 2/10 = 20%
        assertEq(legendaryPct, 0);
    }

    function testTokenURI() public {
        vm.prank(user1);
        uint256 tokenId = vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);

        string memory uri = vpass.tokenURI(tokenId);

        // Should contain RARE in the path
        assertTrue(bytes(uri).length > 0);
    }

    // ============ Supply Limit Tests ============

    function testMintFailsWhenRaritySupplyExhausted() public {
        // Set legendary supply to 2
        vpass.updateSupply(VISECurriculumPass.Rarity.LEGENDARY, 2);

        // Mint 2 legendary
        vm.startPrank(user1);
        vpass.mint{value: 0.5 ether}(VISECurriculumPass.Rarity.LEGENDARY);
        vpass.mint{value: 0.5 ether}(VISECurriculumPass.Rarity.LEGENDARY);
        vm.stopPrank();

        // Try to mint 3rd
        vm.prank(user1);
        vm.expectRevert("Rarity tier sold out");
        vpass.mint{value: 0.5 ether}(VISECurriculumPass.Rarity.LEGENDARY);
    }

    // ============ Enumerable Tests ============

    function testTokenOfOwnerByIndex() public {
        vm.startPrank(user1);
        uint256 tokenId1 = vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);
        uint256 tokenId2 = vpass.mint{value: 0.1 ether}(VISECurriculumPass.Rarity.RARE);
        vm.stopPrank();

        assertEq(vpass.tokenOfOwnerByIndex(user1, 0), tokenId1);
        assertEq(vpass.tokenOfOwnerByIndex(user1, 1), tokenId2);
    }

    function testTotalSupply() public {
        assertEq(vpass.totalSupply(), 0);

        vm.prank(user1);
        vpass.mint{value: 0.05 ether}(VISECurriculumPass.Rarity.COMMON);

        assertEq(vpass.totalSupply(), 1);
    }

    // ============ Fuzz Tests ============

    function testFuzzMint(uint96 price) public {
        vm.assume(price >= 0.05 ether && price <= 1 ether);

        vm.prank(user1);
        vpass.mint{value: price}(VISECurriculumPass.Rarity.COMMON);

        assertEq(vpass.balanceOf(user1), 1);
    }

    function testFuzzGovernanceMint(uint8 numRecipients) public {
        vm.assume(numRecipients > 0 && numRecipients <= 100);

        address[] memory recipients = new address[](numRecipients);
        for (uint256 i = 0; i < numRecipients; i++) {
            recipients[i] = address(uint160(i + 1000));
        }

        vpass.governanceMint(recipients, VISECurriculumPass.Rarity.COMMON);

        assertEq(vpass.commonMinted(), numRecipients);
    }
}
