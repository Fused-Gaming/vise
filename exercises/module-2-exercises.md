# Module 2: Solidity & Smart Contracts - Exercises

## Foundation Exercises

### Exercise 2.1: First Smart Contract
**Objective**: Learn to write and deploy a basic smart contract

**Tasks**:
1. Create a `SimpleStorage` contract that stores a single unsigned integer
2. Add a function to set the value (only contract owner can call it)
3. Add a function to retrieve the current value (anyone can call it)
4. Deploy the contract to a testnet (Sepolia or Mumbai)
5. Interact with the deployed contract using Etherscan

**Success Criteria**:
- Contract compiles without errors
- Deployment is successful on testnet
- Owner can set values successfully
- Non-owners cannot set values
- Anyone can read the stored value

### Exercise 2.2: Data Types and Variables
**Objective**: Master Solidity data types

**Tasks**:
1. Create a contract that demonstrates different data types:
   - uint256, uint8, int256
   - address, bool, bytes32
   - string
2. Implement getter functions for each variable
3. Implement setter functions with type validation
4. Add a function that performs arithmetic operations on uint variables
5. Write tests for all functions

**Success Criteria**:
- All data types are correctly declared
- Getters and setters work as expected
- Type validation prevents invalid inputs
- Arithmetic operations handle edge cases (overflow prevention in Solidity 0.8+)

### Exercise 2.3: Functions and Visibility
**Objective**: Understand function visibility modifiers

**Tasks**:
1. Create a contract with functions of each visibility type:
   - public: Anyone can call
   - external: Only from outside the contract
   - internal: Only from within contract or derived contracts
   - private: Only from within the contract
2. Demonstrate when each visibility type should be used
3. Create a derived contract that calls internal functions
4. Write tests that verify visibility restrictions

**Success Criteria**:
- Each visibility type is correctly implemented
- External calls work as expected
- Inheritance works properly for internal functions
- Private functions cannot be accessed externally
- Tests verify all access patterns

### Exercise 2.4: Events and Logging
**Objective**: Implement and use events for logging

**Tasks**:
1. Create a `UserRegistry` contract that stores user information
2. Emit events when:
   - A new user is registered
   - User information is updated
   - A user is deleted
3. Include indexed parameters for efficient filtering
4. Write a script to listen to events and log them
5. Query past events using web3.js or ethers.js

**Success Criteria**:
- Events are properly defined with appropriate parameters
- Events are emitted at the right times
- Indexed parameters allow efficient filtering
- Scripts can successfully query and display events
- Event data is accurate and complete

## Intermediate Exercises

### Exercise 2.5: Mappings and Arrays
**Objective**: Work with complex data structures

**Tasks**:
1. Create a `TaskManager` contract with:
   - Mapping from address to array of tasks
   - Each task has: id, description, completed status, deadline
2. Implement functions to:
   - Add a task
   - Mark task as complete
   - Get all tasks for a user
   - Delete a task
3. Handle array deletion properly (avoid gaps)
4. Add pagination for large task lists

**Success Criteria**:
- Mappings correctly associate addresses with task arrays
- All CRUD operations work correctly
- Array deletion doesn't leave gaps
- Pagination works for large datasets
- Gas usage is optimized

### Exercise 2.6: Access Control with Modifiers
**Objective**: Implement custom modifiers for access control

**Tasks**:
1. Create a `MultiRoleContract` with three roles: Owner, Admin, User
2. Implement custom modifiers:
   - `onlyOwner`: Only contract owner
   - `onlyAdmin`: Owner or Admin
   - `onlyRegistered`: Any registered user
3. Create functions protected by these modifiers:
   - Transfer ownership (onlyOwner)
   - Add/remove admins (onlyOwner)
   - Register users (onlyAdmin)
   - Perform user actions (onlyRegistered)
4. Use OpenZeppelin's AccessControl for comparison

**Success Criteria**:
- Modifiers correctly restrict function access
- Role management functions work properly
- Custom implementation matches OpenZeppelin behavior
- All edge cases are handled (zero address, self-operations, etc.)

### Exercise 2.7: Inheritance and Interfaces
**Objective**: Use inheritance and interfaces effectively

**Tasks**:
1. Create an interface `IToken` with basic token functions:
   - totalSupply()
   - balanceOf(address)
   - transfer(address, uint256)
2. Implement the interface in a `SimpleToken` contract
3. Create a `PremiumToken` contract that inherits from `SimpleToken` and adds:
   - Transfer fee mechanism
   - Whitelist for fee-free transfers
4. Demonstrate multiple inheritance with a `PausableToken`

**Success Criteria**:
- Interface is properly defined
- Implementation matches interface exactly
- Inheritance works correctly
- Child contracts extend parent functionality
- Multiple inheritance doesn't cause conflicts

### Exercise 2.8: Error Handling
**Objective**: Master require, assert, and revert

**Tasks**:
1. Create a `Auction` contract with:
   - Bid function (must be higher than current bid)
   - Withdraw function (only for non-winning bidders)
   - End auction function (only owner, only after deadline)
2. Use:
   - `require()` for input validation
   - `assert()` for internal consistency checks
   - `revert()` with custom errors for gas efficiency
3. Implement custom error types (Solidity 0.8.4+)
4. Write comprehensive tests for all error cases

**Success Criteria**:
- All error conditions are properly handled
- require statements have clear error messages
- Custom errors save gas compared to strings
- Tests verify all error paths
- Contract state is never corrupted

## Advanced Exercises

### Exercise 2.9: Reentrancy Protection
**Objective**: Understand and prevent reentrancy attacks

**Tasks**:
1. Create a vulnerable `Bank` contract that:
   - Accepts deposits
   - Allows withdrawals
   - Has a reentrancy vulnerability
2. Write an attacker contract that exploits the vulnerability
3. Fix the vulnerability using:
   - Checks-Effects-Interactions pattern
   - ReentrancyGuard from OpenZeppelin
4. Write tests that demonstrate the attack and the fix

**Success Criteria**:
- Vulnerable contract can be exploited
- Attack contract successfully drains funds
- Fixed version prevents the attack
- Tests verify both vulnerable and secure versions
- Understanding of CEI pattern is demonstrated

### Exercise 2.10: Gas Optimization
**Objective**: Optimize contracts for gas efficiency

**Tasks**:
1. Create a `DataStore` contract with inefficient implementations:
   - Storing strings instead of bytes32
   - Using arrays instead of mappings where appropriate
   - Not caching state variables
   - Using post-increment in loops
2. Optimize the contract:
   - Use appropriate data types
   - Cache storage variables in memory
   - Use prefix increment
   - Pack variables efficiently
3. Measure gas usage before and after optimization
4. Document all optimizations made

**Success Criteria**:
- Initial implementation is measurably inefficient
- Optimizations reduce gas costs by 30%+
- All optimizations are documented
- Functionality remains correct after optimization
- Tests verify no regressions

### Exercise 2.11: Upgradeable Contracts
**Objective**: Implement proxy pattern for upgradeability

**Tasks**:
1. Create a simple `Counter` logic contract (v1)
2. Implement a proxy contract using delegatecall
3. Deploy both contracts
4. Create `Counter` v2 with additional functionality
5. Upgrade the proxy to use v2 logic
6. Ensure state is preserved across upgrades
7. Use OpenZeppelin's upgradeable contracts library

**Success Criteria**:
- Proxy pattern correctly delegates to logic contract
- State is maintained across upgrades
- New functionality works after upgrade
- Storage collision is avoided
- Initialization is handled properly

### Exercise 2.12: Oracle Integration
**Objective**: Integrate with Chainlink oracles

**Tasks**:
1. Create a `PriceFeed` contract that:
   - Fetches ETH/USD price from Chainlink
   - Stores historical prices
   - Calculates price averages
2. Create a `ConditionalExecution` contract that:
   - Executes actions based on price thresholds
   - Uses the PriceFeed contract
3. Handle oracle failures gracefully
4. Test with mocked oracle responses

**Success Criteria**:
- Successfully integrates with Chainlink price feeds
- Handles oracle data correctly
- Gracefully handles oracle failures
- Tests cover various price scenarios
- Historical data is accurately maintained

## Integration Exercises

### Exercise 2.13: DeFi Protocol Simulation
**Objective**: Combine multiple concepts into a mini DeFi protocol

**Tasks**:
1. Create a liquidity pool contract that:
   - Accepts deposits of two tokens
   - Issues LP tokens proportional to deposits
   - Allows swaps using constant product formula (x * y = k)
   - Distributes fees to LP token holders
2. Implement proper access control and reentrancy protection
3. Add events for all major actions
4. Write comprehensive tests including edge cases
5. Optimize for gas efficiency

**Success Criteria**:
- Pool math is correct (constant product formula)
- LP tokens are properly minted and burned
- Fees are correctly calculated and distributed
- All security measures are in place
- Tests achieve >95% coverage
- Gas optimization is documented

### Exercise 2.14: NFT Marketplace
**Objective**: Build a complete marketplace contract

**Tasks**:
1. Create a marketplace contract that:
   - Lists NFTs for sale (fixed price and auction)
   - Handles offers and counter-offers
   - Takes a platform fee on sales
   - Supports royalty payments to creators
2. Integrate with ERC-721 and ERC-20 tokens
3. Implement emergency pause functionality
4. Add comprehensive events and error handling
5. Write deployment and interaction scripts

**Success Criteria**:
- Supports both fixed price and auction listings
- Correctly handles NFT transfers and payments
- Platform fees and royalties are accurate
- Emergency pause works correctly
- Scripts successfully deploy and interact with contracts

### Exercise 2.15: DAO Governance System
**Objective**: Implement a complete governance system

**Tasks**:
1. Create a governance token (ERC-20)
2. Implement a Governor contract that:
   - Allows token holders to create proposals
   - Supports voting with token-weighted votes
   - Has quorum requirements
   - Includes voting delay and voting period
   - Executes successful proposals via Timelock
3. Create a Timelock contract for delayed execution
4. Write tests for complete governance workflow
5. Deploy to testnet and execute a test proposal

**Success Criteria**:
- Proposals can be created by token holders
- Voting works with proper token weighting
- Quorum and majority requirements enforced
- Timelock provides security delay
- Complete governance cycle works end-to-end
- Tests cover all governance states

## Practical Application

### Exercise 2.16: Smart Contract Security Audit
**Objective**: Conduct a security audit on existing contracts

**Task**:
Pick a contract from the list below and conduct a thorough security audit:
- OpenZeppelin's ERC-20 implementation
- A simple DEX contract (provided)
- A staking contract (provided)

Your audit should:
1. Review code for common vulnerabilities
2. Check for gas optimization opportunities
3. Verify proper error handling
4. Test edge cases
5. Write a detailed audit report with findings categorized by severity

**Success Criteria**:
- Audit report is comprehensive and well-organized
- Vulnerabilities are correctly identified
- Risk levels are appropriately assigned
- Recommendations are actionable
- Report follows industry standards

### Exercise 2.17: Multi-Signature Wallet
**Objective**: Build a production-ready multi-sig wallet

**Task**:
Create a multi-signature wallet contract that:
1. Requires M-of-N signatures for transactions
2. Supports adding/removing owners (with signatures)
3. Allows changing the signature threshold (with signatures)
4. Includes transaction queuing and expiration
5. Supports both ETH and ERC-20 token transfers
6. Emits detailed events for all actions
7. Has comprehensive tests and documentation

**Success Criteria**:
- M-of-N signature requirement is enforced
- Owner management works correctly
- Both ETH and token transfers work
- Transaction expiration prevents stale transactions
- Tests cover all scenarios including edge cases
- Documentation is clear and complete

### Exercise 2.18: Real-World Integration
**Objective**: Deploy and integrate contracts in a real scenario

**Task**:
Build a complete system:
1. Deploy contracts to testnet:
   - ERC-20 token
   - Staking contract
   - Rewards distributor
2. Create a frontend (React/Next.js) that:
   - Connects wallet (MetaMask)
   - Shows token balance
   - Allows staking and unstaking
   - Displays rewards
3. Set up a subgraph for indexing events
4. Document the complete setup and usage

**Success Criteria**:
- All contracts deployed and verified
- Frontend successfully interacts with contracts
- Wallet connection works smoothly
- Subgraph indexes data correctly
- Complete documentation for setup and use
- System works end-to-end on testnet

## Bonus Challenges

### Challenge 2.1: Gas Golf
Optimize a given contract to use the minimum possible gas. Compete with peers to achieve the lowest gas usage while maintaining functionality.

### Challenge 2.2: Solidity Puzzle
Solve advanced Solidity puzzles from:
- [Ethernaut](https://ethernaut.openzeppelin.com/)
- [Capture the Ether](https://capturetheether.com/)
- [Damn Vulnerable DeFi](https://www.damnvulnerabledefi.xyz/)

### Challenge 2.3: Contract Verification
Write a contract that can verify other contracts on-chain (bytecode verification, signature verification, etc.)

### Challenge 2.4: Flash Loan Implementation
Implement a flash loan contract that:
- Lends any amount without collateral
- Requires repayment in the same transaction
- Charges a fee
- Reverts if not repaid

## Assessment Preparation

Complete these to prepare for your SOL-1 assessment:

1. **Portfolio**: Deploy 5 contracts to testnet with verified source code
2. **Security Checklist**: Create a personal smart contract security checklist
3. **Gas Optimization Guide**: Document your gas optimization strategies
4. **Testing Framework**: Build a reusable testing framework for Solidity
5. **Reflection**: Write about lessons learned and best practices

## Additional Resources

- [Solidity Documentation](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Ethereum Development Best Practices](https://consensys.github.io/smart-contract-best-practices/)
- [Solidity Patterns](https://fravoll.github.io/solidity-patterns/)
- [Smart Contract Weakness Classification](https://swcregistry.io/)

## Tips for Success

1. **Test Thoroughly**: Write tests before and during implementation
2. **Start Simple**: Begin with basic functionality, then add complexity
3. **Read Code**: Study production contracts from reputable projects
4. **Ask Questions**: Use Discord and forums when stuck
5. **Document Everything**: Good documentation helps learning and debugging
6. **Security First**: Always consider security implications
7. **Gas Awareness**: Think about gas costs from the start
8. **Use Tools**: Leverage Hardhat, Foundry, and Remix effectively
9. **Version Control**: Commit frequently with clear messages
10. **Peer Review**: Share your code and review others' code

---

Remember: These exercises build upon each other. Complete them in order for the best learning experience. Good luck! 🚀

---

**Exercise Author**: @jmenichole
