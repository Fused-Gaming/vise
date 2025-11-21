# VISE Governance Framework

## Table of Contents
1. [Overview](#overview)
2. [Roles & Permissions](#roles--permissions)
3. [Token Utility in Governance](#token-utility-in-governance)
4. [Decision Making Process](#decision-making-process)
5. [Proposal Types](#proposal-types)
6. [Voting Mechanisms](#voting-mechanisms)
7. [Escalation & Dispute Resolution](#escalation--dispute-resolution)
8. [Treasury Management](#treasury-management)
9. [Governance Evolution](#governance-evolution)

---

## Overview

VISE (Verified in Skills: Exploits) operates as a progressive decentralized autonomous organization (DAO) where governance rights are earned through demonstrated competence. The governance system is designed to:

- Align decision-making power with expertise and contribution
- Create transparent, fair processes for all stakeholders
- Enable community-driven evolution of the platform
- Protect against malicious governance attacks
- Reward active participation and value creation

### Governance Principles

1. **Meritocracy**: Influence is earned through learning and contribution
2. **Transparency**: All decisions are public and verifiable on-chain
3. **Inclusivity**: All token holders can participate
4. **Progressive Decentralization**: Governance power increases with progression
5. **Security**: Multi-signature and timelock protections for critical changes

---

## Roles & Permissions

### 1. Student / Learner
**Token Requirement**: None (starting role)

**Permissions**:
- Access public course materials
- Participate in community discussions
- Submit improvement suggestions
- View governance proposals

**Governance Rights**:
- None (observation only)

**Path to Advancement**:
- Complete Module 1 to become Builder

---

### 2. Builder / Contributor
**Token Requirement**: Any module token (PE-1, SOL-1, NFT-1, TOK-1, PRIV-1, or DEV-1)

**Permissions**:
- All Student permissions
- Access to module-specific resources
- Participation in study groups
- Submit proposals (with limitations)
- Vote on minor proposals

**Governance Rights**:
- **Voting Weight**: 1 vote per module token held (max 6 for all modules)
- **Proposal Creation**: Can propose:
  - Content improvements
  - Community events
  - Small grants (<$500)
- **Voting Access**:
  - Community proposals
  - Resource allocation (minor)
  - Content updates

**Path to Advancement**:
- Complete any Sprint to become Advanced Builder
- Earn 3+ module tokens for enhanced voting weight

---

### 3. Mentor / Reviewer
**Token Requirement**: PRIV-1 (Security) or DEV-1 (DevOps) or 4+ module tokens

**Permissions**:
- All Builder permissions
- Review and grade student submissions
- Provide code review feedback
- Host office hours
- Access to mentor resources
- Early access to new content

**Governance Rights**:
- **Voting Weight**: 10 votes (base) + 2 per module token
- **Proposal Creation**: Can propose:
  - Curriculum changes
  - Grading criteria updates
  - Mentor compensation changes
  - Medium grants ($500-$2,500)
- **Veto Power**: Can flag proposals for admin review (not binding)

**Responsibilities**:
- Review minimum 5 submissions per month
- Attend bi-weekly mentor meetings
- Maintain response time <48 hours
- Follow review rubrics consistently

**Compensation**:
- Paid in VISE tokens per review completed
- Bonus for quality metrics (student satisfaction)
- Access to mentor-only grant pool

---

### 4. Master / Expert
**Token Requirement**: MASTER Certificate (SPR-1 + SPR-2 + SPR-3)

**Permissions**:
- All Mentor permissions
- Teach advanced workshops
- Create new course modules
- Lead governance initiatives
- Access to expert network
- Partnership opportunities

**Governance Rights**:
- **Voting Weight**: 25 votes (base) + 5 per additional achievement
- **Proposal Creation**: Can propose:
  - Major curriculum overhauls
  - Tokenomics changes
  - Partnership agreements
  - Large grants ($2,500-$10,000)
  - Governance rule changes
- **Fast Track**: Proposals can go to vote in 3 days (vs 7 for others)

**Responsibilities**:
- Contribute to platform strategy
- Mentor other mentors
- Represent VISE in community
- Quality assurance for content

**Compensation**:
- Revenue share from platform fees
- Grant funding for projects
- Partnership revenue share
- Equity in VISE (if applicable)

---

### 5. Admin / Core Team
**Token Requirement**: Appointed by governance or founding team

**Permissions**:
- All Master permissions
- Access to platform infrastructure
- Smart contract deployment
- Treasury management
- Legal and compliance decisions

**Governance Rights**:
- **Voting Weight**: 50 votes per admin
- **Proposal Creation**: Any proposal type
- **Veto Power**: Can veto proposals that:
  - Violate legal requirements
  - Compromise platform security
  - Exceed treasury reserves
  - Conflict with existing agreements
  (Veto must be justified publicly)
- **Emergency Actions**: Can pause contracts in emergencies

**Responsibilities**:
- Platform maintenance and security
- Legal compliance
- Financial management
- Strategic planning
- Community moderation

**Accountability**:
- Subject to governance removal (requires 75% vote)
- Quarterly reporting to community
- Transparent expense reporting
- Code of conduct adherence

---

## Token Utility in Governance

### Token-Based Voting Power

Each VISE token represents achievement and grants governance power:

| Token | Voting Weight | Special Rights |
|-------|---------------|----------------|
| PE-1 | 1 vote | None |
| SOL-1 | 1 vote | Can review Solidity code |
| NFT-1 | 1 vote | Can review NFT projects |
| TOK-1 | 1 vote | Can propose tokenomics changes |
| PRIV-1 | 2 votes | Can conduct security audits |
| DEV-1 | 2 votes | Can manage infrastructure |
| SPR-1 | 3 votes | Builder community access |
| SPR-2 | 5 votes | Advanced project grants |
| MASTER | 10 votes | Maximum governance rights |

### Vote Multipliers

Earn multipliers through:

**Active Participation Multiplier** (max 1.5x):
- Vote on >80% of proposals in last 90 days: 1.2x
- Create successful proposals: 1.1x
- Mentor with >4.5/5 rating: 1.2x
- Stack for combined: up to 1.5x total

**Staking Multiplier** (max 2x):
- Stake tokens for 30 days: 1.2x
- Stake tokens for 90 days: 1.5x
- Stake tokens for 180 days: 2x

**Contribution Multiplier** (max 2x):
- Code contributions merged: 1.3x
- Content creation: 1.2x
- Community moderation: 1.2x
- Bug bounties: 1.5x

**Maximum Total Voting Power**: Base votes × (1 + all multipliers)

Example:
- MASTER holder (25 votes)
- Active participant (1.5x)
- 90-day stake (1.5x)
- Code contributor (1.3x)
- **Total: 25 × 1.5 × 1.5 × 1.3 = 73.125 votes** (rounded to 73)

### Token Gating

Certain platform features require token holdings:

| Feature | Requirement |
|---------|-------------|
| Advanced courses | Prerequisite module tokens |
| Code review role | PRIV-1 or 4+ module tokens |
| Grant applications | SPR-1 or higher |
| Governance proposals | Any module token |
| Mentor role | PRIV-1 or DEV-1 or 4+ tokens |
| Advisory board | MASTER certificate |
| Revenue share | MASTER certificate + staking |

---

## Decision Making Process

### 1. Proposal Creation

Anyone with a module token can create proposals:

**Proposal Requirements**:
- Title (max 100 characters)
- Summary (max 500 characters)
- Detailed description
- Rationale and benefits
- Implementation plan
- Budget (if requesting funds)
- Success metrics
- Risk assessment

**Proposal Bond**:
- Small proposals (<$500): No bond
- Medium proposals ($500-$2,500): 100 VISE tokens
- Large proposals (>$2,500): 500 VISE tokens
- Governance changes: 1,000 VISE tokens

Bond is returned if proposal passes or receives >20% yes votes.

### 2. Discussion Period

**Duration**: 3-7 days depending on proposal type

During discussion:
- Community asks questions
- Author addresses concerns
- Amendments can be proposed
- Impact analysis shared
- Experts weigh in

**Required for Progress**:
- Author must engage (respond within 24 hours)
- Minimum 10 community comments
- No critical blockers identified

### 3. Voting Period

**Duration**: 3-7 days depending on proposal type

| Proposal Type | Discussion | Voting | Quorum | Pass Threshold |
|---------------|------------|--------|--------|----------------|
| Minor (content, events) | 3 days | 3 days | 5% | 51% |
| Medium (grants, features) | 5 days | 5 days | 10% | 60% |
| Major (curriculum, partnerships) | 7 days | 7 days | 20% | 66% |
| Critical (governance, tokenomics) | 7 days | 7 days | 30% | 75% |

**Voting Options**:
- **Yes**: Support the proposal
- **No**: Oppose the proposal
- **Abstain**: Counted for quorum, not for/against

**Vote Delegation**:
- Users can delegate voting power to others
- Delegates can vote on behalf of delegators
- Delegation can be revoked any time
- Partial delegation allowed (delegate 50% of votes)

### 4. Execution

**Timelock Period**:
- Minor proposals: Immediate execution
- Medium proposals: 24-hour timelock
- Major proposals: 48-hour timelock
- Critical proposals: 72-hour timelock

**Execution Process**:
1. Proposal passes and timelock expires
2. Smart contract execution or manual implementation
3. Verification of correct execution
4. Notification to community
5. Post-implementation monitoring

**Emergency Override**:
- Admins can delay execution if issues discovered
- Requires public justification
- Governance can vote to proceed anyway (75% threshold)

---

## Proposal Types

### Type 1: Content & Curriculum

**Examples**:
- Add new exercise to module
- Update outdated content
- Fix errors in curriculum
- Add new learning resources

**Requirements**:
- Clearly identify what changes
- Provide updated content
- Explain benefit to students
- No budget impact

**Approval Process**: Minor (51% threshold)

---

### Type 2: Community & Events

**Examples**:
- Host hackathon
- Community meetup
- Workshop series
- Partnership announcement

**Requirements**:
- Event plan and budget
- Expected participation
- Success metrics
- Sponsorship details (if applicable)

**Approval Process**: Minor to Medium (51-60% threshold)

---

### Type 3: Grants & Funding

**Small Grants** (<$500):
- Individual learning support
- Tool purchases
- Conference tickets
- Course material

**Medium Grants** ($500-$2,500):
- Project development
- Content creation
- Community initiatives
- Research projects

**Large Grants** ($2,500-$10,000):
- Major platform features
- Comprehensive courses
- Partnership integrations
- Infrastructure upgrades

**Requirements**:
- Detailed budget breakdown
- Milestone-based delivery
- Progress reporting
- Success metrics
- Refund policy if milestones missed

**Approval Process**: Medium to Major (60-66% threshold)

---

### Type 4: Platform Features

**Examples**:
- New module additions
- Platform UI/UX changes
- Integration with external services
- Tool development

**Requirements**:
- Technical specification
- Implementation plan
- Resource requirements
- Timeline
- Testing plan
- Rollback plan

**Approval Process**: Major (66% threshold)

---

### Type 5: Governance Changes

**Examples**:
- Modify voting thresholds
- Change role requirements
- Update proposal process
- Treasury management rules
- Token economics adjustments

**Requirements**:
- Current state analysis
- Proposed changes
- Impact assessment
- Community benefit
- Risk mitigation
- Legal review (if needed)

**Approval Process**: Critical (75% threshold)

---

### Type 6: Tokenomics

**Examples**:
- Modify token distribution
- Change staking rewards
- Adjust voting multipliers
- Emission schedule changes
- Burn mechanisms

**Requirements**:
- Economic modeling
- Long-term impact analysis
- Stakeholder impact
- Legal compliance check
- Security audit (for smart contract changes)

**Approval Process**: Critical (75% threshold)

---

## Voting Mechanisms

### On-Chain Voting

All major decisions are recorded on-chain:

**Smart Contract Functions**:
```solidity
createProposal(title, description, actions)
vote(proposalId, support)
delegate(delegatee)
executeProposal(proposalId)
cancelProposal(proposalId)
```

**Vote Recording**:
- All votes are transparent and verifiable
- Vote history is immutable
- Voting power snapshot at proposal creation
- No vote changes after submission

### Off-Chain Voting (Snapshot)

For non-binding votes and polls:

**Use Cases**:
- Temperature checks
- Community sentiment
- Informal polls
- Priority ranking

**Benefits**:
- Gas-free voting
- Faster iterations
- Lower barrier to participation

---

## Escalation & Dispute Resolution

### Level 1: Community Resolution

**Process**:
1. Issue raised in Discord/forum
2. Community discussion (3 days)
3. Attempted resolution through consensus
4. Document outcome

**Success Rate**: ~70% of disputes

---

### Level 2: Mentor Review

**When**:
- Community cannot reach consensus
- Technical disputes
- Grading appeals
- Code review disagreements

**Process**:
1. Escalation request submitted
2. Mentor panel assigned (3 mentors)
3. Review evidence (5 days)
4. Panel decision (majority vote)
5. Written explanation

**Success Rate**: ~90% of escalated disputes

---

### Level 3: Admin Decision

**When**:
- Mentor panel split decision
- Legal implications
- Platform security concerns
- Emergency situations

**Process**:
1. Admin review (3 days)
2. Consult legal/security if needed
3. Admin panel decision (majority of admins)
4. Public explanation required
5. Governance can override (75% vote)

**Success Rate**: >95% final resolution

---

### Level 4: Governance Vote

**When**:
- Community challenges admin decision
- Constitutional issues
- Major policy disputes

**Process**:
1. Proposal created for dispute
2. Extended discussion (14 days)
3. Community vote
4. 75% threshold for override
5. Binding resolution

**Success Rate**: 100% final

---

### Appeal Process

Anyone can appeal decisions:

**Appeal Requirements**:
- Written appeal with new evidence
- Explanation of why original decision was wrong
- Proposal for resolution
- Bond (returned if appeal successful)

**Appeal Timelines**:
- Must be filed within 30 days of decision
- Review within 14 days
- Decision final after appeal or 30 days

---

## Treasury Management

### Treasury Structure

**Multi-Signature Wallet**:
- 5 signers (3 admins + 2 community-elected)
- 3-of-5 threshold for execution
- Timelock on large transactions (>$10k)

**Treasury Allocation**:
- Platform Development (40%)
- Grants & Bounties (30%)
- Operations & Salaries (20%)
- Reserve Fund (10%)

### Budget Approval

**Quarterly Budgets**:
- Proposed by admins
- Community review (14 days)
- Governance vote (60% threshold)
- Monthly spending reports

**Emergency Spending**:
- Up to 5% of treasury
- Requires 4-of-5 multisig
- Public justification within 48 hours
- Governance can claw back if unjustified

### Revenue Sources

1. **Course Fees** (if applicable)
2. **Grant Matching** (partnerships)
3. **Platform Services** (premium features)
4. **Consulting & Audits**
5. **Token Appreciation** (treasury holdings)

### Revenue Distribution

- 40%: Reinvest in platform
- 30%: Community grants
- 20%: Mentor/contributor rewards
- 10%: MASTER holder revenue share

---

## Governance Evolution

### Roadmap to Full Decentralization

**Phase 1: Guided Governance** (Months 1-6)
- Admin-led with community input
- Building governance infrastructure
- Establishing processes
- Training community governors

**Phase 2: Hybrid Governance** (Months 7-12)
- Community proposals enabled
- Shared decision-making
- Admin veto limited to security/legal
- Mentor council formed

**Phase 3: Community Governance** (Months 13-18)
- Community-led decisions
- Admin role reduced to operations
- Elected community council
- Full transparency

**Phase 4: Full DAO** (Months 19+)
- Fully on-chain governance
- Smart contract-based execution
- Minimal admin intervention
- Autonomous treasury management

### Constitutional Amendments

The governance framework can be amended:

**Requirements**:
- Proposal from MASTER holder or admin
- 30-day discussion period
- Community impact analysis
- Legal review
- 75% governance vote
- 30% minimum quorum
- 14-day implementation delay

**Protected Principles**:
These cannot be changed without 90% vote:
- Merit-based governance
- Transparency requirements
- Appeal rights
- Treasury protections

---

## Governance Participation Incentives

### Voting Rewards

**Active Voter Rewards**:
- Vote on >50% of proposals: Badge + voting multiplier
- Vote on >80% of proposals: VISE tokens (quarterly distribution)
- Vote on 100% of proposals: Bonus rewards + recognition

### Proposal Rewards

**Successful Proposals**:
- Proposal passes and is implemented: VISE tokens + reputation
- High-impact proposals: Additional bonus
- Featured in governance showcase

### Engagement Rewards

**Discussion Participation**:
- Thoughtful comments: Reputation points
- Top contributors: Monthly recognition
- Constructive feedback: Community badges

---

## Code of Conduct

All governance participants must:

1. **Act in Good Faith**: Genuine intent to benefit the community
2. **Be Respectful**: Disagree without being disagreeable
3. **Stay Informed**: Understand proposals before voting
4. **Be Transparent**: Disclose conflicts of interest
5. **Follow Rules**: Adhere to governance processes
6. **Be Accountable**: Stand by your votes and proposals

**Violations**:
- Warning for first offense
- Temporary voting suspension for repeated offenses
- Permanent ban for severe violations (scamming, manipulation)
- Appeals process available

---

## Governance Analytics

Track governance health:

**Key Metrics**:
- Voter participation rate
- Proposal success rate
- Average discussion quality
- Dispute resolution time
- Treasury transparency
- Community satisfaction

**Quarterly Reports**:
- Governance activity summary
- Financial statements
- Community growth
- Challenges and solutions
- Future priorities

---

This governance framework is designed to grow with the VISE community. It will be reviewed quarterly and updated based on community needs and learnings.

**Let's build a fair, transparent, and effective governance system together!**
