// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/HelloWorld.sol";
import "../src/SimpleVoting.sol";
import "../src/SimpleStaking.sol";

/**
 * @title DeployModule2
 * @notice Deployment script for Module 2 demonstration contracts
 * @dev Run with: forge script script/DeployModule2.s.sol:DeployModule2 --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 */
contract DeployModule2 is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy HelloWorld
        HelloWorld helloWorld = new HelloWorld("Hello from VISE Module 2!");
        console.log("HelloWorld deployed at:", address(helloWorld));

        // Deploy SimpleVoting
        SimpleVoting voting = new SimpleVoting();
        console.log("SimpleVoting deployed at:", address(voting));

        // Deploy SimpleStaking
        SimpleStaking staking = new SimpleStaking();
        console.log("SimpleStaking deployed at:", address(staking));

        // Fund staking contract with 10 ETH for rewards
        (bool success, ) = address(staking).call{value: 10 ether}("");
        require(success, "Failed to fund staking contract");
        console.log("Staking contract funded with 10 ETH");

        vm.stopBroadcast();

        // Log deployment summary
        console.log("\n=== Module 2 Deployment Summary ===");
        console.log("HelloWorld:", address(helloWorld));
        console.log("SimpleVoting:", address(voting));
        console.log("SimpleStaking:", address(staking));
        console.log("===================================\n");
    }
}
