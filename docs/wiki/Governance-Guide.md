# VISE DAO Governance Guide

Complete guide to participating in VISE DAO governance, creating proposals, voting, and managing the treasury.

## 📋 Table of Contents

1. [Overview](#overview)
2. [Getting Started](#getting-started)
3. [VISE Token](#vise-token)
4. [Voting Power](#voting-power)
5. [Proposal Types](#proposal-types)
6. [Creating Proposals](#creating-proposals)
7. [Voting on Proposals](#voting-on-proposals)
8. [Timelock & Execution](#timelock--execution)
9. [Treasury Management](#treasury-management)
10. [Best Practices](#best-practices)

---

## Overview

VISE is governed by a decentralized autonomous organization (DAO) using the VISE governance token. Token holders can create and vote on proposals to manage the platform's development, treasury allocation, and strategic direction.

### Key Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| **Voting Delay** | 1 block | Time before voting starts |
| **Voting Period** | 50,400 blocks | ~1 week voting window |
| **Proposal Threshold** | 100 VISE | Min tokens to create proposal |
| **Quorum** | 4% | Min participation for validity |
| **Timelock Delay** | 1 day | Safety delay before execution |

### Governance Contracts

- **VISEGovernanceToken**: ERC-20 with voting power (0x...)
- **VISEGovernor**: Proposal and voting logic (0x...)
- **TimelockController**: 1-day delay for security (0x...)

---

## Getting Started

### 1. Acquire VISE Tokens

You can get VISE tokens through:

**Airdrop** (One-time):
```solidity
VISEGovernanceToken.claimAirdrop()
// Receive: 100 VISE tokens
```

**V-Pass Mint**:
- Automatically receive 100 VISE when minting V-Pass

**Curriculum Completion**:
- Earn 50 VISE per module completed

**Community Contributions**:
- Earn 25-100 VISE for contributions

**Educator Allocations**:
- Custom VISE amounts for educators

**Secondary Market**:
- Purchase from DEX (Uniswap, etc.)

### 2. Delegate Voting Power

**IMPORTANT**: You MUST delegate to participate in governance!

```solidity
// Delegate to yourself
VISEGovernanceToken.delegate(yourAddress)

// Or delegate to someone else
VISEGovernanceToken.delegate(delegateAddress)
```

**Using Etherscan**:
1. Go to VISE Token contract
2. Connect wallet
3. Call `delegate()` with your address
4. Confirm transaction

**Why Delegation is Required**:
- Voting power is tracked via delegation
- Even self-delegation is required
- Enables gas-efficient voting
- Allows trusted representatives

### 3. Verify Voting Power

```solidity
uint256 power = VISEGovernanceToken.getVotes(yourAddress)
```

You now have voting power equal to your VISE balance!

---

## VISE Token

### Token Distribution

| Allocation | Percentage | Amount | Vesting |
|------------|------------|--------|---------|
| V-Pass Holders | 40% | 400,000 VISE | Immediate |
| Treasury | 25% | 250,000 VISE | Locked |
| Educators | 15% | 150,000 VISE | 2 years |
| Core Team | 15% | 150,000 VISE | 2 years |
| Early Supporters | 5% | 50,000 VISE | 6 months |
| **Total** | **100%** | **1,000,000 VISE** | - |

### Earning VISE

**Active Participation**:
- Vote on proposals: Variable rewards
- Complete curriculum: 50 VISE/module
- Community contributions: 25-100 VISE
- Bug bounties: 100-1000 VISE
- Content creation: 50-500 VISE

**Passive Earning**:
- Hold V-Pass: 100 VISE initial
- Delegate votes: Potential rewards
- Provide liquidity: LP rewards (if implemented)

---

## Voting Power

### How Voting Power Works

Voting power = VISE tokens delegated to you

**Example 1** (Self-Delegation):
- You have: 1,000 VISE
- You delegate to: Yourself
- Your voting power: 1,000 votes

**Example 2** (Delegation to Others):
- You have: 500 VISE
- You delegate to: Alice
- Your voting power: 0 votes
- Alice's voting power: +500 votes

**Example 3** (Receiving Delegation):
- You have: 1,000 VISE (self-delegated)
- Bob delegates 500 VISE to you
- Alice delegates 300 VISE to you
- Your voting power: 1,800 votes

### Checking Voting Power

```solidity
// Check current voting power
uint256 power = governor.getVotes(address, blockNumber)

// Check if you can propose
uint256 threshold = governor.proposalThreshold() // 100 VISE
bool canPropose = power >= threshold
```

---

## Proposal Types

### 1. Treasury Allocation

**Purpose**: Allocate funds from DAO treasury

**Budget Categories**:
- Curriculum Development (40% of treasury)
- Educator Rewards (25% of treasury)
- Marketing & Growth (15% of treasury)
- Infrastructure (10% of treasury)
- Emergency Fund (10% of treasury)

**Example Proposal**:
```
Title: Fund Module 6: Advanced DeFi Development

Description:
Allocate $30,000 from treasury for developing Module 6 content
covering advanced DeFi protocols, including:
- AMM mechanics
- Lending protocols
- Yield farming strategies

Budget Breakdown:
- Content creation: $15,000
- Code examples: $8,000
- Video production: $5,000
- Testing & review: $2,000

Expected Completion: 3 months
```

**Requirements**:
- Quorum: 4%
- Approval: 60%
- Timelock: 1 day

### 2. Educator Compensation

**Purpose**: Reward educators for their work

**Compensation Structure**:
- Base monthly: $5,000 - $20,000
- Performance bonus: $1,000 - $5,000
- Achievement bonuses: $500 - $2,000

**Example Proposal**:
```
Title: Monthly Educator Compensation - December 2025

Description:
Monthly compensation for active educators

Educator Payouts:
- Alice (Lead): $15,000 (Module 2-3 instruction)
- Bob (Senior): $12,000 (Module 4-5 instruction)
- Charlie (Junior): $8,000 (Module 1 + support)

Performance Bonuses:
- Alice: $3,000 (95% student satisfaction)
- Bob: $2,000 (40 students graduated)

Total: $40,000
```

**Requirements**:
- Quorum: 4%
- Approval: 51%
- Timelock: 1 day

### 3. Platform Upgrades

**Purpose**: Approve technical improvements

**Examples**:
- Smart contract upgrades
- New features
- Infrastructure scaling
- Security improvements

**Example Proposal**:
```
Title: Implement Achievement NFT Marketplace

Description:
Develop secondary marketplace for Achievement NFTs

Features:
- P2P trading of achievement NFTs
- Royalty system (5% to treasury)
- Reputation tracking
- Integration with OpenSea

Budget: $15,000
Timeline: 2 months
```

**Requirements**:
- Quorum: 4%
- Approval: 60%
- Timelock: 1 day

### 4. Governance Changes

**Purpose**: Modify governance parameters

**Parameters That Can Be Changed**:
- Voting period duration
- Quorum percentage
- Proposal threshold
- Timelock delay

**Example Proposal**:
```
Title: Increase Quorum to 6%

Description:
Current 4% quorum is too low for major decisions.
Propose increasing to 6% for better representation.

Rationale:
- Higher participation threshold
- More legitimate decisions
- Still achievable with current voter base

Impact: More tokens needed for proposal validity
```

**Requirements**:
- Quorum: 10% (higher for governance changes)
- Approval: 75%
- Timelock: 3 days

### 5. Emergency Actions

**Purpose**: Handle urgent situations

**Examples**:
- Security vulnerabilities
- Smart contract pauses
- Critical bug fixes
- Exploit responses

**Example Proposal**:
```
Title: Emergency Pause - Security Vulnerability

Description:
Critical vulnerability discovered in V-Pass contract.
Immediate pause required while fix is deployed.

Action:
- Pause V-Pass minting
- Pause transfers (if necessary)
- Deploy fix within 48 hours
- Resume operations after audit

Urgency: CRITICAL
```

**Requirements**:
- Quorum: 10%
- Approval: 75%
- Timelock: Can be expedited by multisig

---

## Creating Proposals

### Prerequisites

1. Have ≥100 VISE voting power
2. Have delegated voting power
3. Understand proposal format

### Proposal Structure

Every proposal must have:

1. **Targets**: Contract addresses to call
2. **Values**: ETH amounts to send (usually 0)
3. **Calldatas**: Encoded function calls
4. **Description**: Human-readable explanation

### Step-by-Step Guide

#### 1. Prepare Proposal Data

```solidity
// Example: Transfer 10,000 USDC to educator

address[] memory targets = new address[](1);
targets[0] = USDC_ADDRESS;

uint256[] memory values = new uint256[](1);
values[0] = 0; // No ETH being sent

bytes[] memory calldatas = new bytes[](1);
calldatas[0] = abi.encodeWithSignature(
    "transfer(address,uint256)",
    EDUCATOR_ADDRESS,
    10000 * 10**6 // 10,000 USDC (6 decimals)
);

string memory description = "December Educator Compensation - Alice";
```

#### 2. Submit Proposal

```solidity
uint256 proposalId = governor.propose(
    targets,
    values,
    calldatas,
    description
);
```

#### 3. Share Proposal

Once created, share the proposal ID with the community:

- Post on Discord/Forum
- Explain rationale
- Answer questions
- Rally support

### Proposal Template

```markdown
# Proposal: [Title]

## Summary
[1-2 sentence overview]

## Motivation
[Why is this needed?]

## Specification
[What exactly will happen?]

## Budget
[If applicable, detailed breakdown]

## Timeline
[Expected completion date]

## Success Metrics
[How to measure success]

## Risks
[Potential downsides]

## Alternatives Considered
[Other options evaluated]
```

### Best Proposal Practices

✅ **DO**:
- Be specific and detailed
- Include budget breakdown
- Set clear timelines
- Explain rationale clearly
- Engage with community first
- Respond to questions

❌ **DON'T**:
- Rush proposals
- Skip community discussion
- Hide important details
- Make unrealistic promises
- Ignore feedback

---

## Voting on Proposals

### Voting Options

1. **For** (1): Support the proposal
2. **Against** (0): Oppose the proposal
3. **Abstain** (2): Counted for quorum but neutral

### How to Vote

#### Option 1: Direct Vote

```solidity
// Vote FOR
governor.castVote(proposalId, 1)

// Vote AGAINST
governor.castVote(proposalId, 0)

// ABSTAIN
governor.castVote(proposalId, 2)
```

#### Option 2: Vote with Reason

```solidity
governor.castVoteWithReason(
    proposalId,
    1, // FOR
    "I support this proposal because..."
)
```

#### Option 3: Vote by Signature (Gasless)

```solidity
// Sign vote off-chain, someone else submits
governor.castVoteBySig(
    proposalId,
    support,
    v, r, s // Signature components
)
```

### Voting Timeline

```
Proposal Created
    ↓
Voting Delay (1 block)
    ↓
Voting Period Starts (50,400 blocks / ~1 week)
    ↓  [Users vote here]
Voting Period Ends
    ↓
Proposal Queued (if passed)
    ↓
Timelock Delay (1 day)
    ↓
Proposal Executable
    ↓
Anyone can execute
    ↓
Proposal Executed
```

### Proposal States

| State | Description |
|-------|-------------|
| **Pending** | Waiting for voting delay |
| **Active** | Currently accepting votes |
| **Canceled** | Proposal was canceled |
| **Defeated** | Did not meet quorum or approval |
| **Succeeded** | Passed, ready to queue |
| **Queued** | In timelock delay |
| **Expired** | Timelock expired, not executed |
| **Executed** | Successfully executed |

---

## Timelock & Execution

### Purpose of Timelock

The 1-day timelock delay provides:

1. **Security**: Time to identify malicious proposals
2. **Transparency**: Community can see what will execute
3. **Exit Option**: Users can withdraw if they disagree
4. **Error Correction**: Cancel if mistakes found

### Queueing Proposals

After a proposal succeeds:

```solidity
governor.queue(
    targets,
    values,
    calldatas,
    descriptionHash
)
```

This starts the 1-day timelock countdown.

### Executing Proposals

After timelock delay expires:

```solidity
governor.execute(
    targets,
    values,
    calldatas,
    descriptionHash
)
```

**Anyone** can execute! Promotes decentralization.

### Canceling Proposals

Before execution, proposals can be canceled by:

1. **Proposer** (if voting power dropped below threshold)
2. **Guardian** (emergency multisig, if implemented)

```solidity
governor.cancel(
    targets,
    values,
    calldatas,
    descriptionHash
)
```

---

## Treasury Management

### Treasury Overview

The DAO treasury receives:
- 80% of V-Pass sales (~$1.5M potential)
- Secondary market royalties (if implemented)
- Partnership revenue
- Grant funds

### Treasury Allocation Strategy

**Short-term** (0-6 months):
- 40% Curriculum development
- 25% Educator compensation
- 15% Marketing & growth
- 10% Infrastructure
- 10% Emergency reserve

**Long-term** (6-24 months):
- 30% Curriculum expansion
- 25% Educator compensation
- 20% Platform development
- 15% Community incentives
- 10% Emergency reserve

### Treasury Diversification

**Proposed Asset Mix**:
- 40% Stablecoins (USDC, DAI) - Operational expenses
- 30% ETH - Long-term holding
- 20% Blue-chip DeFi (AAVE, UNI) - Yield generation
- 10% Treasury bills (via Ondo, etc.) - Stable yield

### Spending Guidelines

**Under $10,000**:
- Fast-track voting (3 days)
- 51% approval threshold
- 4% quorum

**$10,000 - $50,000**:
- Standard voting (7 days)
- 60% approval threshold
- 4% quorum

**Over $50,000**:
- Extended voting (14 days)
- 75% approval threshold
- 10% quorum
- Additional review period

---

## Best Practices

### For Proposers

1. **Discuss First**: Share idea in Discord/Forum before formal proposal
2. **Be Specific**: Clear targets, values, calldatas
3. **Show Work**: Detailed budget, timeline, milestones
4. **Engage Community**: Answer questions, address concerns
5. **Set Realistic Goals**: Don't overpromise
6. **Follow Up**: Report on execution progress

### For Voters

1. **Do Research**: Read full proposal and discussion
2. **Ask Questions**: Seek clarification if unclear
3. **Vote Thoughtfully**: Consider long-term impact
4. **Delegate Wisely**: Choose informed representatives
5. **Stay Engaged**: Monitor execution
6. **Hold Accountable**: Verify promises kept

### For the DAO

1. **Transparency**: All decisions public and documented
2. **Accountability**: Track proposal outcomes
3. **Iteration**: Learn from successes and failures
4. **Inclusion**: Encourage diverse participation
5. **Security**: Maintain strong operational security
6. **Long-term Thinking**: Balance short and long-term goals

---

## Emergency Procedures

### Security Incident

1. **Pause Contracts** (if possible via governance)
2. **Emergency Proposal** (expedited voting if needed)
3. **Communication** (notify community immediately)
4. **Fix Deployment** (with professional audit)
5. **Post-Mortem** (transparency report)

### Governance Attack

If malicious proposal passes:

1. **Community Alert** (Discord, Twitter)
2. **Cancel Proposal** (during timelock)
3. **Guardian Intervention** (if implemented)
4. **Governance Update** (prevent future attacks)

### Treasury Theft

1. **Immediate Pause** (stop all treasury transactions)
2. **Forensic Analysis** (track stolen funds)
3. **Recovery Efforts** (legal, whitehat, etc.)
4. **Insurance Claim** (if covered)
5. **Community Vote** (on recovery approach)

---

## Governance Roadmap

### Phase 1: Launch (Months 1-3)
- ✅ Deploy governance contracts
- ✅ Distribute VISE tokens
- ✅ First proposals & votes
- ⏳ Establish voting patterns

### Phase 2: Growth (Months 4-6)
- Increase participation (target: 20% active voters)
- Refine proposal templates
- Establish working groups
- Regular community calls

### Phase 3: Maturity (Months 7-12)
- Advanced governance features
- Optimistic governance (faster execution)
- Specialized committees
- Cross-DAO collaboration

### Phase 4: Decentralization (Year 2+)
- Progressive decentralization
- Renounce admin roles
- Full community control
- Autonomous operation

---

## Resources

### Tools

- **Tally**: https://tally.xyz - Governance dashboard
- **Snapshot**: https://snapshot.org - Off-chain voting
- **DeepDAO**: Analytics and tracking
- **Boardroom**: Governance aggregator

### Documentation

- [OpenZeppelin Governor](https://docs.openzeppelin.com/contracts/governance)
- [Compound Governance](https://compound.finance/docs/governance)
- [VISE GitHub](https://github.com/Fused-Gaming/vise)

### Community

- **Discord**: #governance channel
- **Forum**: discuss.vln.gg
- **Twitter**: @VISEedu
- **GitHub**: Proposal discussions

---

## FAQ

**Q: How much VISE do I need to vote?**
A: Any amount! But you need 100 VISE to create proposals.

**Q: Can I change my vote?**
A: No, votes are final. Think carefully before voting.

**Q: What happens if quorum isn't reached?**
A: Proposal is defeated, even if approval % is high.

**Q: How long does the whole process take?**
A: ~8-9 days (1 week voting + 1 day timelock + execution)

**Q: Can I vote on multiple proposals?**
A: Yes! Your voting power applies to all active proposals.

**Q: What if I disagree with a passing proposal?**
A: You have 1 day (timelock) to exit or voice concerns.

**Q: Who can execute proposals?**
A: Anyone! It's permissionless after timelock.

**Q: Can proposals be edited after submission?**
A: No. Cancel and resubmit if needed.

---

**Last Updated**: 2025-11-23
**Governance Version**: 1.0
**Smart Contracts**: See [Smart Contracts](Smart-Contracts.md)
