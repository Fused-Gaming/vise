// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/VulnerableBank.sol";
import "../src/SecureBank.sol";

/**
 * @title DeployModule5
 * @notice Deployment script for Module 5 demonstration contracts (Security)
 * @dev Run with: forge script script/DeployModule5.s.sol:DeployModule5 --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 *
 * ⚠️  WARNING: The VulnerableBank contract is intentionally insecure and should
 * ONLY be deployed to testnets for educational purposes. NEVER deploy to mainnet!
 */
contract DeployModule5 is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy VulnerableBank (for educational purposes only!)
        VulnerableBank vulnerableBank = new VulnerableBank();
        console.log("VulnerableBank deployed at:", address(vulnerableBank));
        console.log("WARNING: This contract is intentionally vulnerable!");

        // Fund vulnerable bank with 5 ETH for demonstrations
        (bool success1, ) = address(vulnerableBank).call{value: 5 ether}("");
        require(success1, "Failed to fund vulnerable bank");
        console.log("VulnerableBank funded with 5 ETH");

        // Deploy SecureBank (best practices implementation)
        SecureBank secureBank = new SecureBank();
        console.log("SecureBank deployed at:", address(secureBank));

        // Fund secure bank with 5 ETH
        (bool success2, ) = address(secureBank).call{value: 5 ether}("");
        require(success2, "Failed to fund secure bank");
        console.log("SecureBank funded with 5 ETH");

        vm.stopBroadcast();

        // Log deployment summary
        console.log("\n=== Module 5 Deployment Summary ===");
        console.log("VulnerableBank:", address(vulnerableBank));
        console.log("SecureBank:", address(secureBank));
        console.log("===================================\n");

        console.log("Educational Notes:");
        console.log("1. VulnerableBank demonstrates:");
        console.log("   - Reentrancy vulnerability");
        console.log("   - Missing access control");
        console.log("   - State update after external call");
        console.log("");
        console.log("2. SecureBank demonstrates:");
        console.log("   - ReentrancyGuard protection");
        console.log("   - Access control (Ownable)");
        console.log("   - Checks-Effects-Interactions pattern");
        console.log("   - Pausable circuit breaker");
        console.log("   - Withdrawal limits");
        console.log("");
        console.log("WARNING: DO NOT use VulnerableBank in production!");
        console.log("         It is for educational purposes ONLY.");

        // Save deployment addresses
        string memory deploymentJson = string(
            abi.encodePacked(
                '{\n',
                '  "vulnerableBank": "', vm.toString(address(vulnerableBank)), '",\n',
                '  "secureBank": "', vm.toString(address(secureBank)), '",\n',
                '  "warning": "VulnerableBank is intentionally insecure - testnet only!"\n',
                '}'
            )
        );

        vm.writeFile("./deployments/module5.json", deploymentJson);
        console.log("\nDeployment addresses saved to ./deployments/module5.json");
    }
}
