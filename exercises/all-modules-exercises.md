# Complete Exercise Collection: Modules 2-6

This document contains exercises for Modules 2-6. For Module 1 exercises, see `module-1-exercises.md`.

---

# Module 2: Solidity Smart Contracts - Exercises

## Foundation Exercises

### Exercise 2.1: First Smart Contract
**Objective**: Write and deploy a basic contract

**Task**: Create a `SimpleStorage` contract that:
- Stores a uint256 value
- Has a function to set the value
- Has a function to get the value
- Emits an event when value changes

### Exercise 2.2: Access Control
**Objective**: Implement owner-only functions

**Task**: Create a contract with:
- Owner address stored
- OnlyOwner modifier
- Function to transfer ownership
- Owner-only administrative function

### Exercise 2.3: Data Structures
**Objective**: Use mappings and arrays

**Task**: Build a `NameRegistry` that:
- Maps addresses to names
- Stores all registered addresses in an array
- Allows users to register their name
- Prevents duplicate names

## Intermediate Exercises

### Exercise 2.4: ERC-20 Token
**Objective**: Implement a token contract

**Task**: Create a complete ERC-20 token with:
- Fixed supply
- Transfer functionality
- Approve/transferFrom pattern
- Events for all transfers
- Comprehensive tests

### Exercise 2.5: Multi-Signature Wallet
**Objective**: Coordinate multiple approvals

**Task**: Build a wallet that:
- Requires M of N signatures
- Allows proposal submission
- Tracks approvals
- Executes when threshold met
- Handles ETH and tokens

### Exercise 2.6: Upgradeable Contract
**Objective**: Implement proxy pattern

**Task**: Create an upgradeable contract using:
- Transparent proxy pattern
- Separate storage and logic
- Upgrade function
- Tests for upgrade process

## Advanced Exercises

### Exercise 2.7: DeFi Protocol
**Objective**: Build a lending protocol

**Task**: Create a simple lending system:
- Users can deposit collateral
- Users can borrow against collateral
- Interest accumulates over time
- Liquidation mechanism
- Price oracle integration (mock)

### Exercise 2.8: Gas Optimization
**Objective**: Optimize contract gas usage

**Task**: Take a provided contract and:
- Reduce deployment gas by 30%
- Optimize common function gas usage
- Use appropriate data types
- Batch operations where possible
- Document all optimizations

### Exercise 2.9: Security Audit
**Objective**: Find and fix vulnerabilities

**Task**: Audit a provided vulnerable contract:
- Identify all security issues
- Categorize by severity
- Write exploit tests
- Fix all issues
- Write remediation tests

---

# Module 3: NFT Engineering - Exercises

## Foundation Exercises

### Exercise 3.1: Basic ERC-721
**Objective**: Implement NFT standard

**Task**: Create an ERC-721 contract with:
- Minting functionality
- Transfer capability
- Token URI for metadata
- Enumeration support
- Complete tests

### Exercise 3.2: Metadata Creation
**Objective**: Design NFT metadata

**Task**: Create metadata for an NFT collection:
- 10 unique JSON files
- Proper OpenSea format
- Image URLs (can be placeholders)
- Attributes and traits
- Upload to IPFS

### Exercise 3.3: Minting Mechanism
**Objective**: Control NFT distribution

**Task**: Add to your ERC-721:
- Public mint function with price
- Mint limit per wallet
- Max supply cap
- Withdrawal function for owner

## Intermediate Exercises

### Exercise 3.4: Whitelist Minting
**Objective**: Implement Merkle tree whitelist

**Task**: Create a minting system with:
- Merkle tree generation script
- Merkle proof verification on-chain
- Whitelist and public mint phases
- Different prices for each phase

### Exercise 3.5: Generative NFTs
**Objective**: Create programmatic art

**Task**: Build a system that:
- Generates 100 unique NFT traits
- Combines traits into metadata
- Calculates rarity scores
- Creates complete metadata files
- Can be minted from contract

### Exercise 3.6: ERC-1155 Implementation
**Objective**: Multi-token standard

**Task**: Create an ERC-1155 contract for:
- Game items (fungible and non-fungible)
- Batch minting capability
- URI per token type
- Trading functionality

## Advanced Exercises

### Exercise 3.7: Dynamic NFTs
**Objective**: NFTs that change over time

**Task**: Build NFTs that:
- Track owner interaction
- Level up based on criteria
- Change metadata dynamically
- Emit events for trait changes
- Generate SVG on-chain based on state

### Exercise 3.8: NFT Marketplace
**Objective**: Trading platform

**Task**: Create a marketplace with:
- List NFTs for sale
- Buy functionality
- Royalty distribution (ERC-2981)
- Offer system
- Events for all actions

### Exercise 3.9: Fractionalized NFTs
**Objective**: Divide NFT ownership

**Task**: Implement fractionalization:
- Lock NFT in vault contract
- Issue ERC-20 shares
- Voting mechanism for NFT decisions
- Buyout mechanism
- Reclaim NFT when shares burned

---

# Module 4: Tokenomics - Exercises

## Foundation Exercises

### Exercise 4.1: ERC-20 with Features
**Objective**: Enhanced token contract

**Task**: Create an ERC-20 with:
- Burnable tokens
- Pausable transfers
- Mintable by owner
- Supply cap
- Comprehensive tests

### Exercise 4.2: Vesting Contract
**Objective**: Time-locked token distribution

**Task**: Build a vesting contract:
- Linear vesting over time
- Cliff period
- Revocable by owner
- Multiple beneficiaries
- Claim function

### Exercise 4.3: Token Distribution
**Objective**: Plan token allocation

**Task**: Design distribution for a token:
- Create allocation spreadsheet
- Justify each allocation
- Plan vesting schedules
- Calculate emission over 5 years
- Visualize distribution

## Intermediate Exercises

### Exercise 4.4: Staking Contract
**Objective**: Stake tokens earn rewards

**Task**: Implement staking with:
- Deposit tokens
- Earn rewards over time
- Compound interest calculation
- Withdraw with rewards
- Lock periods with multipliers

### Exercise 4.5: Governance Token
**Objective**: DAO voting system

**Task**: Create governance with:
- Token-weighted voting
- Proposal creation
- Voting period
- Execution if passed
- Delegation support

### Exercise 4.6: Token Economics Model
**Objective**: Simulate token economy

**Task**: Build a spreadsheet model:
- Supply and demand projections
- Inflation/deflation mechanisms
- User growth scenarios
- Token price sensitivity
- Sustainability analysis

## Advanced Exercises

### Exercise 4.7: Bonding Curve
**Objective**: Automated pricing

**Task**: Implement bonding curve:
- Price increases with supply
- Buy and sell functions
- Bancor formula implementation
- Liquidity reserve management
- Slippage protection

### Exercise 4.8: Liquidity Mining
**Objective**: Incentivize liquidity

**Task**: Build liquidity mining:
- LP token staking
- Reward distribution per block
- Multiple pools with weights
- Boost mechanisms
- Analytics dashboard

### Exercise 4.9: Token Launch Simulation
**Objective**: Model token launch

**Task**: Simulate a token launch:
- Fair launch mechanism
- Anti-bot measures
- Initial liquidity provision
- Price discovery period
- Early holder incentives

---

# Module 5: Privacy & Security - Exercises

## Foundation Exercises

### Exercise 5.1: Vulnerability Identification
**Objective**: Recognize common vulnerabilities

**Task**: Review 5 vulnerable contracts and identify:
- Reentrancy issues
- Access control problems
- Integer overflow/underflow
- Unchecked external calls
- Front-running vulnerabilities

### Exercise 5.2: Secure Contract Refactoring
**Objective**: Fix security issues

**Task**: Take an insecure contract and:
- Fix all identified issues
- Add security checks
- Implement best practices
- Write security tests
- Document changes

### Exercise 5.3: Reentrancy Guard
**Objective**: Prevent reentrancy attacks

**Task**: Implement reentrancy protection:
- Create ReentrancyGuard
- Apply to vulnerable function
- Write exploit test (that fails)
- Verify protection works
- Document pattern

## Intermediate Exercises

### Exercise 5.4: Ethernaut Challenges
**Objective**: Hands-on security practice

**Task**: Complete all Ethernaut levels:
- Document each solution
- Explain the vulnerability
- Describe the fix
- Share learnings

### Exercise 5.5: Damn Vulnerable DeFi
**Objective**: DeFi-specific security

**Task**: Solve all challenges:
- Understand each protocol
- Find the exploit
- Write exploit code
- Propose fixes
- Document vulnerabilities

### Exercise 5.6: Commit-Reveal Scheme
**Objective**: Prevent front-running

**Task**: Implement commit-reveal for:
- Sealed bid auction
- Voting system
- Random number generation
- Test all edge cases

## Advanced Exercises

### Exercise 5.7: Security Audit Report
**Objective**: Professional audit

**Task**: Audit a medium-complexity DeFi protocol:
- Complete security review
- Use automated tools (Slither, Mythril)
- Manual code review
- Write professional report
- Severity classification

### Exercise 5.8: Zero-Knowledge Proof
**Objective**: Privacy-preserving verification

**Task**: Implement zk-SNARK with Circom:
- Prove you're over 18 without revealing age
- Create circuit
- Generate proof
- Verify on-chain
- Document process

### Exercise 5.9: Private Voting
**Objective**: Anonymous on-chain voting

**Task**: Build voting system with:
- Hidden votes during voting period
- Reveal phase after voting
- Verifiable results
- Anonymous voter identity
- Prevent double voting

---

# Module 6: AI-Assisted DevOps - Exercises

## Foundation Exercises

### Exercise 6.1: CI/CD Pipeline Setup
**Objective**: Automated testing and deployment

**Task**: Create GitHub Actions workflow:
- Run tests on every commit
- Lint Solidity code
- Generate coverage report
- Deploy to testnet on merge
- Send notifications

### Exercise 6.2: Deployment Scripts
**Objective**: Automated contract deployment

**Task**: Write Hardhat deploy scripts:
- Multi-network support
- Contract verification
- Save deployment addresses
- Idempotent deployments
- Rollback capability

### Exercise 6.3: Environment Management
**Objective**: Handle multiple environments

**Task**: Setup environments for:
- Local development
- Testnet staging
- Mainnet production
- Different RPC providers
- Secret management

## Intermediate Exercises

### Exercise 6.4: Monitoring Dashboard
**Objective**: Track contract activity

**Task**: Build monitoring for:
- Contract events
- Transaction volume
- Gas usage
- Error rates
- Alert on anomalies

### Exercise 6.5: Automated Testing Strategy
**Objective**: Comprehensive test coverage

**Task**: Implement testing with:
- Unit tests (>90% coverage)
- Integration tests
- Forking mainnet tests
- Gas reporting
- Mutation testing

### Exercise 6.6: AI Code Review
**Objective**: Automated code review

**Task**: Create AI-powered review:
- Analyze Solidity code
- Identify potential issues
- Suggest optimizations
- Generate review comments
- Compare with human review

## Advanced Exercises

### Exercise 6.7: Multi-Chain Deployment
**Objective**: Deploy to multiple networks

**Task**: Deploy same contracts to:
- Ethereum
- Polygon
- Optimism
- Arbitrum
- Automate verification on all

### Exercise 6.8: Incident Response System
**Objective**: Handle emergencies

**Task**: Build incident response:
- Monitoring and alerting
- Automated pause mechanism
- Notification system
- Runbook documentation
- Post-mortem template

### Exercise 6.9: Performance Optimization
**Objective**: Optimize full stack

**Task**: Optimize application:
- Frontend load time <2s
- Contract gas optimization
- API response time <100ms
- Database query optimization
- Caching strategy

---

# Integration Projects

## Project 1: Full Stack DApp
Combine all modules to build a complete application with:
- Smart contracts (Modules 2-4)
- Security measures (Module 5)
- AI features (Module 1)
- DevOps pipeline (Module 6)

## Project 2: Security-First NFT Platform
Build an NFT platform emphasizing security:
- Audited contracts (Module 5)
- NFT functionality (Module 3)
- Governance (Module 4)
- Automated security scanning (Module 6)

## Project 3: AI-Enhanced Token Economy
Create a token system with AI:
- Token contract (Module 4)
- AI-powered analytics (Module 1)
- Security audited (Module 5)
- Full DevOps (Module 6)

---

# Assessment Preparation Checklist

## For Each Module:
- ✅ Complete all foundation exercises
- ✅ Complete 70% of intermediate exercises
- ✅ Attempt 50% of advanced exercises
- ✅ Build one integration project
- ✅ Document your learnings
- ✅ Get peer reviews
- ✅ Revise based on feedback

## Best Practices:
- Commit code regularly
- Write tests for everything
- Document as you build
- Ask for help when stuck
- Review others' solutions
- Iterate and improve

Good luck with all your exercises! 🚀
