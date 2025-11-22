// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/VISEAchievementNFT.sol";
import "../src/DynamicProgressNFT.sol";

/**
 * @title DeployModule3
 * @notice Deployment script for Module 3 demonstration contracts (NFTs)
 * @dev Run with: forge script script/DeployModule3.s.sol:DeployModule3 --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 */
contract DeployModule3 is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        string memory baseURI = vm.envOr("NFT_BASE_URI", string("ipfs://QmVISE/"));

        vm.startBroadcast(deployerPrivateKey);

        // Deploy VISEAchievementNFT
        VISEAchievementNFT achievementNFT = new VISEAchievementNFT(baseURI);
        console.log("VISEAchievementNFT deployed at:", address(achievementNFT));

        // Deploy DynamicProgressNFT
        DynamicProgressNFT progressNFT = new DynamicProgressNFT();
        console.log("DynamicProgressNFT deployed at:", address(progressNFT));

        vm.stopBroadcast();

        // Log deployment summary
        console.log("\n=== Module 3 Deployment Summary ===");
        console.log("VISEAchievementNFT:", address(achievementNFT));
        console.log("DynamicProgressNFT:", address(progressNFT));
        console.log("Base URI:", baseURI);
        console.log("===================================\n");

        // Save deployment addresses
        string memory deploymentJson = string(
            abi.encodePacked(
                '{\n',
                '  "achievementNFT": "', vm.toString(address(achievementNFT)), '",\n',
                '  "progressNFT": "', vm.toString(address(progressNFT)), '",\n',
                '  "baseURI": "', baseURI, '"\n',
                '}'
            )
        );

        vm.writeFile("./deployments/module3.json", deploymentJson);
        console.log("Deployment addresses saved to ./deployments/module3.json");
    }
}
