# Sprint 2: NFT or Tokenomics Integration

**Token Earned:** SPR-2
**Duration:** 2-3 Weeks
**Prerequisites:** SPR-1 Token

## Sprint Overview

Build on your existing project or create a new one that integrates either NFT functionality or tokenomics. This sprint demonstrates your ability to combine AI capabilities with blockchain technologies to create real Web3 applications.

## Learning Objectives

By the end of this sprint, you will have:
- Integrated smart contracts with a frontend application
- Implemented NFT or token features in a real application
- Deployed contracts to testnet and connected them to your app
- Created a full-stack Web3 application
- Demonstrated understanding of Web3 user experience

## Choose Your Track

### Track A: NFT Integration
Focus on NFT features, metadata, and blockchain interactions

### Track B: Tokenomics Integration
Focus on token economies, rewards, and incentive systems

**You must choose ONE track but can incorporate elements of both.**

---

## Track A: NFT Integration

### Project Requirements

Your application must include:

1. **NFT Smart Contract**: ERC-721 or ERC-1155 deployed on testnet
2. **Minting Functionality**: Users can mint NFTs through your app
3. **Metadata Management**: IPFS or on-chain metadata
4. **Wallet Integration**: MetaMask or WalletConnect
5. **NFT Display**: Show owned NFTs
6. **AI Integration**: AI enhances the NFT experience

### Technical Requirements

- **Smart Contracts**: Solidity (Hardhat or Foundry)
- **Frontend**: React, Next.js, or similar
- **Web3 Library**: ethers.js, viem, or web3.js
- **Wallet**: MetaMask integration (minimum)
- **Storage**: IPFS for metadata/images
- **Testnet**: Sepolia, Goerli, or Polygon Mumbai

### Project Ideas

Choose one or create your own:

#### 1. AI-Generated NFT Collection Platform
- Users input prompts
- AI generates unique artwork
- Mint as NFT with AI metadata
- Gallery of created NFTs

#### 2. Achievement & Certification NFTs
- Learning platform with NFT certificates
- Dynamic NFTs that evolve with progress
- AI-verified completion of tasks
- Soulbound tokens for credentials

#### 3. NFT-Gated AI Assistant
- AI chatbot or tool
- Access controlled by NFT ownership
- Different tiers with different NFTs
- Membership benefits

#### 4. Dynamic Story NFTs
- NFTs that tell evolving stories
- AI generates story updates
- Metadata changes over time
- Community-driven narratives

#### 5. AI Art Collaboration NFTs
- Multiple users contribute prompts
- AI blends contributions
- Co-created NFT minted
- Royalty splitting among contributors

### NFT-Specific Features to Implement

Choose at least 3:

- ✅ Minting with custom metadata
- ✅ Royalty implementation (ERC-2981)
- ✅ Whitelist/allowlist system
- ✅ Reveal mechanism
- ✅ Token-gated content
- ✅ NFT trading/marketplace
- ✅ Dynamic NFT traits
- ✅ Batch minting
- ✅ Burning mechanism
- ✅ Evolution/upgrade system

---

## Track B: Tokenomics Integration

### Project Requirements

Your application must include:

1. **Token Smart Contract**: ERC-20 deployed on testnet
2. **Token Distribution**: Mechanism for users to earn tokens
3. **Token Utility**: Tokens have clear purpose in your app
4. **Wallet Integration**: MetaMask or WalletConnect
5. **Token Dashboard**: Show balances and transactions
6. **AI Integration**: AI enhances the token economy

### Technical Requirements

- **Smart Contracts**: Solidity (Hardhat or Foundry)
- **Frontend**: React, Next.js, or similar
- **Web3 Library**: ethers.js, viem, or web3.js
- **Wallet**: MetaMask integration (minimum)
- **Testnet**: Sepolia, Goerli, or Polygon Mumbai

### Project Ideas

Choose one or create your own:

#### 1. Learn-to-Earn Platform
- Complete lessons powered by AI
- Earn tokens for completing modules
- Stake tokens for advanced content
- Token-based leaderboard

#### 2. AI Task Marketplace
- Users post tasks for AI to solve
- Pay with tokens
- Workers verify AI output, earn tokens
- Reputation system with token bonding

#### 3. Token-Curated AI Prompts
- Community submits prompts
- Token holders vote on quality
- Top prompts earn rewards
- Prompt marketplace with tokens

#### 4. AI Content Creation with Rewards
- Generate content with AI
- Token rewards based on engagement
- Stake tokens to boost visibility
- Governance over platform features

#### 5. Decentralized AI Inference
- Users pay tokens for AI API access
- Distribute rewards to infrastructure providers
- Staking for priority access
- Token buyback from revenue

### Token-Specific Features to Implement

Choose at least 3:

- ✅ Token earning mechanisms
- ✅ Token spending/burning
- ✅ Staking for rewards
- ✅ Governance voting
- ✅ Vesting schedules
- ✅ Token-gated features
- ✅ Liquidity pool integration
- ✅ Reward distribution
- ✅ Token buyback mechanism
- ✅ Fee sharing with holders

---

## Universal Requirements (Both Tracks)

### 1. Web3 Integration

**Wallet Connection**
- Connect/disconnect wallet
- Network switching
- Account change handling
- Transaction signing

**Smart Contract Interaction**
- Read contract data
- Write transactions
- Event listening
- Error handling

**User Experience**
- Loading states
- Transaction confirmations
- Error messages
- Gas estimation

### 2. AI Integration

Your AI must serve a clear purpose:
- Generate content (text, images, metadata)
- Analyze user behavior
- Provide recommendations
- Automate processes
- Enhance user experience

### 3. Testing

**Smart Contract Tests**
- Unit tests for all functions
- Edge case coverage
- Gas optimization verification
- Security checks

**Frontend Tests**
- Component testing
- Integration tests
- E2E tests (optional but recommended)

### 4. Documentation

**User Documentation**
- How to connect wallet
- How to acquire testnet tokens
- Feature tutorials
- FAQ section

**Technical Documentation**
- Architecture diagram
- Smart contract documentation
- API documentation
- Deployment guide

## Sprint Schedule

### Week 1: Planning & Smart Contracts

**Days 1-2: Planning**
- Choose track and project idea
- Design smart contract architecture
- Plan token/NFT economics
- Create wireframes

**Days 3-5: Smart Contract Development**
- Implement smart contracts
- Write comprehensive tests
- Deploy to local network
- Security review

**Days 6-7: Testnet Deployment**
- Deploy to public testnet
- Verify contracts
- Test on testnet
- Document contract addresses

### Week 2: Frontend Integration

**Days 8-10: Frontend Development**
- Build UI components
- Integrate wallet connection
- Connect to smart contracts
- Implement core features

**Days 11-14: Integration & Testing**
- AI integration
- End-to-end testing
- Bug fixes
- UX improvements

### Week 3: Polish & Deployment (Optional)

**Days 15-17: Final Polish**
- Performance optimization
- UI/UX refinement
- Documentation completion
- Video demo creation

**Days 18-21: Presentation Prep**
- Prepare presentation
- Final testing
- Submit for review
- Present to panel

## Evaluation Criteria

### 1. Smart Contract Implementation (30%)
- Correct implementation of standards
- Security best practices
- Gas optimization
- Test coverage

### 2. Web3 Integration (25%)
- Wallet connection UX
- Transaction handling
- Error management
- Event monitoring

### 3. AI Integration (20%)
- Meaningful AI usage
- Quality of AI features
- Prompt engineering
- Value addition

### 4. User Experience (15%)
- Intuitive design
- Clear workflows
- Responsive interface
- Error messaging

### 5. Documentation & Presentation (10%)
- Clear documentation
- Architecture clarity
- Demo quality
- Presentation skills

## Submission Requirements

Submit the following:

1. **GitHub Repository**: Complete source code
2. **Live Demo**: Publicly accessible frontend
3. **Testnet Contracts**: Verified on block explorer
4. **Demo Video**: 5-7 minute walkthrough
5. **Documentation**: Complete user and technical docs
6. **Presentation**: 15-minute live demo
7. **Reflection**: 1000-word essay on technical decisions

## Technical Architecture

Your project should include:

```
Architecture Components:
├── Smart Contracts (Testnet)
│   ├── NFT/Token Contract
│   ├── Helper Contracts (if needed)
│   └── Test Suite
├── Frontend Application
│   ├── Wallet Integration
│   ├── Contract Interactions
│   ├── AI Features
│   └── UI Components
├── Backend (Optional)
│   ├── API Server
│   ├── Database
│   └── AI Processing
└── Infrastructure
    ├── IPFS (for NFTs)
    ├── RPC Provider
    └── Deployment
```

## Recommended Tech Stack

### Smart Contracts
- **Hardhat** or **Foundry**
- **OpenZeppelin Contracts**
- **Ethers.js** for testing

### Frontend
- **Next.js** or **React**
- **Wagmi** + **RainbowKit** (recommended)
- **TailwindCSS** or **Chakra UI**
- **Ethers.js** or **Viem**

### Storage (for NFTs)
- **Pinata** or **NFT.Storage**
- **IPFS** client libraries

### Backend (if needed)
- **Node.js/Express**
- **PostgreSQL** or **MongoDB**
- **Redis** for caching

## Token Issuance

### Passing Criteria
- Score 80% or higher on all evaluation criteria
- Working smart contracts on testnet
- Functional frontend with Web3 integration
- Successful live demo
- Peer review approval (2 peers)
- Mentor approval

### SPR-2 Token Benefits
- Access to Sprint 3: Full Web3 App & Deployment
- Higher governance voting weight
- Access to advanced resources
- Eligibility for larger grants
- Featured project opportunity
- Mentor others in Sprints 1-2

## Resources & Support

### Web3 Development
- Scaffold-ETH 2 examples
- Wagmi documentation
- RainbowKit quick start
- OpenZeppelin contract wizard

### NFT Resources
- OpenSea metadata standards
- IPFS documentation
- NFT best practices guide

### Token Resources
- ERC-20 security checklist
- Tokenomics modeling tools
- Governance patterns

### Community Support
- VISE Discord #sprint-2 channel
- Web3 integration office hours
- Smart contract review sessions
- Frontend help desk

## Tips for Success

### Smart Contracts
1. Start with OpenZeppelin base contracts
2. Test extensively before deployment
3. Use testnet faucets early
4. Document all contract functions
5. Consider upgrade patterns

### Frontend Integration
1. Use established Web3 libraries
2. Handle all wallet edge cases
3. Provide clear transaction feedback
4. Test with different wallets
5. Optimize for mobile

### AI Integration
1. Don't force AI where it doesn't fit
2. Optimize API costs
3. Cache AI responses when possible
4. Provide fallbacks for AI failures
5. Be transparent about AI usage

## Common Challenges & Solutions

### Challenge: Testnet RPC Limitations
**Solution**: Use multiple RPC providers with fallback

### Challenge: IPFS Upload Latency
**Solution**: Show progress indicators, use pinning services

### Challenge: Wallet Connection Issues
**Solution**: Test with multiple wallets, provide clear error messages

### Challenge: Gas Cost Surprises
**Solution**: Estimate gas before transactions, optimize contracts

### Challenge: Metadata Standards
**Solution**: Follow OpenSea standards, validate JSON

## Peer Review Process

1. **Code Review** (2 peers must approve):
   - Smart contract security
   - Code quality
   - Best practices

2. **Functionality Testing**:
   - Test all features
   - Find and report bugs
   - Suggest improvements

3. **Documentation Review**:
   - Clarity check
   - Completeness
   - Accuracy

## Presentation Format

Your 15-minute presentation must cover:

1. **Introduction** (2 min): Project overview and goals
2. **Live Demo** (7 min): Full walkthrough of features
3. **Smart Contract Deep Dive** (3 min): Key contract features
4. **AI Integration** (2 min): How AI enhances the app
5. **Q&A** (1 min): Answer questions

## Next Steps After SPR-2

Upon earning SPR-2 token, you advance to:

**Sprint 3: Full Web3 App & Deployment**
- Production-ready application
- Mainnet deployment (optional)
- Advanced features
- Comprehensive testing
- Full DevOps pipeline

## Showcase Opportunities

Outstanding projects will receive:
- Featured on VISE homepage
- Social media promotion
- Demo day presentation slot
- Grant funding consideration
- Partnership introductions
- Conference presentation opportunities

## Legal Notice

- Deploy only to testnets for this sprint
- No real financial value should be involved
- Comply with local regulations
- Include appropriate disclaimers
- Respect intellectual property

Build something amazing! 🌟
