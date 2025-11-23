// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/**
 * @title VISECurriculumPass
 * @notice NFT-based access pass for VISE curriculum with rarity system
 * @dev Token-gates curriculum access. Transferable (NOT soulbound) to enable secondary market.
 *
 * Features:
 * - Multiple rarity tiers (Common, Rare, Epic, Legendary)
 * - Public mint with price tiers
 * - Governance-controlled special mints
 * - Access level system for curriculum modules
 * - Revenue sharing with treasury
 * - Metadata with rarity traits
 */
contract VISECurriculumPass is ERC721, ERC721Enumerable, Ownable, Pausable, ReentrancyGuard {
    using Strings for uint256;

    // ============ Enums ============

    enum Rarity {
        COMMON,      // 60% - Access to Modules 1-3
        RARE,        // 25% - Access to Modules 1-4 + bonus content
        EPIC,        // 12% - Access to all modules + mentorship
        LEGENDARY    // 3%  - Full access + 1-on-1 sessions + lifetime updates
    }

    // ============ Structs ============

    struct PassMetadata {
        Rarity rarity;
        uint256 mintTimestamp;
        uint256 accessLevel; // 1-5 (module access)
        bool hasLifetimeAccess;
        uint256 rarityBonus; // Additional perks percentage
    }

    // ============ State Variables ============

    // Token tracking
    uint256 private _nextTokenId = 1;
    uint256 public maxSupply = 10000;

    // Pricing (in wei)
    uint256 public commonPrice = 0.05 ether;
    uint256 public rarePrice = 0.1 ether;
    uint256 public epicPrice = 0.2 ether;
    uint256 public legendaryPrice = 0.5 ether;

    // Supply limits per rarity
    uint256 public commonSupply = 6000;
    uint256 public rareSupply = 2500;
    uint256 public epicSupply = 1200;
    uint256 public legendarySupply = 300;

    // Minted counts per rarity
    uint256 public commonMinted;
    uint256 public rareMinted;
    uint256 public epicMinted;
    uint256 public legendaryMinted;

    // Metadata
    mapping(uint256 => PassMetadata) public passMetadata;
    string private _baseTokenURI;

    // Treasury
    address public treasury;
    uint256 public treasuryShareBps = 8000; // 80% to treasury (basis points)

    // Governance integration
    address public governanceContract;
    mapping(address => bool) public authorizedMinters; // DAO-approved minters

    // Access control
    mapping(address => bool) public hasActivePass; // Quick lookup for access

    // ============ Events ============

    event PassMinted(
        address indexed recipient,
        uint256 indexed tokenId,
        Rarity rarity,
        uint256 price
    );

    event RarityDistribution(
        uint256 common,
        uint256 rare,
        uint256 epic,
        uint256 legendary
    );

    event PriceUpdated(Rarity rarity, uint256 newPrice);
    event TreasuryUpdated(address indexed newTreasury);
    event GovernanceUpdated(address indexed newGovernance);
    event RevenueWithdrawn(address indexed to, uint256 amount);

    // ============ Modifiers ============

    modifier onlyGovernanceOrOwner() {
        require(
            msg.sender == governanceContract || msg.sender == owner(),
            "Only governance or owner"
        );
        _;
    }

    // ============ Constructor ============

    constructor(
        string memory baseURI,
        address _treasury,
        address _governance
    ) ERC721("V-Pass", "VPASS") Ownable(msg.sender) {
        require(_treasury != address(0), "Invalid treasury");
        require(_governance != address(0), "Invalid governance");

        _baseTokenURI = baseURI;
        treasury = _treasury;
        governanceContract = _governance;
    }

    // ============ Minting Functions ============

    /**
     * @notice Public mint function - rarity determined by price paid
     * @param rarity The desired rarity tier
     */
    function mint(Rarity rarity) public payable nonReentrant whenNotPaused returns (uint256) {
        require(_nextTokenId <= maxSupply, "Max supply reached");

        // Check rarity-specific supply and pricing
        (uint256 price, uint256 supply, uint256 minted) = _getRarityInfo(rarity);

        require(minted < supply, "Rarity tier sold out");
        require(msg.value >= price, "Insufficient payment");

        uint256 tokenId = _nextTokenId++;

        // Mint NFT
        _safeMint(msg.sender, tokenId);

        // Set metadata
        passMetadata[tokenId] = PassMetadata({
            rarity: rarity,
            mintTimestamp: block.timestamp,
            accessLevel: _getAccessLevel(rarity),
            hasLifetimeAccess: rarity >= Rarity.EPIC,
            rarityBonus: _getRarityBonus(rarity)
        });

        // Update minted count
        _incrementRarityCount(rarity);

        // Track active pass
        hasActivePass[msg.sender] = true;

        emit PassMinted(msg.sender, tokenId, rarity, msg.value);

        // Handle excess payment refund
        if (msg.value > price) {
            (bool success, ) = msg.sender.call{value: msg.value - price}("");
            require(success, "Refund failed");
        }

        return tokenId;
    }

    /**
     * @notice Batch mint for governance/partnerships (no payment required)
     * @param recipients Array of recipient addresses
     * @param rarity The rarity tier to mint
     */
    function governanceMint(
        address[] calldata recipients,
        Rarity rarity
    ) external onlyGovernanceOrOwner returns (uint256[] memory) {
        require(recipients.length > 0, "No recipients");
        require(_nextTokenId + recipients.length <= maxSupply, "Exceeds max supply");

        (, uint256 supply, uint256 minted) = _getRarityInfo(rarity);
        require(minted + recipients.length <= supply, "Exceeds rarity supply");

        uint256[] memory tokenIds = new uint256[](recipients.length);

        for (uint256 i = 0; i < recipients.length; i++) {
            uint256 tokenId = _nextTokenId++;

            _safeMint(recipients[i], tokenId);

            passMetadata[tokenId] = PassMetadata({
                rarity: rarity,
                mintTimestamp: block.timestamp,
                accessLevel: _getAccessLevel(rarity),
                hasLifetimeAccess: rarity >= Rarity.EPIC,
                rarityBonus: _getRarityBonus(rarity)
            });

            _incrementRarityCount(rarity);
            hasActivePass[recipients[i]] = true;

            tokenIds[i] = tokenId;

            emit PassMinted(recipients[i], tokenId, rarity, 0);
        }

        return tokenIds;
    }

    /**
     * @notice Authorized minter function (for partnerships)
     * @param recipient The recipient address
     * @param rarity The rarity tier
     */
    function authorizedMint(address recipient, Rarity rarity)
        external
        nonReentrant
        returns (uint256)
    {
        require(authorizedMinters[msg.sender], "Not authorized minter");
        require(_nextTokenId <= maxSupply, "Max supply reached");

        (, uint256 supply, uint256 minted) = _getRarityInfo(rarity);
        require(minted < supply, "Rarity tier sold out");

        uint256 tokenId = _nextTokenId++;

        _safeMint(recipient, tokenId);

        passMetadata[tokenId] = PassMetadata({
            rarity: rarity,
            mintTimestamp: block.timestamp,
            accessLevel: _getAccessLevel(rarity),
            hasLifetimeAccess: rarity >= Rarity.EPIC,
            rarityBonus: _getRarityBonus(rarity)
        });

        _incrementRarityCount(rarity);
        hasActivePass[recipient] = true;

        emit PassMinted(recipient, tokenId, rarity, 0);

        return tokenId;
    }

    // ============ Access Control Functions ============

    /**
     * @notice Check if address has access to a specific module
     * @param user The user's address
     * @param moduleId The module ID (1-5)
     * @return Whether user has access
     */
    function hasModuleAccess(address user, uint256 moduleId) public view returns (bool) {
        if (!hasActivePass[user]) return false;

        uint256 balance = balanceOf(user);
        if (balance == 0) return false;

        // Check all tokens owned by user
        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(user, i);
            if (passMetadata[tokenId].accessLevel >= moduleId) {
                return true;
            }
        }

        return false;
    }

    /**
     * @notice Get highest access level for a user
     * @param user The user's address
     * @return The highest module access level
     */
    function getUserAccessLevel(address user) public view returns (uint256) {
        uint256 balance = balanceOf(user);
        if (balance == 0) return 0;

        uint256 maxLevel = 0;
        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(user, i);
            if (passMetadata[tokenId].accessLevel > maxLevel) {
                maxLevel = passMetadata[tokenId].accessLevel;
            }
        }

        return maxLevel;
    }

    /**
     * @notice Check if user has lifetime access
     * @param user The user's address
     * @return Whether user has lifetime access
     */
    function hasLifetimeAccess(address user) public view returns (bool) {
        uint256 balance = balanceOf(user);
        if (balance == 0) return false;

        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(user, i);
            if (passMetadata[tokenId].hasLifetimeAccess) {
                return true;
            }
        }

        return false;
    }

    // ============ Admin Functions ============

    /**
     * @notice Update pricing for a rarity tier
     * @param rarity The rarity tier
     * @param newPrice The new price in wei
     */
    function updatePrice(Rarity rarity, uint256 newPrice) external onlyOwner {
        require(newPrice > 0, "Price must be > 0");

        if (rarity == Rarity.COMMON) commonPrice = newPrice;
        else if (rarity == Rarity.RARE) rarePrice = newPrice;
        else if (rarity == Rarity.EPIC) epicPrice = newPrice;
        else if (rarity == Rarity.LEGENDARY) legendaryPrice = newPrice;

        emit PriceUpdated(rarity, newPrice);
    }

    /**
     * @notice Update supply limits
     * @param rarity The rarity tier
     * @param newSupply The new supply limit
     */
    function updateSupply(Rarity rarity, uint256 newSupply) external onlyGovernanceOrOwner {
        if (rarity == Rarity.COMMON) {
            require(newSupply >= commonMinted, "Supply below minted");
            commonSupply = newSupply;
        } else if (rarity == Rarity.RARE) {
            require(newSupply >= rareMinted, "Supply below minted");
            rareSupply = newSupply;
        } else if (rarity == Rarity.EPIC) {
            require(newSupply >= epicMinted, "Supply below minted");
            epicSupply = newSupply;
        } else if (rarity == Rarity.LEGENDARY) {
            require(newSupply >= legendaryMinted, "Supply below minted");
            legendarySupply = newSupply;
        }
    }

    /**
     * @notice Set authorized minter (for partnerships)
     * @param minter The minter address
     * @param authorized Whether authorized
     */
    function setAuthorizedMinter(address minter, bool authorized)
        external
        onlyGovernanceOrOwner
    {
        require(minter != address(0), "Invalid minter");
        authorizedMinters[minter] = authorized;
    }

    /**
     * @notice Update treasury address
     * @param newTreasury The new treasury address
     */
    function setTreasury(address newTreasury) external onlyGovernanceOrOwner {
        require(newTreasury != address(0), "Invalid treasury");
        treasury = newTreasury;
        emit TreasuryUpdated(newTreasury);
    }

    /**
     * @notice Update governance contract
     * @param newGovernance The new governance address
     */
    function setGovernance(address newGovernance) external onlyOwner {
        require(newGovernance != address(0), "Invalid governance");
        governanceContract = newGovernance;
        emit GovernanceUpdated(newGovernance);
    }

    /**
     * @notice Update base URI
     * @param newBaseURI The new base URI
     */
    function setBaseURI(string memory newBaseURI) external onlyOwner {
        _baseTokenURI = newBaseURI;
    }

    /**
     * @notice Pause minting
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @notice Unpause minting
     */
    function unpause() external onlyOwner {
        _unpause();
    }

    /**
     * @notice Withdraw contract balance to treasury
     */
    function withdrawRevenue() external nonReentrant {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        uint256 treasuryAmount = (balance * treasuryShareBps) / 10000;
        uint256 ownerAmount = balance - treasuryAmount;

        // Send to treasury
        (bool success1, ) = treasury.call{value: treasuryAmount}("");
        require(success1, "Treasury transfer failed");

        // Send to owner
        (bool success2, ) = owner().call{value: ownerAmount}("");
        require(success2, "Owner transfer failed");

        emit RevenueWithdrawn(treasury, treasuryAmount);
        emit RevenueWithdrawn(owner(), ownerAmount);
    }

    // ============ View Functions ============

    /**
     * @notice Get pass metadata for a token
     * @param tokenId The token ID
     */
    function getPassMetadata(uint256 tokenId)
        external
        view
        returns (
            Rarity rarity,
            uint256 mintTimestamp,
            uint256 accessLevel,
            bool lifetime,
            uint256 bonus
        )
    {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        PassMetadata memory meta = passMetadata[tokenId];
        return (
            meta.rarity,
            meta.mintTimestamp,
            meta.accessLevel,
            meta.hasLifetimeAccess,
            meta.rarityBonus
        );
    }

    /**
     * @notice Get current mint statistics
     */
    function getMintStats()
        external
        view
        returns (
            uint256 totalMinted,
            uint256 common,
            uint256 rare,
            uint256 epic,
            uint256 legendary
        )
    {
        return (
            _nextTokenId - 1,
            commonMinted,
            rareMinted,
            epicMinted,
            legendaryMinted
        );
    }

    /**
     * @notice Get rarity distribution percentages
     */
    function getRarityDistribution()
        external
        view
        returns (uint256, uint256, uint256, uint256)
    {
        uint256 total = _nextTokenId - 1;
        if (total == 0) return (0, 0, 0, 0);

        return (
            (commonMinted * 100) / total,
            (rareMinted * 100) / total,
            (epicMinted * 100) / total,
            (legendaryMinted * 100) / total
        );
    }

    /**
     * @notice Get pricing info for all rarities
     */
    function getAllPrices()
        external
        view
        returns (uint256, uint256, uint256, uint256)
    {
        return (commonPrice, rarePrice, epicPrice, legendaryPrice);
    }

    /**
     * @notice Override tokenURI to include rarity in metadata
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");

        string memory baseURI = _baseURI();
        PassMetadata memory meta = passMetadata[tokenId];

        // Return baseURI + rarity + tokenId (e.g., ipfs://base/RARE/123)
        string memory rarityStr = _rarityToString(meta.rarity);

        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, rarityStr, "/", tokenId.toString(), ".json"))
                : "";
    }

    // ============ Internal Functions ============

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function _getRarityInfo(Rarity rarity)
        internal
        view
        returns (uint256 price, uint256 supply, uint256 minted)
    {
        if (rarity == Rarity.COMMON) {
            return (commonPrice, commonSupply, commonMinted);
        } else if (rarity == Rarity.RARE) {
            return (rarePrice, rareSupply, rareMinted);
        } else if (rarity == Rarity.EPIC) {
            return (epicPrice, epicSupply, epicMinted);
        } else {
            return (legendaryPrice, legendarySupply, legendaryMinted);
        }
    }

    function _incrementRarityCount(Rarity rarity) internal {
        if (rarity == Rarity.COMMON) commonMinted++;
        else if (rarity == Rarity.RARE) rareMinted++;
        else if (rarity == Rarity.EPIC) epicMinted++;
        else if (rarity == Rarity.LEGENDARY) legendaryMinted++;
    }

    function _getAccessLevel(Rarity rarity) internal pure returns (uint256) {
        if (rarity == Rarity.COMMON) return 3; // Modules 1-3
        if (rarity == Rarity.RARE) return 4; // Modules 1-4
        if (rarity == Rarity.EPIC) return 5; // All modules
        return 5; // Legendary - all modules
    }

    function _getRarityBonus(Rarity rarity) internal pure returns (uint256) {
        if (rarity == Rarity.COMMON) return 0;
        if (rarity == Rarity.RARE) return 10; // 10% bonus perks
        if (rarity == Rarity.EPIC) return 25; // 25% bonus perks
        return 50; // 50% bonus perks (Legendary)
    }

    function _rarityToString(Rarity rarity) internal pure returns (string memory) {
        if (rarity == Rarity.COMMON) return "COMMON";
        if (rarity == Rarity.RARE) return "RARE";
        if (rarity == Rarity.EPIC) return "EPIC";
        return "LEGENDARY";
    }

    // ============ Transfer Hooks ============

    /**
     * @notice Update hasActivePass mapping on transfers
     */
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        address from = _ownerOf(tokenId);

        // Update active pass status
        if (to != address(0)) {
            hasActivePass[to] = true;
        }

        // Remove active pass if user has no more tokens
        if (from != address(0) && balanceOf(from) == 1) {
            hasActivePass[from] = false;
        }

        return super._update(to, tokenId, auth);
    }

    // Required overrides
    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
