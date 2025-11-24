# Module 5: Privacy & Security - Exercises

## Foundation Exercises

### Exercise 5.1: Common Vulnerabilities Lab
**Objective**: Understand and exploit basic vulnerabilities

**Tasks**:
1. Deploy vulnerable contracts (provided in course):
   - Reentrancy vulnerability
   - Integer overflow/underflow (pre-0.8)
   - Unprotected functions
   - Uninitialized storage pointers
2. Write exploit contracts for each vulnerability
3. Successfully drain/exploit each vulnerable contract
4. Fix each vulnerability
5. Verify fixes prevent exploitation

**Success Criteria**:
- All vulnerable contracts are successfully exploited
- Exploit contracts demonstrate understanding
- Fixes completely prevent exploitation
- Tests verify both vulnerable and fixed versions
- Documentation explains each vulnerability

### Exercise 5.2: Access Control Security
**Objective**: Implement secure access control

**Tasks**:
1. Create a contract with multiple access levels:
   - Owner (full control)
   - Admin (elevated privileges)
   - User (basic access)
2. Implement without using OpenZeppelin first
3. Identify common access control mistakes:
   - tx.origin vs msg.sender
   - Missing checks
   - Front-running admin functions
4. Refactor using OpenZeppelin's AccessControl
5. Compare security of both approaches

**Success Criteria**:
- Custom implementation has proper checks
- Common mistakes are documented
- OpenZeppelin version is more secure
- All edge cases handled (zero address, etc.)
- Tests verify access restrictions

### Exercise 5.3: Reentrancy Deep Dive
**Objective**: Master reentrancy attacks and defenses

**Tasks**:
1. Create a vulnerable withdrawal contract
2. Write an attacker contract using:
   - Simple reentrancy
   - Cross-function reentrancy
   - Cross-contract reentrancy
3. Implement defensive patterns:
   - Checks-Effects-Interactions (CEI)
   - ReentrancyGuard
   - Pull over Push pattern
4. Test each defense mechanism
5. Analyze gas costs of each approach

**Success Criteria**:
- Vulnerable contract is exploitable
- All reentrancy types demonstrated
- Each defense successfully prevents attack
- Gas analysis shows efficiency trade-offs
- Documentation explains each pattern

### Exercise 5.4: Safe Math and Overflows
**Objective**: Handle integer operations safely

**Tasks**:
1. Create contracts demonstrating:
   - Overflow vulnerabilities (Solidity <0.8)
   - Underflow vulnerabilities
   - Division by zero
   - Rounding errors
2. Implement SafeMath library from scratch
3. Compare with Solidity 0.8+ built-in checks
4. Demonstrate unchecked blocks for gas optimization
5. Write tests for boundary conditions

**Success Criteria**:
- Vulnerabilities are clearly demonstrated
- Custom SafeMath works correctly
- Understanding of Solidity 0.8+ changes
- Appropriate use of unchecked blocks
- Tests cover all edge cases

## Intermediate Exercises

### Exercise 5.5: Ethernaut Challenges
**Objective**: Solve security puzzles

**Tasks**:
Complete these Ethernaut levels:
1. Fallback
2. Fallout
3. Coin Flip
4. Telephone
5. Token
6. Delegation
7. Force
8. Vault
9. King
10. Re-entrancy

For each:
- Analyze the vulnerability
- Write exploitation strategy
- Implement exploit
- Document the lesson learned

**Success Criteria**:
- At least 10 levels completed
- Each exploit is well-documented
- Lessons learned are articulated
- Code is clean and commented
- Understanding is demonstrated

### Exercise 5.6: Flash Loan Attack Simulation
**Objective**: Understand flash loan attack vectors

**Tasks**:
1. Study real flash loan attacks:
   - Harvest Finance
   - Cream Finance
   - Pancake Bunny
2. Create a simplified vulnerable DeFi protocol:
   - AMM with price oracle weakness
   - Lending protocol with collateral
3. Implement a flash loan attack:
   - Borrow from Aave/dYdX
   - Manipulate protocol
   - Profit and repay loan
4. Fix the vulnerability
5. Test that fix prevents attack

**Success Criteria**:
- Vulnerable protocol is realistic
- Attack successfully exploits weakness
- Attack flow is clear and documented
- Fix completely prevents attack
- Tests verify security improvement

### Exercise 5.7: Signature Verification Security
**Objective**: Implement secure signature verification

**Tasks**:
1. Create a meta-transaction contract using signatures
2. Implement signature verification with:
   - ECDSA signature recovery
   - EIP-712 typed data hashing
   - Nonce management
3. Prevent common attacks:
   - Signature replay
   - Cross-chain replay
   - Signature malleability
4. Add expiration timestamps
5. Write comprehensive tests

**Success Criteria**:
- Signatures are correctly verified
- EIP-712 is properly implemented
- Replay attacks are prevented
- Cross-chain replay is prevented
- Tests verify all attack vectors

### Exercise 5.8: Oracle Manipulation Defense
**Objective**: Secure price oracle integration

**Tasks**:
1. Create a lending protocol using price oracles
2. Implement vulnerable oracle usage:
   - Single source (spot price)
   - No validation
   - Instant updates
3. Demonstrate manipulation:
   - Flash loan price manipulation
   - Sandwich attack
4. Implement secure oracle usage:
   - Time-weighted average price (TWAP)
   - Multiple oracle sources
   - Bounds checking
   - Circuit breakers
5. Test manipulation resistance

**Success Criteria**:
- Vulnerable version can be manipulated
- Manipulation is clearly demonstrated
- Secure version resists manipulation
- Multiple oracles provide redundancy
- Circuit breakers activate appropriately

## Advanced Exercises

### Exercise 5.9: Proxy Storage Collision
**Objective**: Understand and prevent proxy storage issues

**Tasks**:
1. Create upgradeable proxy contract
2. Demonstrate storage collision:
   - Implementation uses slot 0
   - Proxy uses slot 0
   - Show corruption
3. Implement safe patterns:
   - Unstructured storage
   - Namespaced storage (EIP-1967)
   - Diamond storage
4. Use OpenZeppelin's upgradeable contracts
5. Verify storage safety in upgrades

**Success Criteria**:
- Storage collision is demonstrated
- Corruption is clearly shown
- Safe patterns prevent collision
- OpenZeppelin patterns are understood
- Upgrade safety is verified

### Exercise 5.10: Smart Contract Auditing
**Objective**: Conduct professional security audit

**Tasks**:
1. Choose a medium-complexity contract (provided or find on GitHub)
2. Conduct systematic audit:
   - Automated analysis (Slither, Mythril)
   - Manual code review
   - Test coverage analysis
   - Gas optimization review
   - Architecture review
3. Write professional audit report:
   - Executive summary
   - Findings (Critical, High, Medium, Low, Info)
   - Recommendations
   - Risk assessment
4. Present findings
5. Verify fixes (if available)

**Success Criteria**:
- Audit methodology is systematic
- Report is professional quality
- Findings are categorized correctly
- Recommendations are actionable
- Presentation is clear
- Risk assessment is realistic

### Exercise 5.11: Front-Running Prevention
**Objective**: Design front-running resistant mechanisms

**Tasks**:
1. Create a vulnerable DEX order mechanism
2. Demonstrate front-running attack:
   - Monitor mempool
   - Submit higher gas price transaction
   - Profit from price movement
3. Implement defenses:
   - Commit-reveal scheme
   - Batch auctions
   - MEV protection (Flashbots)
   - Time locks
4. Compare effectiveness and UX trade-offs
5. Test each approach

**Success Criteria**:
- Front-running is successfully demonstrated
- Each defense mechanism works
- Trade-offs are analyzed
- UX impact is considered
- Tests verify protection

### Exercise 5.12: Zero-Knowledge Proof Integration
**Objective**: Implement basic ZK proof verification

**Tasks**:
1. Learn ZK basics (ZK-SNARKs or ZK-STARKs)
2. Create a simple proof system:
   - Prove knowledge of a secret without revealing it
   - Use existing library (Circom/snarkjs)
3. Implement on-chain verifier:
   - Generate proof off-chain
   - Verify proof on-chain
   - Use verified proof for access control
4. Create practical application:
   - Private voting
   - Anonymous credential verification
   - Hidden asset ownership proof
5. Deploy and test on testnet

**Success Criteria**:
- ZK proof generation works
- On-chain verification succeeds
- Proof provides actual privacy
- Practical application is functional
- Gas costs are analyzed

## Integration Exercises

### Exercise 5.13: Damn Vulnerable DeFi Challenges
**Objective**: Complete advanced DeFi security challenges

**Tasks**:
Complete Damn Vulnerable DeFi challenges:
1. Unstoppable
2. Naive receiver
3. Truster
4. Side entrance
5. The rewarder
6. Selfie
7. Compromised
8. Puppet
9. Puppet V2
10. Free rider

For each:
- Understand the vulnerability
- Write detailed exploit
- Document attack vector
- Explain prevention
- Implement fix

**Success Criteria**:
- At least 10 challenges completed
- Exploits are well-crafted
- Documentation is comprehensive
- Prevention strategies are sound
- Fixes are implemented and tested

### Exercise 5.14: Secure Multi-Sig Wallet
**Objective**: Build production-grade multi-sig wallet

**Tasks**:
1. Create multi-signature wallet with:
   - M-of-N signature requirement
   - Transaction queuing
   - Transaction expiration
   - Signature replay prevention
   - Emergency recovery
2. Implement security features:
   - Daily spending limits
   - Whitelist for instant transfers
   - Time locks for large amounts
   - Signature verification (EIP-712)
3. Add functionality:
   - Token support (ETH + ERC-20)
   - Contract interaction
   - Owner management
4. Conduct self-audit
5. Deploy to testnet with documentation

**Success Criteria**:
- All security features work correctly
- No signature replay possible
- Emergency features are tested
- Comprehensive test coverage (>95%)
- Self-audit finds and fixes issues
- Documentation is complete

### Exercise 5.15: Bug Bounty Program Setup
**Objective**: Create and run a bug bounty program

**Tasks**:
1. Select or create a medium-complexity protocol
2. Set up bug bounty:
   - Define scope (in-scope contracts)
   - Severity classification
   - Reward structure
   - Disclosure policy
3. Create documentation:
   - Technical documentation
   - Known issues list
   - Submission guidelines
4. Invite peers to test
5. Manage submissions:
   - Triage reports
   - Verify vulnerabilities
   - Pay rewards (testnet tokens)
   - Coordinate fixes
6. Publish results

**Success Criteria**:
- Bug bounty is professionally structured
- Documentation is comprehensive
- Multiple submissions received
- Valid bugs are identified
- Fixes are implemented
- Results are transparently shared

## Practical Application

### Exercise 5.16: Security Audit Checklist
**Objective**: Create comprehensive security checklist

**Task**:
Develop a professional security audit checklist:
1. Access Control section:
   - Ownership and privileges
   - Role-based access
   - Function protection
2. External Calls section:
   - Reentrancy risks
   - Return value checks
   - Gas limits
3. Mathematical Operations:
   - Overflow/underflow
   - Division by zero
   - Rounding errors
4. Oracle Usage:
   - Price manipulation
   - Data staleness
   - Multiple sources
5. State Management:
   - Storage collision
   - Initialization
   - Upgradability
6. Gas Optimization:
   - Loop bounds
   - Storage packing
   - Function optimization
7. Create automated tools where possible
8. Test checklist on 5 contracts

**Success Criteria**:
- Checklist is comprehensive
- All major vulnerability types covered
- Checklist is practical and usable
- Automated tools assist manual review
- Testing validates checklist effectiveness

### Exercise 5.17: Incident Response Plan
**Objective**: Prepare for security incidents

**Task**:
Create an incident response plan:
1. Detection phase:
   - Monitoring setup (events, state changes)
   - Alert mechanisms
   - On-call procedures
2. Response phase:
   - Emergency pause procedures
   - Communication templates
   - User protection measures
3. Recovery phase:
   - Snapshot and assessment
   - Fix deployment
   - Testing procedures
4. Post-mortem:
   - Incident documentation
   - Lessons learned
   - Prevention improvements
5. Practice with simulated incident

**Success Criteria**:
- Plan covers all incident phases
- Procedures are clear and actionable
- Communication is well-planned
- Recovery process is defined
- Simulation reveals gaps
- Plan is updated based on learning

### Exercise 5.18: Privacy-Preserving Application
**Objective**: Build application with strong privacy

**Task**:
Create a private voting system:
1. Requirements:
   - Votes are confidential
   - Voters remain anonymous
   - Results are verifiable
   - No double voting
2. Implement using:
   - Commitment schemes
   - Zero-knowledge proofs
   - Ring signatures (or similar)
   - Merkle trees for efficiency
3. Build complete system:
   - Registration phase
   - Voting phase
   - Tallying phase
   - Verification mechanism
4. Deploy to testnet
5. Conduct security analysis

**Success Criteria**:
- Privacy guarantees are met
- Vote confidentiality is preserved
- Anonymity is maintained
- Results are provably correct
- No double voting possible
- System is production-ready

## Bonus Challenges

### Challenge 5.1: White Hat Rescue
Find and responsibly disclose a vulnerability in a live (testnet) contract. Coordinate with owner to fix it.

### Challenge 5.2: Gas Griefing Attack
Demonstrate and prevent gas griefing attacks in various scenarios.

### Challenge 5.3: MEV Extraction
Extract MEV from a simulated blockchain in an ethical way (testnet only).

### Challenge 5.4: Formal Verification
Use formal verification tools to prove properties of a smart contract.

## Assessment Preparation

Complete these to prepare for your PRIV-1 assessment:

1. **Vulnerability Portfolio**: Document 20+ vulnerabilities with examples
2. **Audit Report**: Complete professional audit of a real project
3. **Security Tools**: Master Slither, Mythril, Echidna
4. **CTF Completion**: Complete 15+ Ethernaut or DamnVulnerableDeFi challenges
5. **Research Paper**: Write about a specific security topic
6. **Presentation**: Present on "Top 10 Smart Contract Vulnerabilities"
7. **Bug Bounty**: Find at least one valid vulnerability

## Additional Resources

- [Smart Contract Weakness Classification (SWC)](https://swcregistry.io/)
- [Consensys Best Practices](https://consensys.github.io/smart-contract-best-practices/)
- [Trail of Bits Security Guide](https://github.com/crytic/building-secure-contracts)
- [Ethernaut](https://ethernaut.openzeppelin.com/)
- [Damn Vulnerable DeFi](https://www.damnvulnerabledefi.xyz/)
- [Secureum Bootcamp](https://secureum.substack.com/)
- [Rekt News](https://rekt.news/) (learn from hacks)

## Tools to Master

1. **Static Analysis**:
   - Slither
   - Mythril
   - Manticore

2. **Fuzzing**:
   - Echidna
   - Foundry (invariant testing)

3. **Formal Verification**:
   - Certora
   - K Framework

4. **Runtime Analysis**:
   - Tenderly
   - OpenZeppelin Defender

5. **Development**:
   - Hardhat
   - Foundry
   - Remix

## Tips for Success

1. **Think Like an Attacker**: Always ask "How can this be exploited?"
2. **Assume Worst Case**: Every input is malicious until proven otherwise
3. **Defense in Depth**: Multiple layers of security
4. **Keep Learning**: New vulnerabilities discovered constantly
5. **Read Post-Mortems**: Learn from others' mistakes
6. **Test Everything**: If it's not tested, it's not secure
7. **Simple is Secure**: Complex code has more bugs
8. **Get Reviews**: Fresh eyes find new issues
9. **Stay Updated**: Follow security researchers and news
10. **Practice Ethically**: Only hack with permission

---

Security is a journey, not a destination. Stay paranoid and keep learning! 🔒

---

**Exercise Author**: @jmenichole
