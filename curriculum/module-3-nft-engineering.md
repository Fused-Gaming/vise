# Module 3: NFT Engineering

**Token Earned:** NFT-1
**Duration:** 1 Week
**Prerequisites:** SOL-1 Token

## Learning Objectives

By the end of this module, you will be able to:
- Understand NFT standards (ERC-721, ERC-1155)
- Design and implement custom NFT contracts
- Create metadata schemas and store them appropriately
- Build minting mechanisms and royalty systems
- Integrate NFTs with frontends and marketplaces
- Implement advanced NFT features (traits, evolution, utility)
- Use AI to generate NFT artwork and metadata

## Course Outline

### Day 1: NFT Fundamentals

**Topics:**
- What are NFTs and why do they matter?
- ERC-721 standard deep dive
- Token IDs, ownership, and transfers
- Metadata structure and standards
- IPFS and decentralized storage

**Key Concepts:**
- Non-fungibility vs. fungibility
- Token URI and off-chain metadata
- OpenSea metadata standards
- Content addressing with IPFS
- Pinning services (Pinata, NFT.Storage)

**Learning Activities:**
- Explore: Analyze popular NFT collections on OpenSea
- Read: ERC-721 specification
- Experiment: Upload metadata to IPFS
- Exercise: Create a metadata JSON file

### Day 2: ERC-721 Implementation

**Topics:**
- Implementing ERC-721 from scratch
- OpenZeppelin ERC-721 contracts
- Minting functions and access control
- Enumeration extensions
- Burnable tokens

**Key Concepts:**
- Required ERC-721 functions
- SafeMint vs. regular mint
- Token enumeration patterns
- Owner enumeration
- Batch operations

**Learning Activities:**
- Code: Implement a basic ERC-721 contract
- Deploy: Launch your first NFT collection (testnet)
- Mint: Create test tokens with metadata
- Test: Write comprehensive test suite

### Day 3: Advanced NFT Standards & Features

**Topics:**
- ERC-1155 multi-token standard
- Comparison: ERC-721 vs ERC-1155
- Royalty standards (ERC-2981)
- Soulbound tokens (ERC-5192)
- Dynamic NFTs

**Key Concepts:**
- Multi-token efficiency
- Fungible and non-fungible in one contract
- On-chain royalties
- Non-transferable tokens
- Updatable metadata

**Learning Activities:**
- Build: Create an ERC-1155 game item contract
- Implement: Add ERC-2981 royalties to your collection
- Experiment: Build a dynamic NFT that changes over time
- Compare: Gas costs of 721 vs 1155

### Day 4: Minting Mechanisms & Economics

**Topics:**
- Public vs. whitelist minting
- Dutch auctions and bonding curves
- Merkle tree whitelists
- Mint passes and token-gating
- Fair launch strategies

**Key Concepts:**
- Gas-efficient whitelist verification
- Provenance and randomness
- Chainlink VRF for fair minting
- Anti-bot measures
- Minting limits per wallet

**Learning Activities:**
- Implement: Merkle tree whitelist system
- Build: Dutch auction minting contract
- Secure: Add anti-sniping mechanisms
- Design: Create a fair mint strategy

### Day 5: NFT Metadata & Art Generation

**Topics:**
- Metadata schemas and best practices
- On-chain vs. off-chain metadata
- Generative art systems
- Traits and rarity calculation
- AI-generated artwork

**Key Concepts:**
- Base64 encoding for on-chain SVGs
- Trait composition algorithms
- Rarity scoring
- Image generation pipelines
- Text-to-image AI models

**Learning Activities:**
- Generate: Create 100 NFT variants programmatically
- Build: Traits system with rarity weights
- Experiment: Use AI to generate NFT artwork
- Deploy: On-chain SVG NFT collection

### Day 6: Integration & Marketplaces

**Topics:**
- OpenSea integration and requirements
- Building custom marketplace contracts
- NFT lending and renting protocols
- Fractionalization (ERC-20 wrapping)
- Cross-chain NFTs

**Key Concepts:**
- Marketplace royalty enforcement
- Order book vs. listing systems
- Collateralized NFT loans
- ERC-721 to ERC-20 conversion
- Bridge security considerations

**Learning Activities:**
- Integrate: Make your NFTs visible on OpenSea
- Build: Simple NFT marketplace contract
- Implement: NFT rental system
- Research: Cross-chain bridge options

### Day 7: Assessment & Token Issuance

**Assessment Components:**
1. **Technical Exam (20%)**: NFT standards and best practices
2. **NFT Collection Project (60%)**: Complete NFT project with unique features
3. **Integration Challenge (20%)**: Deploy and integrate with a marketplace

**Project Requirements:**
- Design and implement a unique NFT collection
- Include at least one advanced feature (royalties, whitelist, dynamic traits)
- Deploy to testnet with full metadata on IPFS
- Write comprehensive documentation
- Create a simple frontend for minting

**Passing Criteria:**
- Score 80% or higher on all components
- Demonstrate creativity and technical skill
- Successfully deploy and verify contracts
- Show NFTs properly on a marketplace

**Token Issuance:**
- Upon successful completion, receive NFT-1 token
- Token grants access to Module 4: Tokenomics
- Token recorded on-chain with achievement metadata
- NFT-1 itself is a special achievement NFT with unique artwork

## Recommended Development Stack

### Smart Contract Tools
- Hardhat with ERC-721/1155 templates
- OpenZeppelin Contracts library
- Merkle tree generators

### Storage Solutions
- IPFS (InterPlanetary File System)
- Pinata or NFT.Storage for pinning
- Arweave (permanent storage)

### Frontend Integration
- ethers.js or web3.js
- wagmi + RainbowKit
- Next.js for web apps

### Art & Metadata Tools
- Node.js scripts for generation
- AI image generation APIs (Stable Diffusion, DALL-E)
- SVG libraries for on-chain art

## Project Ideas

Choose one for your final assessment:

1. **Generative Art Collection**: 1000+ unique pieces with trait system
2. **Dynamic Achievement NFTs**: Badges that evolve with user progress
3. **Game Item NFTs**: ERC-1155 items with in-game utility
4. **Membership Tokens**: Access passes with tiered benefits
5. **Soulbound Certificates**: Non-transferable credentials
6. **Music NFTs**: Audio files with streaming rights
7. **Fractional Real Estate**: Property shares as NFTs

## Resources

### Required Reading
- ERC-721 and ERC-1155 specifications
- OpenSea metadata standards
- "The NFT Handbook" - Technical chapters
- IPFS documentation

### Recommended Learning
- OpenZeppelin NFT tutorials
- Scaffold-ETH NFT examples
- Alchemy NFT API documentation

### Community Resources
- VISE Discord #nft-engineering channel
- Weekly NFT showcase sessions
- Artist collaboration opportunities
- Marketplace integration support

## Prerequisites for NFT-1 Token

To earn your NFT-1 token, you must:
1. Complete all daily learning activities
2. Achieve 80%+ on the final assessment
3. Deploy a complete NFT collection on testnet
4. Submit project documentation and code
5. Present your project to peers (5-minute demo)
6. Receive approval from 2 mentor reviewers

## Next Steps

After earning NFT-1, you will unlock:
- Module 4: Tokenomics
- Advanced NFT patterns library
- Access to artist community
- Eligibility for NFT grants
- Gallery showcase opportunities
- NFT collection launch support

## Special Note

Your NFT-1 achievement token is itself an NFT with unique properties:
- Dynamic metadata showing your project highlights
- Traits based on your module performance
- Exclusive holder benefits in the VISE ecosystem
- Can be displayed in your digital portfolio
