# Module 4: Tokenomics - Exercises

## Foundation Exercises

### Exercise 4.1: Basic ERC-20 Token
**Objective**: Create a standard ERC-20 token

**Tasks**:
1. Implement ERC-20 interface from scratch:
   - totalSupply, balanceOf, transfer, approve, transferFrom, allowance
2. Add Events: Transfer, Approval
3. Set token name, symbol, and decimals
4. Implement initial supply minted to deployer
5. Write comprehensive tests for all functions

**Success Criteria**:
- All ERC-20 functions work correctly
- Transfer and approval mechanics function properly
- Allowances are tracked accurately
- Events are emitted on all state changes
- Tests achieve >95% coverage

### Exercise 4.2: Token with Supply Controls
**Objective**: Implement mintable and burnable tokens

**Tasks**:
1. Create an ERC-20 token using OpenZeppelin
2. Add Ownable for access control
3. Implement mint function (only owner)
4. Implement burn function (anyone can burn their tokens)
5. Add a supply cap (maximum 1 million tokens)
6. Prevent minting beyond cap
7. Track total burned tokens

**Success Criteria**:
- Only owner can mint new tokens
- Any holder can burn their own tokens
- Supply cap is enforced
- Total supply updates correctly
- Burned tokens are tracked
- Events log all mint/burn operations

### Exercise 4.3: Token Distribution Models
**Objective**: Design and analyze token distribution

**Tasks**:
1. Research 5 successful token projects (UNI, AAVE, MKR, etc.)
2. Document their distribution strategies:
   - Team allocation and vesting
   - Community/public sale
   - Treasury/DAO allocation
   - Liquidity mining rewards
   - Ecosystem/development fund
3. Create a distribution model for a hypothetical project:
   - Total supply: 100 million tokens
   - Design fair and sustainable distribution
   - Calculate vesting schedules
4. Model token release over 4 years

**Success Criteria**:
- Analysis of 5 projects is thorough
- Distribution model is well-reasoned
- All percentages add to 100%
- Vesting schedules prevent dumps
- Model accounts for all stakeholders
- Charts/graphs visualize distribution

### Exercise 4.4: Linear Vesting Contract
**Objective**: Implement time-based token vesting

**Tasks**:
1. Create a vesting contract that:
   - Locks tokens for beneficiaries
   - Releases linearly over time (e.g., 12 months)
   - Allows claiming of vested tokens
   - Supports cliff period (e.g., 3 months before vesting starts)
2. Add functions to:
   - Create vesting schedule
   - Check vested amount
   - Claim vested tokens
   - Revoke unvested tokens (only owner)
3. Emit events for all actions

**Success Criteria**:
- Vesting calculations are mathematically correct
- Cliff period is enforced
- Only vested tokens can be claimed
- Beneficiary can claim multiple times
- Owner can revoke for terminated members
- Tests verify vesting at different time points

## Intermediate Exercises

### Exercise 4.5: Governance Token with Delegation
**Objective**: Implement vote delegation mechanism

**Tasks**:
1. Create a governance token based on OpenZeppelin's ERC20Votes
2. Implement vote delegation:
   - Users can delegate voting power
   - Delegated votes accumulate
   - Users can change delegation
3. Add snapshot mechanism for proposal voting
4. Implement getPastVotes for historical vote counts
5. Write tests for delegation scenarios

**Success Criteria**:
- Delegation works correctly
- Vote power accumulates for delegates
- Snapshots capture state accurately
- Historical votes can be queried
- Self-delegation is possible
- Tests cover delegation edge cases

### Exercise 4.6: Staking Rewards System
**Objective**: Build token staking with rewards

**Tasks**:
1. Create a staking contract:
   - Users stake ERC-20 tokens
   - Earn rewards based on stake amount and duration
   - Rewards calculated per block/second
   - Users can stake more anytime
   - Users can withdraw stake anytime
2. Implement reward calculation:
   - Track total staked
   - Calculate individual share
   - Distribute proportionally
3. Add emergency withdrawal (forfeit rewards)
4. Include reward rate adjustment (only owner)

**Success Criteria**:
- Staking and unstaking work correctly
- Reward calculations are accurate
- Multiple stakers don't affect each other's rewards
- Reward rate can be adjusted
- Emergency withdrawal works
- Tests verify reward math extensively

### Exercise 4.7: Fee-on-Transfer Token
**Objective**: Implement automatic fee mechanism

**Tasks**:
1. Create a token with transfer fees:
   - 2% fee on every transfer
   - 1% burned (deflationary)
   - 1% to treasury
2. Implement fee exemptions:
   - Whitelist addresses (no fees)
   - Trading pairs (DEX pools)
3. Add ability to:
   - Adjust fee percentages (within limits)
   - Update treasury address
   - Manage whitelist
4. Handle fees in all transfer scenarios

**Success Criteria**:
- Fees are correctly calculated and deducted
- Burn mechanism reduces total supply
- Treasury receives correct amount
- Whitelisted addresses pay no fees
- Fee adjustments work within safe limits
- All transfer types (transfer, transferFrom) handle fees

### Exercise 4.8: Token Buyback and Burn
**Objective**: Implement buyback mechanism

**Tasks**:
1. Create a token with buyback feature:
   - Accumulate ETH/tokens from fees
   - Periodically buy tokens from DEX
   - Burn bought tokens
2. Implement automated buyback:
   - Trigger based on treasury threshold
   - Swap using Uniswap V2/V3
   - Burn acquired tokens
3. Add manual buyback function (owner)
4. Track total bought back and burned
5. Emit events for transparency

**Success Criteria**:
- Buyback mechanism executes correctly
- DEX integration works (testnet)
- Tokens are successfully burned
- Buyback amounts are tracked
- Events provide complete transparency
- Tests simulate multiple buyback cycles

## Advanced Exercises

### Exercise 4.9: Liquidity Mining Program
**Objective**: Design incentivized liquidity provision

**Tasks**:
1. Create liquidity mining contract:
   - Users provide liquidity to DEX pool
   - Deposit LP tokens to earn rewards
   - Rewards distributed per block
   - Multiple pools with different weights
2. Implement features:
   - Pool creation with reward allocation
   - Stake LP tokens
   - Claim rewards
   - Withdraw LP tokens
   - Boost for long-term stakers (multipliers)
3. Add emissions schedule (reducing over time)
4. Write comprehensive tests

**Success Criteria**:
- Multiple pools work independently
- Reward distribution is fair and accurate
- Emissions follow defined schedule
- Boost multipliers work correctly
- Users can enter/exit freely
- Tests cover multi-pool scenarios

### Exercise 4.10: Bonding Curve Token
**Objective**: Implement algorithmic price discovery

**Tasks**:
1. Create a bonding curve contract:
   - Price increases with supply (linear curve)
   - Users buy tokens by sending ETH
   - Users sell tokens back for ETH
   - Reserve backs all tokens
2. Implement bonding curve math:
   - Linear: price = basePrice + (supply × slope)
   - Calculate buy/sell amounts
   - Handle slippage
3. Add features:
   - Configurable curve parameters
   - Fee on transactions
   - Minimum/maximum purchase
4. Test extensively with different curves

**Success Criteria**:
- Bonding curve math is correct
- Buy and sell prices follow curve
- Reserve is always sufficient
- Fees are correctly applied
- Large transactions have appropriate slippage
- Tests verify economic invariants

### Exercise 4.11: Dutch Auction Token Sale
**Objective**: Conduct fair token sale via Dutch auction

**Tasks**:
1. Create Dutch auction contract:
   - Starting price high, decreases over time
   - Linear or exponential price decrease
   - Auction ends when sold out or time expires
   - Final price is clearing price for all
2. Implement:
   - Commit ETH during auction
   - Calculate final tokens based on clearing price
   - Refund excess ETH
   - Claim tokens after auction
3. Handle edge cases:
   - Over-subscription
   - Under-subscription
   - Last-minute purchases
4. Add whitelist for early access

**Success Criteria**:
- Price decreases correctly over time
- Clearing price calculated accurately
- All buyers pay same final price
- Refunds are correct
- Token distribution is fair
- Tests simulate various auction scenarios

### Exercise 4.12: Gauge Voting System
**Objective**: Implement Curve-style gauge voting

**Tasks**:
1. Create governance system where:
   - Users lock tokens for voting power
   - Vote on multiple gauges (pools/proposals)
   - Longer locks = more voting power
   - Voting power decays over time
2. Implement:
   - Vote-escrowed tokens (veTokens)
   - Lock duration choice (1 week to 4 years)
   - Voting on gauge weights
   - Reward distribution based on votes
3. Add boost calculation for staking
4. Implement vote delegation

**Success Criteria**:
- Lock mechanism works correctly
- Voting power increases with lock time
- Power decays linearly to zero
- Gauge votes affect reward distribution
- Boost calculations are accurate
- Tests verify complex voting scenarios

## Integration Exercises

### Exercise 4.13: Complete Token Economy
**Objective**: Design a full token ecosystem

**Tasks**:
1. Create interconnected contracts:
   - Governance token (ERC20Votes)
   - Staking contract (earn protocol fees)
   - Treasury/DAO (governed by token holders)
   - Liquidity mining (incentivize liquidity)
   - Vesting (for team and investors)
2. Implement governance proposals:
   - Adjust staking rewards
   - Allocate treasury funds
   - Change protocol parameters
3. Model token flow through entire system
4. Deploy complete system to testnet
5. Document tokenomics in whitepaper style

**Success Criteria**:
- All contracts work together cohesively
- Governance can control key parameters
- Token flows are balanced and sustainable
- System is tested end-to-end
- Documentation is comprehensive
- Economic model is sound

### Exercise 4.14: Algorithmic Stablecoin
**Objective**: Build a simple algorithmic stablecoin

**Tasks**:
1. Create a stablecoin system:
   - Stablecoin (targets $1)
   - Governance/utility token
   - Reserve pool
   - Price oracle integration
2. Implement stability mechanisms:
   - Mint when above peg (sell to bring down price)
   - Burn when below peg (buy to bring up price)
   - Bond mechanism for capital efficiency
3. Add collateralization:
   - Accept collateral (ETH, other tokens)
   - Calculate collateral ratio
   - Liquidation mechanism
4. Test with simulated market conditions

**Success Criteria**:
- Stablecoin maintains peg in testing
- Stability mechanisms activate appropriately
- Collateralization prevents under-backing
- Liquidations work correctly
- Oracle integration is secure
- Tests simulate various scenarios

### Exercise 4.15: DAO with Token-Based Treasury
**Objective**: Full DAO implementation with treasury management

**Tasks**:
1. Create complete DAO system:
   - Governance token with voting
   - Treasury contract (holds funds)
   - Governor contract (proposals)
   - Timelock (execution delay)
2. Implement proposal types:
   - Transfer funds from treasury
   - Invest in DeFi protocols
   - Buy tokens for treasury
   - Adjust governance parameters
3. Add delegation and quorum
4. Create proposal templates
5. Deploy and execute test proposals

**Success Criteria**:
- Complete governance cycle works
- Treasury is securely controlled
- Timelock provides security
- Quorum prevents low-participation decisions
- Various proposal types execute correctly
- System is tested thoroughly

## Practical Application

### Exercise 4.16: Token Launch Strategy
**Objective**: Plan and execute a token launch

**Task**:
Design and document a complete token launch:
1. Create tokenomics document:
   - Total supply and distribution
   - Vesting schedules
   - Utility and value accrual
   - Launch mechanism (fair launch, auction, etc.)
2. Implement launch contracts:
   - Token contract
   - Sale mechanism
   - Vesting contracts
   - Initial liquidity setup
3. Plan post-launch:
   - Liquidity provision
   - Exchange listings
   - Governance activation
   - Community incentives
4. Create launch checklist and timeline

**Success Criteria**:
- Tokenomics are well-designed and documented
- Launch mechanism is fair and transparent
- All contracts are audited (self-audit minimum)
- Post-launch plan is comprehensive
- Timeline is realistic
- Documentation is professional

### Exercise 4.17: DeFi Protocol Token
**Objective**: Design token for a DeFi protocol

**Task**:
Create a token for a lending/DEX/vault protocol:
1. Design token utility:
   - Governance over protocol
   - Fee sharing with stakers
   - Boost for protocol users
   - Insurance fund backing
2. Implement token features:
   - Staking for governance power
   - Fee distribution to stakers
   - Boost calculation
   - Emergency mechanisms
3. Model token value accrual
4. Design incentive alignment
5. Deploy and demonstrate functionality

**Success Criteria**:
- Token utility is clear and valuable
- Fee distribution works correctly
- Governance power correlates with commitment
- Incentives align all stakeholders
- Value accrual mechanisms function
- Model demonstrates sustainability

### Exercise 4.18: Real-World Tokenomics Analysis
**Objective**: Analyze and critique existing tokenomics

**Task**:
Choose 3 real projects and perform deep analysis:
1. For each project, analyze:
   - Token distribution and vesting
   - Utility and value capture
   - Inflation/deflation mechanics
   - Governance structure
   - Incentive alignment
   - Sustainability
2. Identify strengths and weaknesses
3. Propose improvements
4. Create comparative report
5. Present findings

**Success Criteria**:
- Analysis is thorough and objective
- Critiques are well-reasoned
- Improvements are practical
- Report is professional quality
- Presentations clearly communicate findings
- Understanding of tokenomics is demonstrated

## Bonus Challenges

### Challenge 4.1: Zero-Inflation Token
Design a token economy with zero inflation that still incentivizes all participants.

### Challenge 4.2: Reflexive Token
Create a token where price action directly affects token mechanics (rebase, fees, etc.)

### Challenge 4.3: Multi-Token System
Build an ecosystem with multiple interconnected tokens (governance, utility, rewards, etc.)

### Challenge 4.4: Token Sink Mechanisms
Design creative ways to remove tokens from circulation permanently.

## Assessment Preparation

Complete these to prepare for your TOK-1 assessment:

1. **Token Portfolio**: Design 3 different token economies for different use cases
2. **Economic Modeling**: Create spreadsheet models for token distribution and value
3. **Governance Framework**: Write complete governance documentation
4. **Audit Report**: Conduct economic audit of your token design
5. **Presentation**: Present your best token design as if to investors
6. **Code Portfolio**: Deploy 2+ tokenomics contracts to testnet

## Additional Resources

- [ERC-20 Standard](https://eips.ethereum.org/EIPS/eip-20)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Vitalik on Token Economics](https://vitalik.ca/)
- [Curve Finance Documentation](https://curve.readthedocs.io/)
- [Uniswap V2/V3 Docs](https://docs.uniswap.org/)
- [CoinGecko Token Research](https://www.coingecko.com/)

## Tips for Success

1. **Sustainability First**: Design for long-term sustainability, not quick pumps
2. **Align Incentives**: All stakeholders should benefit from protocol success
3. **Model Everything**: Use spreadsheets to model your economics
4. **Study Failures**: Learn from failed token projects
5. **Simple > Complex**: Start simple, add complexity only if needed
6. **Consider Game Theory**: Think about how rational actors will behave
7. **Avoid Ponzi Mechanics**: Ensure value creation, not just transfer
8. **Test Economics**: Simulate various market conditions
9. **Fair Distribution**: Avoid overly concentrated holdings
10. **Be Realistic**: Conservative estimates are better than optimistic ones

---

Tokenomics is as much art as science. Design thoughtfully and test thoroughly! 💰

---

**Exercise Author**: @jmenichole
