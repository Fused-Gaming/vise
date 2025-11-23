// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/VISECurriculumPass.sol";
import "../src/VISEGovernanceToken.sol";
import "../src/VISEGovernor.sol";
import "@openzeppelin/contracts/governance/TimelockController.sol";

/**
 * @title DeployVPass
 * @notice Deployment script for V-Pass NFT with complete governance integration
 * @dev Run with: forge script script/DeployVPass.s.sol:DeployVPass --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 *
 * This script deploys:
 * 1. VISEGovernanceToken (VISE)
 * 2. TimelockController (1 day delay)
 * 3. VISEGovernor (DAO governance)
 * 4. VISECurriculumPass (V-Pass NFT)
 */
contract DeployVPass is Script {
    // Configuration
    uint256 public constant MIN_DELAY = 1 days;
    uint256 public constant TREASURY_SHARE_BPS = 8000; // 80%

    struct Deployments {
        address governanceToken;
        address timelock;
        address governor;
        address vpass;
        address treasury;
    }

    function run() external returns (Deployments memory) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        // Get configuration from environment or use defaults
        string memory nftBaseURI = vm.envOr(
            "VPASS_BASE_URI",
            string("ipfs://QmVPASS/")
        );
        address treasuryAddress = vm.envOr(
            "TREASURY_ADDRESS",
            deployer // Use deployer as default treasury
        );

        Deployments memory deployments;
        deployments.treasury = treasuryAddress;

        vm.startBroadcast(deployerPrivateKey);

        console.log("\n========================================");
        console.log("V-Pass Deployment");
        console.log("========================================\n");

        // =====================
        // 1. Deploy Governance Token
        // =====================
        console.log("1. Deploying VISEGovernanceToken...");

        VISEGovernanceToken token = new VISEGovernanceToken();
        deployments.governanceToken = address(token);

        console.log("   VISEGovernanceToken:", deployments.governanceToken);
        console.log("   Initial Supply:", token.totalSupply() / 10**18, "VISE");
        console.log("");

        // =====================
        // 2. Deploy Timelock
        // =====================
        console.log("2. Deploying TimelockController...");

        address[] memory proposers = new address[](1);
        address[] memory executors = new address[](1);
        proposers[0] = address(0); // Will set governor as proposer later
        executors[0] = address(0); // Anyone can execute

        TimelockController timelock = new TimelockController(
            MIN_DELAY,
            proposers,
            executors,
            deployer // Admin (can be renounced)
        );
        deployments.timelock = address(timelock);

        console.log("   TimelockController:", deployments.timelock);
        console.log("   Min Delay:", MIN_DELAY / 1 days, "days");
        console.log("");

        // =====================
        // 3. Deploy Governor
        // =====================
        console.log("3. Deploying VISEGovernor...");

        VISEGovernor governor = new VISEGovernor(token, timelock);
        deployments.governor = address(governor);

        console.log("   VISEGovernor:", deployments.governor);
        console.log("   Voting Delay:", governor.votingDelay(), "blocks");
        console.log("   Voting Period:", governor.votingPeriod(), "blocks");
        console.log("   Proposal Threshold:", governor.proposalThreshold() / 10**18, "VISE");
        console.log("");

        // Setup governance roles
        bytes32 proposerRole = timelock.PROPOSER_ROLE();
        bytes32 executorRole = timelock.EXECUTOR_ROLE();

        timelock.grantRole(proposerRole, address(governor));
        timelock.grantRole(executorRole, address(0));

        console.log("   Roles configured:");
        console.log("   - Governor has PROPOSER_ROLE");
        console.log("   - Everyone can execute (after timelock)");
        console.log("");

        // =====================
        // 4. Deploy V-Pass
        // =====================
        console.log("4. Deploying VISECurriculumPass (V-Pass)...");

        VISECurriculumPass vpass = new VISECurriculumPass(
            nftBaseURI,
            treasuryAddress,
            address(governor)
        );
        deployments.vpass = address(vpass);

        console.log("   VISECurriculumPass:", deployments.vpass);
        console.log("   Name:", vpass.name());
        console.log("   Symbol:", vpass.symbol());
        console.log("   Max Supply:", vpass.maxSupply());
        console.log("   Treasury:", vpass.treasury());
        console.log("   Governance:", vpass.governanceContract());
        console.log("");

        // Display pricing
        (uint256 common, uint256 rare, uint256 epic, uint256 legendary) = vpass.getAllPrices();
        console.log("   Pricing:");
        console.log("   - COMMON:", common / 10**18, "ETH");
        console.log("   - RARE:", rare / 10**18, "ETH");
        console.log("   - EPIC:", epic / 10**18, "ETH");
        console.log("   - LEGENDARY:", legendary / 10**18, "ETH");
        console.log("");

        // =====================
        // 5. Initial Configuration
        // =====================
        console.log("5. Initial Configuration...");

        // Transfer some tokens to treasury
        uint256 treasuryAllocation = 250000 * 10**18; // 250k VISE (25%)
        token.transfer(address(timelock), treasuryAllocation);
        console.log("   Transferred", treasuryAllocation / 10**18, "VISE to treasury");

        // Optionally mint some V-Passes for team/early supporters
        bool mintInitialPasses = vm.envOr("MINT_INITIAL_PASSES", false);
        if (mintInitialPasses) {
            address[] memory initialRecipients = new address[](1);
            initialRecipients[0] = deployer;

            vpass.governanceMint(
                initialRecipients,
                VISECurriculumPass.Rarity.LEGENDARY
            );

            console.log("   Minted initial V-Pass to deployer");
        }

        console.log("");

        vm.stopBroadcast();

        // =====================
        // Deployment Summary
        // =====================
        console.log("========================================");
        console.log("Deployment Complete!");
        console.log("========================================\n");

        console.log("Contract Addresses:");
        console.log("-------------------");
        console.log("VISEGovernanceToken:", deployments.governanceToken);
        console.log("TimelockController:", deployments.timelock);
        console.log("VISEGovernor:", deployments.governor);
        console.log("VISECurriculumPass:", deployments.vpass);
        console.log("Treasury:", deployments.treasury);
        console.log("");

        console.log("Next Steps:");
        console.log("-----------");
        console.log("1. Users can mint V-Pass at:", deployments.vpass);
        console.log("2. Claim VISE airdrop: token.claimAirdrop()");
        console.log("3. Delegate voting power: token.delegate(yourAddress)");
        console.log("4. Create proposals through governor");
        console.log("5. Vote on proposals");
        console.log("6. Execute proposals after timelock");
        console.log("");

        console.log("Revenue Model:");
        console.log("--------------");
        console.log("- 80% to treasury (DAO controlled)");
        console.log("- 20% to operations");
        console.log("- Withdraw via: vpass.withdrawRevenue()");
        console.log("");

        console.log("Governance Info:");
        console.log("----------------");
        console.log("- Voting Delay: 1 block");
        console.log("- Voting Period: 50,400 blocks (~1 week)");
        console.log("- Proposal Threshold: 100 VISE tokens");
        console.log("- Quorum: 4%");
        console.log("- Timelock Delay:", MIN_DELAY / 1 days, "days");
        console.log("");

        // Save deployment addresses
        string memory deploymentJson = string(
            abi.encodePacked(
                '{\n',
                '  "governanceToken": "', vm.toString(deployments.governanceToken), '",\n',
                '  "timelock": "', vm.toString(deployments.timelock), '",\n',
                '  "governor": "', vm.toString(deployments.governor), '",\n',
                '  "vpass": "', vm.toString(deployments.vpass), '",\n',
                '  "treasury": "', vm.toString(deployments.treasury), '",\n',
                '  "network": "', vm.toString(block.chainid), '",\n',
                '  "deployer": "', vm.toString(deployer), '"\n',
                '}'
            )
        );

        vm.writeFile("./deployments/vpass.json", deploymentJson);
        console.log("Deployment addresses saved to ./deployments/vpass.json\n");

        // Calculate potential revenue
        console.log("Revenue Projections:");
        console.log("-------------------");
        uint256 maxRevenue = (
            (vpass.commonSupply() * vpass.commonPrice()) +
            (vpass.rareSupply() * vpass.rarePrice()) +
            (vpass.epicSupply() * vpass.epicPrice()) +
            (vpass.legendarySupply() * vpass.legendaryPrice())
        );
        console.log("Max Potential Revenue:", maxRevenue / 10**18, "ETH");
        console.log("Max Treasury Revenue (80%):", (maxRevenue * 80 / 100) / 10**18, "ETH");
        console.log("");

        console.log("========================================\n");

        return deployments;
    }
}
