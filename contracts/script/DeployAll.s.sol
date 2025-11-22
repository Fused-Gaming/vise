// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/HelloWorld.sol";
import "../src/SimpleVoting.sol";
import "../src/SimpleStaking.sol";
import "../src/VISEAchievementNFT.sol";
import "../src/DynamicProgressNFT.sol";
import "../src/VISEGovernanceToken.sol";
import "../src/VISEGovernor.sol";
import "../src/VulnerableBank.sol";
import "../src/SecureBank.sol";
import "@openzeppelin/contracts/governance/TimelockController.sol";

/**
 * @title DeployAll
 * @notice Master deployment script for ALL VISE demonstration contracts
 * @dev Run with: forge script script/DeployAll.s.sol:DeployAll --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 */
contract DeployAll is Script {
    uint256 public constant MIN_DELAY = 1 days;

    struct Deployments {
        // Module 2
        address helloWorld;
        address simpleVoting;
        address simpleStaking;
        // Module 3
        address achievementNFT;
        address progressNFT;
        // Module 4
        address governanceToken;
        address timelock;
        address governor;
        // Module 5
        address vulnerableBank;
        address secureBank;
    }

    function run() external returns (Deployments memory) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        string memory nftBaseURI = vm.envOr("NFT_BASE_URI", string("ipfs://QmVISE/"));

        Deployments memory deployments;

        vm.startBroadcast(deployerPrivateKey);

        console.log("\n========================================");
        console.log("VISE Curriculum Demonstration Deployment");
        console.log("========================================\n");

        // =====================
        // MODULE 2: Fundamentals
        // =====================
        console.log("Deploying Module 2 (Fundamentals)...");

        deployments.helloWorld = address(new HelloWorld("Hello from VISE!"));
        console.log("  HelloWorld:", deployments.helloWorld);

        deployments.simpleVoting = address(new SimpleVoting());
        console.log("  SimpleVoting:", deployments.simpleVoting);

        deployments.simpleStaking = address(new SimpleStaking());
        console.log("  SimpleStaking:", deployments.simpleStaking);

        // Fund staking
        (bool success1, ) = deployments.simpleStaking.call{value: 10 ether}("");
        require(success1, "Failed to fund staking");
        console.log("  Funded staking with 10 ETH\n");

        // =====================
        // MODULE 3: NFTs
        // =====================
        console.log("Deploying Module 3 (NFTs)...");

        deployments.achievementNFT = address(new VISEAchievementNFT(nftBaseURI));
        console.log("  VISEAchievementNFT:", deployments.achievementNFT);

        deployments.progressNFT = address(new DynamicProgressNFT());
        console.log("  DynamicProgressNFT:", deployments.progressNFT);
        console.log("");

        // =====================
        // MODULE 4: Governance
        // =====================
        console.log("Deploying Module 4 (Governance)...");

        VISEGovernanceToken token = new VISEGovernanceToken();
        deployments.governanceToken = address(token);
        console.log("  VISEGovernanceToken:", deployments.governanceToken);

        address[] memory proposers = new address[](1);
        address[] memory executors = new address[](1);
        proposers[0] = address(0);
        executors[0] = address(0);

        TimelockController timelock = new TimelockController(
            MIN_DELAY,
            proposers,
            executors,
            deployer
        );
        deployments.timelock = address(timelock);
        console.log("  TimelockController:", deployments.timelock);

        VISEGovernor governor = new VISEGovernor(token, timelock);
        deployments.governor = address(governor);
        console.log("  VISEGovernor:", deployments.governor);

        // Setup governance roles
        bytes32 proposerRole = timelock.PROPOSER_ROLE();
        bytes32 executorRole = timelock.EXECUTOR_ROLE();

        timelock.grantRole(proposerRole, address(governor));
        timelock.grantRole(executorRole, address(0));

        // Transfer tokens to treasury
        token.transfer(address(timelock), 100000 * 10**18);
        console.log("  Transferred 100k tokens to treasury\n");

        // =====================
        // MODULE 5: Security
        // =====================
        console.log("Deploying Module 5 (Security)...");

        deployments.vulnerableBank = address(new VulnerableBank());
        console.log("  VulnerableBank:", deployments.vulnerableBank);
        console.log("  WARNING: Intentionally vulnerable - testnet only!");

        deployments.secureBank = address(new SecureBank());
        console.log("  SecureBank:", deployments.secureBank);

        // Fund both banks
        (bool success2, ) = deployments.vulnerableBank.call{value: 5 ether}("");
        require(success2, "Failed to fund vulnerable bank");

        (bool success3, ) = deployments.secureBank.call{value: 5 ether}("");
        require(success3, "Failed to fund secure bank");

        console.log("  Funded both banks with 5 ETH each\n");

        vm.stopBroadcast();

        // =====================
        // Deployment Summary
        // =====================
        console.log("========================================");
        console.log("Deployment Complete!");
        console.log("========================================\n");

        console.log("Module 2 - Fundamentals:");
        console.log("  HelloWorld:", deployments.helloWorld);
        console.log("  SimpleVoting:", deployments.simpleVoting);
        console.log("  SimpleStaking:", deployments.simpleStaking);
        console.log("");

        console.log("Module 3 - NFTs:");
        console.log("  VISEAchievementNFT:", deployments.achievementNFT);
        console.log("  DynamicProgressNFT:", deployments.progressNFT);
        console.log("");

        console.log("Module 4 - Governance:");
        console.log("  VISEGovernanceToken:", deployments.governanceToken);
        console.log("  TimelockController:", deployments.timelock);
        console.log("  VISEGovernor:", deployments.governor);
        console.log("");

        console.log("Module 5 - Security:");
        console.log("  VulnerableBank:", deployments.vulnerableBank);
        console.log("  SecureBank:", deployments.secureBank);
        console.log("");

        // Save all deployment addresses
        string memory deploymentJson = string(
            abi.encodePacked(
                '{\n',
                '  "module2": {\n',
                '    "helloWorld": "', vm.toString(deployments.helloWorld), '",\n',
                '    "simpleVoting": "', vm.toString(deployments.simpleVoting), '",\n',
                '    "simpleStaking": "', vm.toString(deployments.simpleStaking), '"\n',
                '  },\n',
                '  "module3": {\n',
                '    "achievementNFT": "', vm.toString(deployments.achievementNFT), '",\n',
                '    "progressNFT": "', vm.toString(deployments.progressNFT), '"\n',
                '  },\n',
                '  "module4": {\n',
                '    "governanceToken": "', vm.toString(deployments.governanceToken), '",\n',
                '    "timelock": "', vm.toString(deployments.timelock), '",\n',
                '    "governor": "', vm.toString(deployments.governor), '"\n',
                '  },\n',
                '  "module5": {\n',
                '    "vulnerableBank": "', vm.toString(deployments.vulnerableBank), '",\n',
                '    "secureBank": "', vm.toString(deployments.secureBank), '"\n',
                '  }\n',
                '}'
            )
        );

        vm.writeFile("./deployments/all.json", deploymentJson);
        console.log("Deployment addresses saved to ./deployments/all.json\n");

        return deployments;
    }
}
