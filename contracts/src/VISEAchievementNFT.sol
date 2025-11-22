// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title VISEAchievementNFT
 * @notice Achievement NFT system for VISE Module 3
 * @dev Demonstrates:
 *      - ERC-721 NFT standard
 *      - Role-based minting (educators)
 *      - Achievement metadata tracking
 *      - Module completion tracking
 */
contract VISEAchievementNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    // Token ID counter
    Counters.Counter private _tokenIds;

    // Achievement types
    enum AchievementType {
        MODULE_COMPLETION,
        PERFECT_SCORE,
        EARLY_COMPLETION,
        COMMUNITY_CONTRIBUTION,
        SPECIAL_RECOGNITION
    }

    // Achievement metadata
    struct Achievement {
        uint256 moduleId;
        AchievementType achievementType;
        uint256 timestamp;
        string metadata; // IPFS hash or JSON string
    }

    // State variables
    mapping(uint256 => Achievement) public achievements;
    mapping(address => bool) public educators; // Can mint achievements
    mapping(address => uint256[]) public userAchievements;
    mapping(address => mapping(uint256 => bool)) public moduleCompleted;

    // Base URI for token metadata
    string private _baseTokenURI;

    // Events
    event AchievementMinted(
        address indexed recipient,
        uint256 indexed tokenId,
        uint256 moduleId,
        AchievementType achievementType
    );

    event EducatorAdded(address indexed educator);
    event EducatorRemoved(address indexed educator);
    event BaseURIUpdated(string newBaseURI);

    // Modifiers
    modifier onlyEducator() {
        require(
            educators[msg.sender] || msg.sender == owner(),
            "Only educators can perform this action"
        );
        _;
    }

    /**
     * @notice Contract constructor
     * @param baseURI The base URI for token metadata
     */
    constructor(string memory baseURI) ERC721("VISE Achievement", "VISE-ACH") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
        educators[msg.sender] = true; // Owner is default educator
    }

    /**
     * @notice Mint an achievement NFT
     * @param recipient The address to receive the NFT
     * @param moduleId The module ID for this achievement
     * @param achievementType The type of achievement
     * @param metadata IPFS hash or metadata string
     */
    function mintAchievement(
        address recipient,
        uint256 moduleId,
        AchievementType achievementType,
        string memory metadata
    ) public onlyEducator returns (uint256) {
        require(recipient != address(0), "Cannot mint to zero address");

        // Increment token ID
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // Mint the NFT
        _safeMint(recipient, newTokenId);

        // Store achievement data
        achievements[newTokenId] = Achievement({
            moduleId: moduleId,
            achievementType: achievementType,
            timestamp: block.timestamp,
            metadata: metadata
        });

        // Track user achievements
        userAchievements[recipient].push(newTokenId);

        // Mark module as completed if it's a completion achievement
        if (achievementType == AchievementType.MODULE_COMPLETION) {
            moduleCompleted[recipient][moduleId] = true;
        }

        emit AchievementMinted(recipient, newTokenId, moduleId, achievementType);

        return newTokenId;
    }

    /**
     * @notice Batch mint achievements (gas efficient)
     * @param recipients Array of recipient addresses
     * @param moduleId The module ID for these achievements
     * @param achievementType The type of achievement
     * @param metadata IPFS hash or metadata string
     */
    function batchMintAchievements(
        address[] memory recipients,
        uint256 moduleId,
        AchievementType achievementType,
        string memory metadata
    ) public onlyEducator {
        for (uint256 i = 0; i < recipients.length; i++) {
            mintAchievement(recipients[i], moduleId, achievementType, metadata);
        }
    }

    /**
     * @notice Add an educator (can mint achievements)
     * @param educator The address to grant educator role
     */
    function addEducator(address educator) public onlyOwner {
        require(educator != address(0), "Invalid educator address");
        require(!educators[educator], "Already an educator");

        educators[educator] = true;
        emit EducatorAdded(educator);
    }

    /**
     * @notice Remove an educator
     * @param educator The address to revoke educator role
     */
    function removeEducator(address educator) public onlyOwner {
        require(educators[educator], "Not an educator");
        require(educator != owner(), "Cannot remove owner");

        educators[educator] = false;
        emit EducatorRemoved(educator);
    }

    /**
     * @notice Update the base URI for token metadata
     * @param newBaseURI The new base URI
     */
    function setBaseURI(string memory newBaseURI) public onlyOwner {
        _baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    /**
     * @notice Get all achievements for a user
     * @param user The user's address
     * @return Array of token IDs
     */
    function getUserAchievements(address user) public view returns (uint256[] memory) {
        return userAchievements[user];
    }

    /**
     * @notice Get achievement details
     * @param tokenId The token ID
     * @return moduleId The module ID
     * @return achievementType The achievement type
     * @return timestamp When it was earned
     * @return metadata The metadata string
     */
    function getAchievement(uint256 tokenId)
        public
        view
        returns (
            uint256 moduleId,
            AchievementType achievementType,
            uint256 timestamp,
            string memory metadata
        )
    {
        require(_ownerOf(tokenId) != address(0), "Achievement does not exist");
        Achievement memory achievement = achievements[tokenId];

        return (
            achievement.moduleId,
            achievement.achievementType,
            achievement.timestamp,
            achievement.metadata
        );
    }

    /**
     * @notice Check if user completed a module
     * @param user The user's address
     * @param moduleId The module ID
     * @return Whether the module is completed
     */
    function hasCompletedModule(address user, uint256 moduleId) public view returns (bool) {
        return moduleCompleted[user][moduleId];
    }

    /**
     * @notice Get total number of achievements minted
     * @return The total count
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

    /**
     * @notice Override base URI function
     * @return The base URI
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    /**
     * @notice Prevent token transfers (soulbound)
     * @dev Override to make NFTs non-transferable after minting
     */
    function _update(address to, uint256 tokenId, address auth)
        internal
        virtual
        override
        returns (address)
    {
        address from = _ownerOf(tokenId);

        // Allow minting (from == address(0))
        // Prevent transfers (from != address(0) && to != address(0))
        if (from != address(0) && to != address(0)) {
            revert("Soulbound: Transfer not allowed");
        }

        return super._update(to, tokenId, auth);
    }
}
