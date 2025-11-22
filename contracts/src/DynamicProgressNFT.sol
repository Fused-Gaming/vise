// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title DynamicProgressNFT
 * @notice Dynamic on-chain NFT that evolves with student progress
 * @dev Demonstrates:
 *      - On-chain SVG generation
 *      - Dynamic metadata
 *      - Progress tracking
 *      - Base64 encoding
 */
contract DynamicProgressNFT is ERC721, Ownable {
    using Strings for uint256;

    // Progress tracking
    struct StudentProgress {
        uint256 modulesCompleted;
        uint256 totalScore;
        uint256 level;
        uint256 lastUpdate;
    }

    // State variables
    mapping(uint256 => StudentProgress) public progress;
    mapping(address => uint256) public studentTokenId;
    uint256 private _nextTokenId = 1;

    // Configuration
    uint256 public constant MAX_MODULES = 5;
    uint256 public constant POINTS_PER_LEVEL = 100;

    // Events
    event ProgressUpdated(
        uint256 indexed tokenId,
        uint256 modulesCompleted,
        uint256 totalScore,
        uint256 level
    );

    event NFTMinted(address indexed student, uint256 indexed tokenId);

    /**
     * @notice Contract constructor
     */
    constructor() ERC721("VISE Progress", "VISE-PROG") Ownable(msg.sender) {}

    /**
     * @notice Mint a progress NFT to a student
     * @param student The student's address
     */
    function mintProgressNFT(address student) public onlyOwner returns (uint256) {
        require(student != address(0), "Cannot mint to zero address");
        require(studentTokenId[student] == 0, "Student already has NFT");

        uint256 tokenId = _nextTokenId++;
        _safeMint(student, tokenId);

        studentTokenId[student] = tokenId;

        // Initialize progress
        progress[tokenId] = StudentProgress({
            modulesCompleted: 0,
            totalScore: 0,
            level: 1,
            lastUpdate: block.timestamp
        });

        emit NFTMinted(student, tokenId);

        return tokenId;
    }

    /**
     * @notice Update student progress
     * @param student The student's address
     * @param modulesCompleted Number of modules completed
     * @param scoreToAdd Points to add
     */
    function updateProgress(
        address student,
        uint256 modulesCompleted,
        uint256 scoreToAdd
    ) public onlyOwner {
        uint256 tokenId = studentTokenId[student];
        require(tokenId != 0, "Student does not have NFT");
        require(modulesCompleted <= MAX_MODULES, "Invalid module count");

        StudentProgress storage prog = progress[tokenId];

        prog.modulesCompleted = modulesCompleted;
        prog.totalScore += scoreToAdd;
        prog.level = (prog.totalScore / POINTS_PER_LEVEL) + 1;
        prog.lastUpdate = block.timestamp;

        emit ProgressUpdated(tokenId, modulesCompleted, prog.totalScore, prog.level);
    }

    /**
     * @notice Generate SVG image based on progress
     * @param tokenId The token ID
     * @return SVG string
     */
    function generateSVG(uint256 tokenId) public view returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");

        StudentProgress memory prog = progress[tokenId];

        // Calculate progress percentage
        uint256 progressPercent = (prog.modulesCompleted * 100) / MAX_MODULES;

        // Determine color based on level
        string memory fillColor = _getLevelColor(prog.level);

        // Build SVG
        return
            string(
                abi.encodePacked(
                    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400">',
                    '<defs>',
                    '<linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="100%">',
                    '<stop offset="0%" style="stop-color:', fillColor, ';stop-opacity:1" />',
                    '<stop offset="100%" style="stop-color:#1a1a2e;stop-opacity:1" />',
                    '</linearGradient>',
                    '</defs>',
                    '<rect width="400" height="400" fill="url(#grad)"/>',
                    '<text x="200" y="60" font-family="Arial" font-size="24" fill="white" text-anchor="middle" font-weight="bold">VISE STUDENT</text>',
                    '<text x="200" y="100" font-family="Arial" font-size="18" fill="#e0e0e0" text-anchor="middle">Level ', prog.level.toString(), '</text>',
                    _generateProgressBar(progressPercent),
                    '<text x="200" y="200" font-family="Arial" font-size="16" fill="white" text-anchor="middle">Modules: ', prog.modulesCompleted.toString(), '/', MAX_MODULES.toString(), '</text>',
                    '<text x="200" y="230" font-family="Arial" font-size="16" fill="white" text-anchor="middle">Score: ', prog.totalScore.toString(), '</text>',
                    _generateStars(prog.modulesCompleted),
                    '</svg>'
                )
            );
    }

    /**
     * @notice Generate progress bar SVG
     * @param percent Progress percentage (0-100)
     * @return SVG string for progress bar
     */
    function _generateProgressBar(uint256 percent) private pure returns (string memory) {
        uint256 barWidth = (percent * 300) / 100;

        return
            string(
                abi.encodePacked(
                    '<rect x="50" y="140" width="300" height="30" fill="#2a2a3e" rx="15"/>',
                    '<rect x="50" y="140" width="', barWidth.toString(), '" height="30" fill="#4ecca3" rx="15"/>',
                    '<text x="200" y="160" font-family="Arial" font-size="14" fill="white" text-anchor="middle">', percent.toString(), '%</text>'
                )
            );
    }

    /**
     * @notice Generate star badges for completed modules
     * @param modulesCompleted Number of modules completed
     * @return SVG string for stars
     */
    function _generateStars(uint256 modulesCompleted) private pure returns (string memory) {
        string memory stars = '<g id="stars">';

        for (uint256 i = 0; i < MAX_MODULES; i++) {
            uint256 xPos = 80 + (i * 60);
            string memory fillColor = i < modulesCompleted ? "#FFD700" : "#4a4a4a";

            stars = string(
                abi.encodePacked(
                    stars,
                    '<polygon points="', uint256(xPos).toString(), ',280 ',
                    uint256(xPos - 8).toString(), ',296 ',
                    uint256(xPos + 8).toString(), ',296" fill="', fillColor, '"/>'
                )
            );
        }

        return string(abi.encodePacked(stars, '</g>'));
    }

    /**
     * @notice Get color based on level
     * @param level The student's level
     * @return Hex color string
     */
    function _getLevelColor(uint256 level) private pure returns (string memory) {
        if (level >= 10) return "#9b59b6"; // Purple - Master
        if (level >= 7) return "#e74c3c";  // Red - Advanced
        if (level >= 4) return "#3498db";  // Blue - Intermediate
        return "#2ecc71";                   // Green - Beginner
    }

    /**
     * @notice Generate complete token URI with metadata
     * @param tokenId The token ID
     * @return Complete data URI with JSON metadata
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");

        StudentProgress memory prog = progress[tokenId];

        string memory svg = generateSVG(tokenId);
        string memory svgBase64 = Base64.encode(bytes(svg));

        string memory json = string(
            abi.encodePacked(
                '{"name":"VISE Progress #', tokenId.toString(), '",',
                '"description":"Dynamic NFT showing VISE student progress",',
                '"attributes":[',
                '{"trait_type":"Level","value":', prog.level.toString(), '},',
                '{"trait_type":"Modules Completed","value":', prog.modulesCompleted.toString(), '},',
                '{"trait_type":"Total Score","value":', prog.totalScore.toString(), '},',
                '{"trait_type":"Last Updated","value":', prog.lastUpdate.toString(), '}',
                '],',
                '"image":"data:image/svg+xml;base64,', svgBase64, '"}'
            )
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(bytes(json))
            )
        );
    }

    /**
     * @notice Get student's progress
     * @param student The student's address
     * @return modulesCompleted Number of modules completed
     * @return totalScore Total score earned
     * @return level Current level
     * @return lastUpdate Last update timestamp
     */
    function getProgress(address student)
        public
        view
        returns (
            uint256 modulesCompleted,
            uint256 totalScore,
            uint256 level,
            uint256 lastUpdate
        )
    {
        uint256 tokenId = studentTokenId[student];
        require(tokenId != 0, "Student does not have NFT");

        StudentProgress memory prog = progress[tokenId];
        return (prog.modulesCompleted, prog.totalScore, prog.level, prog.lastUpdate);
    }

    /**
     * @notice Get token ID for a student
     * @param student The student's address
     * @return The token ID (0 if none)
     */
    function getStudentTokenId(address student) public view returns (uint256) {
        return studentTokenId[student];
    }

    /**
     * @notice Prevent transfers (soulbound)
     */
    function _update(address to, uint256 tokenId, address auth)
        internal
        virtual
        override
        returns (address)
    {
        address from = _ownerOf(tokenId);

        // Allow minting but prevent transfers
        if (from != address(0) && to != address(0)) {
            revert("Soulbound: Transfer not allowed");
        }

        return super._update(to, tokenId, auth);
    }
}
