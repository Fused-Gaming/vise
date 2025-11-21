# Module 2: Solidity & Smart Contracts

**Token Earned:** SOL-1
**Duration:** 1 Week
**Prerequisites:** PE-1 Token

## Learning Objectives

By the end of this module, you will be able to:
- Understand blockchain fundamentals and the Ethereum Virtual Machine (EVM)
- Write, compile, and deploy Solidity smart contracts
- Implement common smart contract patterns
- Test smart contracts using modern frameworks
- Identify and prevent common security vulnerabilities
- Use AI assistance for smart contract development

## Course Outline

### Day 1: Blockchain & Ethereum Fundamentals

**Topics:**
- Blockchain basics: blocks, transactions, consensus
- Ethereum architecture and the EVM
- Gas, gas limits, and transaction costs
- Accounts: EOAs vs. Contract Accounts
- State and storage in Ethereum

**Key Concepts:**
- Distributed ledger technology
- Immutability and transparency
- Transaction lifecycle
- Block explorers (Etherscan)

**Learning Activities:**
- Explore: Navigate Etherscan to understand real transactions
- Setup: Install MetaMask wallet
- Experiment: Send a testnet transaction
- Read: Ethereum Yellow Paper (summary)

### Day 2: Solidity Basics

**Topics:**
- Solidity syntax and structure
- Data types: uint, address, bool, strings, bytes
- Functions and visibility modifiers
- State variables and local variables
- Events and logging

**Key Concepts:**
- Contract structure
- Constructor functions
- Public vs. private vs. internal vs. external
- View and pure functions
- Payable functions

**Learning Activities:**
- Code: Write your first "Hello World" contract
- Deploy: Use Remix IDE to deploy to testnet
- Exercise: Create a simple storage contract
- Practice: Implement getter and setter functions

### Day 3: Intermediate Solidity

**Topics:**
- Mappings and arrays
- Structs and enums
- Modifiers and access control
- Inheritance and interfaces
- Error handling (require, assert, revert)

**Key Concepts:**
- Data structures in Solidity
- Custom modifiers for reusable logic
- OpenZeppelin contracts
- Abstract contracts
- Multiple inheritance

**Learning Activities:**
- Build: Create a voting contract with access control
- Implement: Use OpenZeppelin's Ownable pattern
- Exercise: Create a multi-signature wallet (simple version)
- Debug: Fix common Solidity errors

### Day 4: Advanced Patterns & Security

**Topics:**
- Checks-Effects-Interactions pattern
- Reentrancy attacks and prevention
- Integer overflow/underflow
- Gas optimization techniques
- Upgrade patterns (Proxy patterns)

**Key Concepts:**
- Common vulnerabilities (OWASP Top 10 for Smart Contracts)
- SafeMath and Solidity 0.8+ overflow checks
- Pull over push pattern
- Circuit breakers / Emergency stops
- Delegatecall risks

**Learning Activities:**
- Lab: Identify vulnerabilities in sample contracts
- Secure: Refactor an insecure contract
- Analyze: Review real-world exploit case studies
- Practice: Implement reentrancy guard

### Day 5: Testing & Development Workflow

**Topics:**
- Hardhat development environment
- Writing tests with Hardhat and Chai
- Test coverage and edge cases
- Deployment scripts
- Local blockchain simulation (Hardhat Network)

**Key Concepts:**
- Unit testing vs. integration testing
- Test-driven development for contracts
- Fixture patterns
- Forking mainnet for testing
- Gas reporting

**Learning Activities:**
- Setup: Initialize a Hardhat project
- Write: Create comprehensive test suite
- Deploy: Write deployment scripts for multi-contract systems
- Optimize: Measure and reduce gas costs

### Day 6: AI-Assisted Smart Contract Development

**Topics:**
- Using AI for contract generation
- Automated vulnerability scanning
- AI-powered code review
- Documentation generation
- Test case creation with AI

**Key Concepts:**
- Prompt engineering for Solidity
- Limitations of AI-generated contracts
- Human-in-the-loop verification
- Combining AI with static analysis tools

**Learning Activities:**
- Generate: Create a contract using AI prompts
- Audit: Use AI to identify potential issues
- Compare: AI-generated vs. hand-written code
- Refine: Iterate on AI output with targeted prompts

### Day 7: Assessment & Token Issuance

**Assessment Components:**
1. **Written Exam (25%)**: Solidity concepts and security
2. **Smart Contract Project (50%)**: Build a complete DApp contract
3. **Security Audit (25%)**: Review and secure a vulnerable contract

**Project Requirements:**
- Implement a functional smart contract (e.g., Token, Voting, Marketplace)
- Include comprehensive tests (>80% coverage)
- Deploy to testnet with verification
- Document all functions and security considerations

**Passing Criteria:**
- Score 80% or higher on all components
- Demonstrate secure coding practices
- Show ability to test and deploy contracts

**Token Issuance:**
- Upon successful completion, receive SOL-1 token
- Token grants access to Module 3: NFT Engineering
- Token recorded on-chain with achievement metadata

## Recommended Development Stack

### Required Tools
- **Hardhat**: Development environment
- **Remix IDE**: Browser-based Solidity IDE
- **MetaMask**: Ethereum wallet
- **Etherscan**: Blockchain explorer

### Testing Frameworks
- Hardhat with Chai assertions
- Waffle for advanced testing
- Foundry (optional, for advanced users)

### Security Tools
- Slither (static analysis)
- MythX (security analysis)
- OpenZeppelin Wizard (contract templates)

## Project Ideas

Choose one for your final assessment:

1. **Token Contract**: ERC20 with additional features (burn, mint, pause)
2. **Voting System**: On-chain governance with proposal creation
3. **Escrow Contract**: Trustless peer-to-peer transactions
4. **Staking Contract**: Lock tokens and earn rewards
5. **Marketplace**: Simple NFT or item marketplace

## Resources

### Required Reading
- Solidity Documentation (Official)
- "Mastering Ethereum" - Chapters 1-7
- OpenZeppelin Contracts Documentation
- Smart Contract Security Best Practices

### Recommended Learning
- CryptoZombies tutorial
- Ethernaut challenges
- Damn Vulnerable DeFi (after module completion)

### Community Resources
- VISE Discord #solidity channel
- Weekly smart contract office hours
- Code review sessions with mentors
- Pair programming opportunities

## Prerequisites for SOL-1 Token

To earn your SOL-1 token, you must:
1. Complete all daily learning activities
2. Achieve 80%+ on the final assessment
3. Submit a deployed and verified contract on testnet
4. Pass peer code review (2 peers must approve)
5. Complete security checklist for your contract

## Next Steps

After earning SOL-1, you will unlock:
- Module 3: NFT Engineering
- Advanced Solidity patterns library
- Access to senior developer mentorship
- Eligibility for bounty programs
- Code reviewer role (review others' contracts)
