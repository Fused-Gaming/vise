# V-Pass Guide

Complete guide to the V-Pass NFT - your key to accessing the VISE curriculum.

## Table of Contents

1. [What is V-Pass?](#what-is-v-pass)
2. [Rarity Tiers](#rarity-tiers)
3. [Pricing](#pricing)
4. [How to Mint](#how-to-mint)
5. [Access Levels](#access-levels)
6. [Benefits by Rarity](#benefits-by-rarity)
7. [Trading & Secondary Market](#trading--secondary-market)
8. [Token-Gating](#token-gating)
9. [Governance Rights](#governance-rights)
10. [FAQs](#faqs)

---

## What is V-Pass?

The V-Pass is an ERC-721 NFT that grants access to the VISE educational platform. Unlike traditional achievement NFTs, V-Passes are:

- ✅ **Transferable**: Can be bought, sold, and traded
- ✅ **Rarity-Based**: 4 tiers with different benefits
- ✅ **Access Control**: Token-gates curriculum modules
- ✅ **Governance Enabled**: Comes with VISE tokens
- ✅ **Revenue Generating**: 80% of sales go to DAO treasury

**Contract Address**: `0x...` (see [Smart Contracts](Smart-Contracts.md))

**Total Supply**: 10,000 V-Passes

---

## Rarity Tiers

V-Passes come in four rarity tiers, each offering different levels of access and benefits.

### Overview Table

| Rarity | Supply | % | Price | Module Access | Lifetime | Bonus Perks |
|--------|--------|---|-------|---------------|----------|-------------|
| **COMMON** | 6,000 | 60% | 0.05 ETH | 1-3 | ❌ | 0% |
| **RARE** | 2,500 | 25% | 0.10 ETH | 1-4 | ❌ | 10% |
| **EPIC** | 1,200 | 12% | 0.20 ETH | 1-5 (All) | ✅ | 25% |
| **LEGENDARY** | 300 | 3% | 0.50 ETH | 1-5 (All) | ✅ | 50% |

### Common (60%)

**Price**: 0.05 ETH (~$100)
**Supply**: 6,000
**Access**: Modules 1-3

**What You Get**:
- Introduction to Blockchain (Module 1)
- Solidity Fundamentals (Module 2)
- NFTs & Token Standards (Module 3)
- 100 VISE governance tokens
- Community Discord access
- Progress tracking NFT

**Best For**:
- Beginners exploring blockchain
- Students on a budget
- Those trying out the platform
- Basic education needs

### Rare (25%)

**Price**: 0.10 ETH (~$200)
**Supply**: 2,500
**Access**: Modules 1-4

**What You Get**:
- All Common benefits
- DAOs & Governance (Module 4)
- 100 VISE governance tokens
- 10% bonus on achievement rewards
- Priority support
- Rare badge in community

**Best For**:
- Serious learners
- Future DAO participants
- Those wanting more than basics
- Community builders

### Epic (12%)

**Price**: 0.20 ETH (~$400)
**Supply**: 1,200
**Access**: All Modules (1-5)

**What You Get**:
- All Rare benefits
- Smart Contract Security (Module 5)
- **Lifetime access** to all future modules
- 25% bonus on achievement rewards
- Monthly Q&A with educators
- Exclusive mentorship opportunities
- Epic badge + special role
- Priority job board access

**Best For**:
- Professional developers
- Career-focused students
- Long-term learners
- Security-conscious builders

### Legendary (3%)

**Price**: 0.50 ETH (~$1,000)
**Supply**: 300 (VERY LIMITED)
**Access**: All Modules + Premium

**What You Get**:
- All Epic benefits
- **1-on-1 sessions** with educators (2 hours/month)
- **Lifetime access** with all future updates
- 50% bonus on achievement rewards
- Direct access to core team
- Co-creation opportunities
- Legendary badge + exclusive role
- First access to new features
- Permanent name in Hall of Fame
- Potential revenue sharing (future)

**Best For**:
- Serious professionals
- Entrepreneurs
- Those wanting personalized guidance
- VIP learners
- Long-term platform supporters

---

## Pricing

### Current Prices (ETH)

- COMMON: 0.05 ETH
- RARE: 0.10 ETH
- EPIC: 0.20 ETH
- LEGENDARY: 0.50 ETH

### Price in USD (at $2,000/ETH)

- COMMON: ~$100
- RARE: ~$200
- EPIC: ~$400
- LEGENDARY: ~$1,000

**Note**: Prices are in ETH, so USD value fluctuates with ETH price.

### Why These Prices?

**Common** ($100):
- Competitive with online course platforms
- Accessible entry point
- Covers basic operational costs

**Rare** ($200):
- 2x value with Module 4 (Governance)
- Unlocks bonus perks
- Similar to premium courses

**Epic** ($400):
- Full curriculum access
- Lifetime updates
- Comparable to coding bootcamp deposit
- Best value per module

**Legendary** ($1,000):
- Includes 1-on-1 mentorship
- $500/hour educator value
- VIP experience
- Limited supply creates scarcity

### Value Comparison

| Platform | Price | Access | Support |
|----------|-------|--------|---------|
| Udemy Course | $50-200 | 1 course | None |
| Coursera | $39-79/mo | Limited | Forums |
| Bootcamp | $3,000-15,000 | Fixed | Group |
| **V-Pass Common** | **$100** | **3 modules** | **Community** |
| **V-Pass Epic** | **$400** | **All+Lifetime** | **Mentorship** |

---

## How to Mint

### Prerequisites

1. **Wallet**: MetaMask, Rainbow, or any Web3 wallet
2. **ETH**: Enough to cover mint price + gas
3. **Network**: Ethereum mainnet (or testnet for testing)

### Minting Steps

#### Option 1: Website (Recommended)

1. Go to [edu.vln.gg/mint](https://edu.vln.gg/mint)
2. Connect your wallet
3. Select rarity tier
4. Click "Mint V-Pass"
5. Approve transaction in wallet
6. Wait for confirmation
7. V-Pass appears in your wallet!

#### Option 2: Smart Contract (Direct)

```solidity
// Interact with VISECurriculumPass contract

// Mint Common
vpass.mint{value: 0.05 ether}(Rarity.COMMON)

// Mint Rare
vpass.mint{value: 0.1 ether}(Rarity.RARE)

// Mint Epic
vpass.mint{value: 0.2 ether}(Rarity.EPIC)

// Mint Legendary
vpass.mint{value: 0.5 ether}(Rarity.LEGENDARY)
```

#### Option 3: Governance Grant

If you received a governance grant:

1. Wait for governance approval
2. Your address will be whitelisted
3. Mint for free during grant window
4. No payment required

### Gas Costs

Typical gas cost: 100,000 - 150,000 gas

At 50 gwei and $2,000 ETH:
- Gas cost: ~$10-15

**Tips to Save Gas**:
- Mint during off-peak hours (weekends)
- Use gas tracker websites
- Set lower gas price (if not urgent)

### After Minting

Once you mint:

1. ✅ V-Pass NFT in your wallet
2. ✅ 100 VISE tokens airdropped
3. ✅ Access to contracted modules
4. ✅ Discord role assigned (if connected)
5. ✅ Progress NFT minted automatically

---

## Access Levels

### Module Access by Rarity

```
Module 1 (Intro)        → All tiers ✅
Module 2 (Solidity)     → All tiers ✅
Module 3 (NFTs)         → All tiers ✅
Module 4 (Governance)   → Rare+ ⭐
Module 5 (Security)     → Epic+ 🌟
```

### Checking Your Access

**On Platform**:
- Dashboard shows unlocked modules
- Locked modules display upgrade prompt

**Via Smart Contract**:
```solidity
// Check if you can access Module 4
bool hasAccess = vpass.hasModuleAccess(yourAddress, 4)

// Get your highest access level
uint256 level = vpass.getUserAccessLevel(yourAddress)
// Returns: 3 (Common), 4 (Rare), or 5 (Epic/Legendary)
```

### Lifetime Access

**Epic & Legendary** holders get lifetime access:

- All current modules
- All future modules (no additional cost)
- Platform updates
- New features
- Content expansions

**Common & Rare** holders:
- Access to minted modules only
- Must upgrade for future content
- Or purchase new V-Pass

---

## Benefits by Rarity

### Learning Benefits

| Benefit | Common | Rare | Epic | Legendary |
|---------|--------|------|------|-----------|
| Module 1-3 | ✅ | ✅ | ✅ | ✅ |
| Module 4 | ❌ | ✅ | ✅ | ✅ |
| Module 5 | ❌ | ❌ | ✅ | ✅ |
| Future Modules | ❌ | ❌ | ✅ | ✅ |
| Code Examples | ✅ | ✅ | ✅ | ✅ |
| Video Content | ✅ | ✅ | ✅ | ✅ |
| Quizzes | ✅ | ✅ | ✅ | ✅ |
| Projects | ✅ | ✅ | ✅ | ✅ |

### Support Benefits

| Benefit | Common | Rare | Epic | Legendary |
|---------|--------|------|------|-----------|
| Community Discord | ✅ | ✅ | ✅ | ✅ |
| Discussion Forums | ✅ | ✅ | ✅ | ✅ |
| Priority Support | ❌ | ✅ | ✅ | ✅ |
| Monthly Q&A | ❌ | ❌ | ✅ | ✅ |
| 1-on-1 Sessions | ❌ | ❌ | ❌ | ✅ (2h/mo) |
| Direct Team Access | ❌ | ❌ | ❌ | ✅ |

### Reward Benefits

| Benefit | Common | Rare | Epic | Legendary |
|---------|--------|------|------|-----------|
| Base VISE Airdrop | 100 | 100 | 100 | 100 |
| Completion Rewards | 50/module | 55/module | 62.5/module | 75/module |
| Achievement Bonuses | 0% | +10% | +25% | +50% |
| Special Badges | ✅ | ✅ | ✅ | ✅ |
| Hall of Fame | ❌ | ❌ | ❌ | ✅ |

### Community Benefits

| Benefit | Common | Rare | Epic | Legendary |
|---------|--------|------|------|-----------|
| Discord Access | ✅ | ✅ | ✅ | ✅ |
| Special Role | Common | Rare ⭐ | Epic 🌟 | Legend 👑 |
| Voting Power | 100 VISE | 100 VISE | 100 VISE | 100 VISE |
| Exclusive Channels | ❌ | ❌ | ✅ | ✅ |
| Core Team Chat | ❌ | ❌ | ❌ | ✅ |

---

## Trading & Secondary Market

### V-Passes Are Transferable!

Unlike achievement NFTs, V-Passes can be:

- ✅ Sold
- ✅ Traded
- ✅ Gifted
- ✅ Transferred

### Where to Trade

**Primary Marketplaces**:
- OpenSea
- Blur
- LooksRare
- X2Y2

**Search for**: "V-Pass" or "VISE Curriculum Pass"

### Transfer Process

**Via Wallet**:
1. Open wallet (MetaMask, etc.)
2. Find V-Pass NFT
3. Click "Send"
4. Enter recipient address
5. Confirm transaction

**Via Contract**:
```solidity
vpass.transferFrom(yourAddress, recipientAddress, tokenId)
```

### Market Value Factors

V-Pass value depends on:

1. **Rarity**: Legendary > Epic > Rare > Common
2. **Utility**: Active platform usage
3. **Scarcity**: Limited supply per tier
4. **Demand**: Student enrollment
5. **Platform Growth**: Ecosystem expansion

### Potential Appreciation

**Factors Driving Value Up**:
- Platform adoption ↑
- Module expansion ↑
- Celebrity educators ↑
- Partnerships ↑
- Limited supply (fixed at 10,000)

**Legendary Supply Analysis**:
- Only 300 exist
- 1-on-1 sessions ($500+ value/month)
- Lifetime access (worth $1000s)
- Potential $2,000-5,000+ floor if platform succeeds

### Royalties

**Secondary Sales**:
- 5% royalty to DAO treasury (if implemented)
- Funds curriculum development
- Supports ecosystem growth

---

## Token-Gating

### How It Works

The V-Pass contract integrates with the platform to control access:

```solidity
// Platform checks access before showing content
bool hasAccess = vpass.hasModuleAccess(userAddress, moduleId)

if (!hasAccess) {
    // Show "Upgrade V-Pass" prompt
    redirectToMintPage()
} else {
    // Show module content
    displayModule()
}
```

### Module Unlocking

**Automatic**:
- Mint V-Pass
- Access unlocks instantly
- No manual activation needed

**Transfer**:
- Sell V-Pass
- Buyer gets immediate access
- Seller loses access

### Access Persistence

As long as you hold V-Pass:
- Access remains active
- Progress is saved
- Achievements persist

If you sell:
- Access revoked immediately
- Progress frozen (not deleted)
- Can regain by re-buying

### Multi-Pass Holders

If you own multiple V-Passes:
- Highest access level applies
- Benefits stack
- Can gift/sell extras

**Example**:
- Own: Common + Epic
- Access level: 5 (Epic takes precedence)
- Can sell Common, keep Epic access

---

## Governance Rights

### VISE Token Airdrop

Every V-Pass mint includes:
- 100 VISE tokens
- Immediate voting power
- DAO participation rights

### Governance Powers

With VISE tokens, you can:

1. **Vote on Proposals**
   - Curriculum decisions
   - Treasury allocation
   - Platform upgrades
   - Educator selection

2. **Create Proposals**
   - Need 100 VISE (= 1 V-Pass)
   - Propose changes
   - Allocate funds
   - Shape platform

3. **Delegate Votes**
   - Assign voting power
   - Support representatives
   - Participate passively

### Earning More VISE

- Complete modules: 50 VISE each
- Rare holder bonus: +10%
- Epic holder bonus: +25%
- Legendary holder bonus: +50%

**Example** (Legendary holder completes Module 2):
- Base: 50 VISE
- Bonus: 50% = 25 VISE
- **Total: 75 VISE**

---

## FAQs

### General

**Q: What is a V-Pass?**
A: An NFT that grants access to VISE curriculum, with rarity-based benefits.

**Q: Are V-Passes transferable?**
A: Yes! Buy, sell, trade freely.

**Q: How many V-Passes exist?**
A: 10,000 total across 4 rarity tiers.

**Q: What blockchain?**
A: Ethereum mainnet (ERC-721).

### Minting

**Q: How do I mint?**
A: Visit edu.vln.gg/mint or interact with contract directly.

**Q: Can I mint multiple?**
A: Yes! No limit per wallet.

**Q: What if my rarity is sold out?**
A: Choose different tier or buy on secondary market.

**Q: Can I change rarity after minting?**
A: No. Sell and buy different tier, or hold multiple.

### Access

**Q: Do I need V-Pass to access Module 1?**
A: Module 1 is free for all! V-Pass needed for Module 2+.

**Q: Can I share access?**
A: No. Access tied to NFT holder only.

**Q: What if I sell my V-Pass?**
A: You lose access immediately. Buyer gains it.

**Q: Do I need to renew?**
A: No! Epic/Legendary = lifetime. Others = one-time purchase for those modules.

### Value

**Q: Will price increase?**
A: Mint price is fixed. Secondary market price varies.

**Q: Is V-Pass a good investment?**
A: Primarily educational, but has investment potential if platform grows.

**Q: Can I get refund?**
A: No refunds. Sell on secondary market instead.

### Governance

**Q: Do I automatically get VISE tokens?**
A: Yes! 100 VISE airdropped on mint.

**Q: Can I vote without V-Pass?**
A: Yes, if you own VISE tokens from other sources.

**Q: Does rarity affect voting power?**
A: No. All V-Passes get 100 VISE. But bonuses on earnings differ.

---

## Support

**Questions?**
- Discord: #v-pass-support
- Email: support@vln.gg
- Docs: docs.vln.gg

**Report Issues**:
- GitHub: github.com/Fused-Gaming/vise/issues

---

**Last Updated**: 2025-11-23
**Current Supply**: 0/10,000 minted
**Next Update**: After first 1,000 mints
