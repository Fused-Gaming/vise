// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/VISEGovernanceToken.sol";
import "../src/VISEGovernor.sol";
import "@openzeppelin/contracts/governance/TimelockController.sol";

/**
 * @title DeployModule4
 * @notice Deployment script for Module 4 demonstration contracts (Governance/DAO)
 * @dev Run with: forge script script/DeployModule4.s.sol:DeployModule4 --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 */
contract DeployModule4 is Script {
    // Timelock parameters
    uint256 public constant MIN_DELAY = 1 days; // Minimum delay for timelock

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy Governance Token
        VISEGovernanceToken token = new VISEGovernanceToken();
        console.log("VISEGovernanceToken deployed at:", address(token));

        // 2. Deploy Timelock Controller
        address[] memory proposers = new address[](1);
        address[] memory executors = new address[](1);

        // Governor will be the proposer (we'll set this after deployment)
        proposers[0] = address(0); // Placeholder, will update later
        executors[0] = address(0); // Anyone can execute

        TimelockController timelock = new TimelockController(
            MIN_DELAY,
            proposers,
            executors,
            deployer // Admin (can be renounced later)
        );
        console.log("TimelockController deployed at:", address(timelock));

        // 3. Deploy Governor
        VISEGovernor governor = new VISEGovernor(token, timelock);
        console.log("VISEGovernor deployed at:", address(governor));

        // 4. Setup roles - Grant proposer role to governor
        bytes32 proposerRole = timelock.PROPOSER_ROLE();
        bytes32 executorRole = timelock.EXECUTOR_ROLE();
        bytes32 adminRole = timelock.DEFAULT_ADMIN_ROLE();

        timelock.grantRole(proposerRole, address(governor));
        console.log("Granted PROPOSER_ROLE to Governor");

        timelock.grantRole(executorRole, address(0)); // Anyone can execute
        console.log("Granted EXECUTOR_ROLE to everyone");

        // Optional: Revoke admin role from deployer (for full decentralization)
        // Uncomment the line below to make it fully decentralized
        // timelock.revokeRole(adminRole, deployer);

        // 5. Transfer some tokens to community (optional)
        uint256 communityAllocation = 100000 * 10**18; // 100k tokens
        token.transfer(address(timelock), communityAllocation);
        console.log("Transferred", communityAllocation / 10**18, "tokens to treasury");

        vm.stopBroadcast();

        // Log deployment summary
        console.log("\n=== Module 4 Deployment Summary ===");
        console.log("VISEGovernanceToken:", address(token));
        console.log("TimelockController:", address(timelock));
        console.log("VISEGovernor:", address(governor));
        console.log("Timelock Delay:", MIN_DELAY, "seconds");
        console.log("===================================\n");

        console.log("Next steps:");
        console.log("1. Users should claim airdrop: token.claimAirdrop()");
        console.log("2. Users must delegate voting power: token.delegate(address)");
        console.log("3. Create proposals through governor.propose()");
        console.log("4. Vote on proposals through governor.castVote()");

        // Save deployment addresses
        string memory deploymentJson = string(
            abi.encodePacked(
                '{\n',
                '  "token": "', vm.toString(address(token)), '",\n',
                '  "timelock": "', vm.toString(address(timelock)), '",\n',
                '  "governor": "', vm.toString(address(governor)), '",\n',
                '  "minDelay": ', vm.toString(MIN_DELAY), '\n',
                '}'
            )
        );

        vm.writeFile("./deployments/module4.json", deploymentJson);
        console.log("\nDeployment addresses saved to ./deployments/module4.json");
    }
}
