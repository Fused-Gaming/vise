# Module 3: NFT Engineering - Exercises

## Foundation Exercises

### Exercise 3.1: Basic ERC-721 Implementation
**Objective**: Understand and implement ERC-721 standard

**Tasks**:
1. Create a basic ERC-721 contract from scratch (without OpenZeppelin)
2. Implement required functions:
   - balanceOf, ownerOf, transferFrom, safeTransferFrom, approve, setApprovalForAll
3. Implement required events:
   - Transfer, Approval, ApprovalForAll
4. Add a mint function (only owner can mint)
5. Write tests for all functions

**Success Criteria**:
- Contract implements all ERC-721 required functions
- Events are emitted correctly
- Safe transfers check for receiver capability
- Tests verify compliance with ERC-721 standard
- Minting increments token IDs correctly

### Exercise 3.2: NFT Metadata Structure
**Objective**: Create proper NFT metadata

**Tasks**:
1. Design a metadata JSON schema for a profile picture NFT collection
2. Include required fields:
   - name, description, image
3. Add optional fields:
   - attributes (traits), external_url, background_color
4. Upload sample metadata to IPFS using Pinata or NFT.Storage
5. Create a contract that returns proper tokenURI

**Success Criteria**:
- Metadata follows OpenSea standards
- JSON is valid and well-formatted
- Metadata is successfully stored on IPFS
- tokenURI returns correct IPFS links
- Metadata displays correctly on OpenSea testnet

### Exercise 3.3: OpenZeppelin ERC-721
**Objective**: Use OpenZeppelin implementation effectively

**Tasks**:
1. Create an NFT contract using OpenZeppelin's ERC-721
2. Add extensions:
   - ERC721Enumerable (for token enumeration)
   - ERC721URIStorage (for individual token URIs)
   - Ownable (for access control)
3. Implement batch minting function
4. Add a burn function
5. Deploy to testnet and mint several tokens

**Success Criteria**:
- Contract uses OpenZeppelin libraries correctly
- Extensions work as expected
- Batch minting saves gas compared to individual mints
- Burning properly removes tokens
- Deployment and minting succeed on testnet

### Exercise 3.4: IPFS Integration
**Objective**: Store and retrieve NFT assets from IPFS

**Tasks**:
1. Generate 10 unique images (or use placeholders)
2. Upload images to IPFS and get CIDs
3. Create metadata files referencing the images
4. Upload metadata to IPFS
5. Create a contract that uses the metadata CIDs
6. Write a script to verify all assets are accessible

**Success Criteria**:
- All images successfully uploaded to IPFS
- Metadata correctly references image CIDs
- Metadata files are uploaded and accessible
- Contract properly stores and returns metadata URIs
- Assets remain accessible (use pinning service)

## Intermediate Exercises

### Exercise 3.5: Dynamic NFT Traits
**Objective**: Create NFTs with mutable attributes

**Tasks**:
1. Create an NFT contract where:
   - Base image is stored on IPFS
   - Traits can be updated by owner
   - Metadata is generated on-chain or via API
2. Implement trait categories: Background, Body, Eyes, Accessory
3. Add functions to:
   - Set traits for a token (only token owner)
   - Get current traits
   - Generate metadata URL
4. Emit events when traits change

**Success Criteria**:
- Traits can be updated by token owner only
- Metadata reflects current trait selections
- Events properly log trait changes
- Gas costs are reasonable for trait updates
- Metadata updates are reflected on marketplaces

### Exercise 3.6: ERC-1155 Multi-Token
**Objective**: Implement ERC-1155 standard

**Tasks**:
1. Create an ERC-1155 contract for a game item collection:
   - Fungible items (potions, gold)
   - Non-fungible items (unique weapons)
2. Implement batch minting and transfers
3. Add URI management for both token types
4. Create functions to:
   - Mint fungible tokens (with supply)
   - Mint non-fungible tokens (unique IDs)
   - Batch transfer different token types
5. Write comprehensive tests

**Success Criteria**:
- Contract correctly implements ERC-1155
- Batch operations work efficiently
- Fungible and non-fungible tokens coexist
- URI management handles both token types
- Tests verify all ERC-1155 functionality

### Exercise 3.7: NFT Royalties (ERC-2981)
**Objective**: Implement on-chain royalty standard

**Tasks**:
1. Create an NFT contract with ERC-2981 royalty support
2. Set royalty percentage (e.g., 5%) and recipient
3. Allow creator to update royalty information
4. Implement royaltyInfo function correctly
5. Test with different sale prices
6. Verify royalty support detection (supportsInterface)

**Success Criteria**:
- ERC-2981 interface is correctly implemented
- Royalty calculations are accurate for various prices
- Royalty recipient can be updated by authorized address
- supportsInterface returns true for ERC-2981
- Royalties are honored by compatible marketplaces

### Exercise 3.8: Soulbound Tokens (Non-Transferable)
**Objective**: Create non-transferable NFTs

**Tasks**:
1. Create a Soulbound Token contract based on ERC-721
2. Override transfer functions to revert
3. Implement exceptions:
   - Minting (from zero address)
   - Burning (to zero address)
4. Add an optional "delegate" function for account recovery
5. Emit events for mint and burn operations
6. Test transfer restrictions thoroughly

**Success Criteria**:
- Tokens cannot be transferred between addresses
- Minting from zero address works
- Burning to zero address works
- Delegate functionality works if implemented
- All transfer attempts properly revert
- Tests verify non-transferability

## Advanced Exercises

### Exercise 3.9: Generative NFT Collection
**Objective**: Create a generative art NFT collection

**Tasks**:
1. Design a collection with 5 trait categories, 5 options each
2. Implement on-chain randomness using Chainlink VRF
3. Create trait selection algorithm ensuring rarity distribution
4. Generate metadata on-chain or via API
5. Implement reveal mechanism (hidden before reveal)
6. Deploy collection of 100 NFTs to testnet
7. Create rarity ranking system

**Success Criteria**:
- Random trait selection is provably fair
- Rarity distribution matches intended design
- Reveal mechanism works correctly
- Metadata is generated correctly for each token
- Rarity can be calculated and verified
- Collection successfully deploys and mints

### Exercise 3.10: NFT Rental System
**Objective**: Implement NFT rental/lending mechanism

**Tasks**:
1. Create a rental contract that:
   - Allows NFT owners to list for rent
   - Sets rental price and duration
   - Handles rental payments
   - Tracks rental status
2. Implement using one of these approaches:
   - Wrapper contract (escrow)
   - EIP-4907 (rental NFT standard)
3. Handle rental expiration automatically
4. Add rental extension capability
5. Emit events for all rental actions

**Success Criteria**:
- NFTs can be listed for rent with price and duration
- Renters can access NFT utility during rental period
- Original owner retains ownership
- Rental expires correctly
- Payments are handled securely
- Events allow tracking rental lifecycle

### Exercise 3.11: Fractional NFT Ownership
**Objective**: Enable shared ownership of NFTs

**Tasks**:
1. Create a fractionalization contract that:
   - Locks an NFT in escrow
   - Mints ERC-20 tokens representing shares
   - Allows buyout if threshold reached
   - Handles vote-based decisions
2. Implement:
   - Vault creation (deposit NFT, mint shares)
   - Share trading on DEX
   - Buyout mechanism
   - NFT redemption for majority holder
3. Add governance for vault decisions

**Success Criteria**:
- NFT is securely locked in vault
- Shares are correctly minted and distributed
- Share trading works with standard DEXes
- Buyout mechanism functions properly
- Governance allows shared decision-making
- Original NFT can be redeemed

### Exercise 3.12: Cross-Chain NFT Bridge
**Objective**: Bridge NFTs between chains

**Tasks**:
1. Create contracts on two testnets (e.g., Sepolia and Mumbai)
2. Implement bridge mechanism:
   - Lock NFT on source chain
   - Mint wrapped NFT on destination chain
   - Burn wrapped NFT when bridging back
   - Unlock original NFT on source chain
3. Add bridge operators/validators for security
4. Implement message passing (use LayerZero or manual)
5. Handle bridge failures gracefully

**Success Criteria**:
- NFT can be bridged from Chain A to Chain B
- Metadata is preserved across chains
- Bridge back to original chain works
- Security mechanisms prevent double-spending
- Failed bridges are properly handled
- Events allow tracking cross-chain transfers

## Integration Exercises

### Exercise 3.13: NFT Marketplace with Auctions
**Objective**: Build a complete NFT marketplace

**Tasks**:
1. Create a marketplace contract supporting:
   - Fixed price listings
   - English auctions (ascending price)
   - Dutch auctions (descending price)
   - Offers/bids on unlisted NFTs
2. Implement marketplace features:
   - Platform fee (2.5%)
   - Creator royalties (ERC-2981)
   - Bulk listing/delisting
   - Currency support (ETH and ERC-20)
3. Add auction features:
   - Bid extension on last-minute bids
   - Reserve price
   - Auction cancellation
4. Write comprehensive tests and deploy to testnet

**Success Criteria**:
- All listing types work correctly
- Auctions handle bidding and settlement
- Fees and royalties are correctly distributed
- Multiple currencies are supported
- Tests cover all marketplace scenarios
- Testnet deployment is verified and functional

### Exercise 3.14: NFT Staking Platform
**Objective**: Create NFT staking with rewards

**Tasks**:
1. Create a staking contract for NFTs:
   - Stake NFTs to earn ERC-20 rewards
   - Different rarity levels earn different rates
   - Lock period options (no lock, 30d, 90d, 180d)
   - Bonus rewards for longer locks
2. Implement reward distribution:
   - Calculate rewards per block/second
   - Compound interest option
   - Emergency withdrawal (forfeit rewards)
3. Add collection features:
   - Support multiple NFT collections
   - Collection-specific reward rates
   - Admin functions for configuration

**Success Criteria**:
- NFTs can be staked and unstaked
- Rewards calculate correctly based on rarity and time
- Lock periods are enforced properly
- Different collections can coexist
- Admin can configure parameters
- Tests verify reward calculations

### Exercise 3.15: NFT-Gated DAO
**Objective**: Implement NFT-based governance

**Tasks**:
1. Create a DAO where:
   - NFT holders can create proposals
   - Voting power based on NFT traits/rarity
   - Quorum requires minimum NFTs voting
   - Timelock for execution
2. Implement proposal types:
   - Treasury spending
   - Parameter changes
   - Collection upgrades
3. Add delegation mechanism
4. Create voting strategies:
   - One NFT = One Vote
   - Weighted by rarity
   - Quadratic voting
5. Deploy complete system to testnet

**Success Criteria**:
- NFT holders can propose and vote
- Voting power calculation is accurate
- Quorum and majority requirements work
- Timelock provides security
- Delegation functions properly
- Complete governance cycle works end-to-end

## Practical Application

### Exercise 3.16: Profile Picture (PFP) Collection
**Objective**: Launch a complete PFP NFT collection

**Task**:
Create a full PFP collection:
1. Design collection concept and traits
2. Generate artwork (or use tools/AI)
3. Create smart contract with:
   - Max supply (e.g., 10,000)
   - Minting limits per wallet
   - Whitelist/allowlist for early access
   - Reveal mechanism
   - Royalties
4. Upload all assets to IPFS
5. Create minting website
6. Deploy to testnet and conduct test mint

**Success Criteria**:
- Collection design is complete and cohesive
- Smart contract implements all features
- Assets are properly stored and pinned on IPFS
- Minting website works smoothly
- Whitelist and limits are enforced
- Reveal mechanism functions correctly

### Exercise 3.17: Music NFT Platform
**Objective**: Build NFT system for music ownership

**Task**:
Create a platform for music NFTs:
1. NFT contract for song ownership:
   - Store audio file on IPFS/Arweave
   - Metadata includes artist, album, duration
   - Royalty splits between multiple creators
2. Streaming rights contract:
   - NFT owner can grant streaming access
   - Listeners pay per stream or subscription
   - Payments distributed to rights holders
3. Collaborative features:
   - Multiple artists can co-own a track
   - Revenue splits defined in contract
4. Build simple player interface

**Success Criteria**:
- Audio files are permanently stored
- Metadata is comprehensive and accurate
- Royalty splits work correctly
- Streaming access is properly gated
- Payments are distributed accurately
- Player can fetch and play NFT audio

### Exercise 3.18: Real-World Asset NFT
**Objective**: Tokenize real-world assets

**Task**:
Create an NFT system representing real-world assets:
1. Choose asset type (e.g., real estate shares, luxury items)
2. Design NFT contract with:
   - Detailed metadata about physical asset
   - Legal agreements stored on IPFS
   - Ownership verification mechanism
   - Transfer restrictions (KYC/AML compliance)
3. Implement compliance features:
   - Whitelist of verified buyers
   - Transfer approval by administrator
   - Regulatory reporting
4. Create redemption mechanism for physical asset
5. Document complete legal and technical framework

**Success Criteria**:
- NFT accurately represents real asset
- Legal documentation is comprehensive
- Compliance mechanisms work correctly
- Transfer restrictions are enforced
- Redemption process is clear
- Documentation covers all aspects

## Bonus Challenges

### Challenge 3.1: On-Chain SVG NFT
Create an NFT that generates SVG images entirely on-chain. No IPFS needed!

### Challenge 3.2: NFT Evolution System
Build NFTs that evolve based on on-chain or off-chain conditions (time, activity, external data).

### Challenge 3.3: Zero-Knowledge NFT Ownership
Implement a system where someone can prove they own an NFT without revealing which specific token they own.

### Challenge 3.4: NFT Derivatives
Create a system for creating derivative NFTs (like remixes) while maintaining attribution and royalty chain.

## Assessment Preparation

Complete these to prepare for your NFT-1 assessment:

1. **Collection Portfolio**: Launch at least 2 NFT collections on testnet
2. **Marketplace Integration**: List your NFTs on OpenSea testnet
3. **Documentation**: Write complete technical docs for one collection
4. **Gas Analysis**: Document gas costs for all your contracts
5. **Security Review**: Conduct self-audit using NFT security checklist
6. **Presentation**: Create a demo showing your best NFT project

## Additional Resources

- [ERC-721 Standard](https://eips.ethereum.org/EIPS/eip-721)
- [ERC-1155 Standard](https://eips.ethereum.org/EIPS/eip-1155)
- [ERC-2981 Royalty Standard](https://eips.ethereum.org/EIPS/eip-2981)
- [OpenSea Metadata Standards](https://docs.opensea.io/docs/metadata-standards)
- [NFT.Storage Documentation](https://nft.storage/docs/)
- [Pinata IPFS Guide](https://docs.pinata.cloud/)

## Tips for Success

1. **Test on Testnet First**: Always deploy and test on testnet before mainnet
2. **IPFS Pinning**: Use a pinning service to keep your metadata available
3. **Gas Optimization**: Batch operations and optimize storage for gas savings
4. **Metadata Standards**: Follow OpenSea standards for marketplace compatibility
5. **Smart Contract Security**: NFTs are valuable - security is critical
6. **Community**: Join NFT developer communities for support
7. **Royalties**: Implement ERC-2981 for creator royalties
8. **Reveal Mechanisms**: Consider using reveals for launch excitement
9. **Enumeration**: Be aware of gas costs with ERC721Enumerable
10. **Cross-Platform**: Test how your NFTs appear on different platforms

---

These exercises will give you comprehensive understanding of NFT development. Take your time and build quality projects! 🎨

---

**Exercise Author**: @jmenichole
