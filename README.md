# VISE - Verified in Skills: Exploits

> On-chain curriculum certifications for Web3 developers

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/Fused-Gaming/vise/issues)

## What is VISE?

**VISE** (Verified in Skills: Exploits) is a comprehensive Web3 education platform that combines AI-assisted learning with blockchain-verified certifications. Each achievement is recorded on-chain as a non-transferable NFT (Soulbound Token), creating a verifiable, permanent record of your Web3 expertise.

### Why VISE?

- **Merit-Based Progression**: Earn tokens by demonstrating real competence
- **On-Chain Credentials**: Verifiable, permanent achievement NFTs
- **AI-Enhanced Learning**: Leverage AI tools throughout your journey
- **Real-World Projects**: Build portfolio-worthy applications
- **Community Governance**: Token holders shape the platform
- **Career Advancement**: Job board access and industry connections

---

## Learning Journey

VISE provides a structured path from AI fundamentals to production Web3 deployment:

```mmd
flowchart LR
    A[Start: AI & Prompt Intro] --> B[Week 1: Prompt Engineering Fundamentals]
    B --> C[Week 2: Solidity & Smart Contracts]
    C --> D[Week 3: NFTs & Tokenomics]
    D --> E[Week 4: Privacy & DevOps Integration]
    E --> F[Sprint 1: Build Simple AI-powered App]
    F --> G[Sprint 2: NFT/Token Project Development]
    G --> H[Sprint 3: Full Web3 App & Deployment]
    H --> I[Completion: Issue NFT Certificate]
```

---

## Curriculum Structure

### Core Modules (6 Weeks)

Each module is a comprehensive 7-day learning program with daily activities, resources, and assessments.

| Module | Topic | Token Earned | Duration |
|--------|-------|--------------|----------|
| **Module 1** | [Prompt Engineering Fundamentals](./curriculum/module-1-prompt-engineering.md) | PE-1 | 1 week |
| **Module 2** | [Solidity & Smart Contracts](./curriculum/module-2-solidity-smart-contracts.md) | SOL-1 | 1 week |
| **Module 3** | [NFT Engineering](./curriculum/module-3-nft-engineering.md) | NFT-1 | 1 week |
| **Module 4** | [Tokenomics](./curriculum/module-4-tokenomics.md) | TOK-1 | 1 week |
| **Module 5** | [Privacy & Security](./curriculum/module-5-privacy-security.md) | PRIV-1 | 1 week |
| **Module 6** | [AI-Assisted DevOps](./curriculum/module-6-ai-assisted-devops.md) | DEV-1 | 1 week |

### Sprint Projects (6-10 Weeks)

Apply your knowledge in hands-on projects that build on each other:

| Sprint | Project | Token Earned | Duration |
|--------|---------|--------------|----------|
| **Sprint 1** | [AI-Powered Mini Application](./sprints/sprint-1-ai-mini-app.md) | SPR-1 | 2 weeks |
| **Sprint 2** | [NFT or Tokenomics Integration](./sprints/sprint-2-nft-token-integration.md) | SPR-2 | 2-3 weeks |
| **Sprint 3** | [Full Web3 App & Production Deployment](./sprints/sprint-3-full-web3-deployment.md) | MASTER | 3-4 weeks |

### Practice Exercises

Reinforce your learning with hands-on exercises for each module:

- [Exercise Overview](./exercises/README.md)
- [Module 1 Exercises: Prompt Engineering](./exercises/module-1-exercises.md)
- [All Module Exercises](./exercises/all-modules-exercises.md)

---

## Token Progression & Attestations

Each achievement unlocks the next level and grants governance rights:

```mmd
flowchart TD
    A0([Start: No Token]) --> A1[Module 1: Prompt Engineering]
    A1 -->|Earns PE-1| T1((PE-1 Token))

    %% Solidity
    T1 --> A2[Module 2: Solidity Smart Contracts]
    A2 -->|Earns SOL-1| T2((SOL-1 Token))

    %% NFT
    T2 --> A3[Module 3: NFT Engineering]
    A3 -->|Earns NFT-1| T3((NFT-1 Token))

    %% Tokenomics
    T3 --> A4[Module 4: Tokenomics]
    A4 -->|Earns TOK-1| T4((TOK-1 Token))

    %% Privacy
    T4 --> A5[Module 5: Privacy & Security]
    A5 -->|Earns PRIV-1| T5((PRIV-1 Token))

    %% DevOps
    T5 --> A6[Module 6: AI-Assisted DevOps]
    A6 -->|Earns DEV-1| T6((DEV-1 Token))

    %% Sprints
    T6 --> S1[Sprint 1: AI Mini App]
    S1 -->|Earns SPR-1| TS1((SPR-1 Token))

    TS1 --> S2[Sprint 2: NFT or Tokenomics Integration]
    S2 -->|Earns SPR-2| TS2((SPR-2 Token))

    TS2 --> S3[Sprint 3: Full Web3 App Deployment]
    S3 -->|Earns MASTER| TM((MASTER Certificate))
```

### Achievement Tokens

All achievement tokens are **Soulbound NFTs** (non-transferable) that verify your skills:

| Token | Skill Verified | Voting Power | Special Privileges |
|-------|----------------|--------------|-------------------|
| **PE-1** | Prompt Engineering | 1 vote | Can review prompts |
| **SOL-1** | Solidity Development | 1 vote | Can review smart contracts |
| **NFT-1** | NFT Engineering | 1 vote | Access to artist community |
| **TOK-1** | Tokenomics Design | 1 vote | Economic advisory role |
| **PRIV-1** | Security Auditing | 2 votes | Security auditor certification |
| **DEV-1** | DevOps & Infrastructure | 2 votes | Infrastructure consultation |
| **SPR-1** | AI Application Builder | 3 votes | Grant eligibility ($1k) |
| **SPR-2** | Web3 Integration | 5 votes | Grant eligibility ($2.5k) |
| **MASTER** | Full-Stack Web3 Developer | 10 votes | Maximum benefits & $10k grants |

[→ Learn more about Token Utility](./utility/token-utility.md)

---

## Governance

VISE is governed by its community through a progressive DAO structure:

```mmd
flowchart TD
    %% Top-Level Governance Structure
    A[Governance Overview] --> B[Token Utility]
    A --> C[Role Permissions]
    A --> D[Decision Making]
    A --> E[Escalation Paths]

    %% Token Utility
    B --> B1[Governance Token Access]
    B --> B2[Reputation Score]
    B --> B3[Staked Progression]
    B --> B4[Unlock Higher Difficulty Tracks]

    %% Role Permissions
    C --> C1[Student / Learner]
    C --> C2[Builder / Contributor]
    C --> C3[Mentor / Reviewer]
    C --> C4[Admin / Owner]

    %% Decision Making
    D --> D1[Proposal Creation]
    D --> D2[Voting Weighted by Progress]
    D --> D3[Sprint Completion = More Vote Power]
    D --> D4[AI-Assisted Decision Drafts]

    %% Escalation Paths
    E --> E1[Dispute Review]
    E --> E2[Appeal to Mentors]
    E --> E3[Admin Final Decision]
    E --> E4[Audit Trail on-Chain]

    %% Confidence & Attestation
    B3 --> F[On-Chain Attestation NFT]
    F --> G[Unlock Advanced Program Tracks]
    G --> H[Capstone Governance Rights]
```

### Governance Roles

| Role | Token Requirement | Voting Power | Responsibilities |
|------|------------------|--------------|------------------|
| **Student** | None | None | Learning and observing |
| **Builder** | Any module token | 1-6 votes | Participating in community |
| **Mentor** | PRIV-1/DEV-1 or 4+ tokens | 10+ votes | Reviewing submissions, teaching |
| **Master** | MASTER certificate | 25+ votes | Strategic direction, advanced teaching |
| **Admin** | Appointed | 50+ votes | Platform operations, security |

[→ Read the full Governance Framework](./governance/governance-framework.md)

---

## Getting Started

### For Students

1. **Start Learning**: Begin with [Module 1: Prompt Engineering](./curriculum/module-1-prompt-engineering.md)
2. **Practice**: Complete [exercises](./exercises/README.md) for each module
3. **Build Projects**: Progress through the [Sprint projects](./sprints/)
4. **Earn Tokens**: Receive on-chain achievement NFTs
5. **Join Governance**: Participate in platform decisions

### For Mentors

1. **Complete Requirements**: Earn PRIV-1, DEV-1, or 4+ module tokens
2. **Apply**: Submit mentor application through governance
3. **Review Work**: Grade student submissions and provide feedback
4. **Earn Rewards**: Receive VISE tokens for quality mentorship
5. **Shape Curriculum**: Propose improvements to courses

### For Contributors

1. **Find Issues**: Check [GitHub Issues](https://github.com/Fused-Gaming/vise/issues)
2. **Propose Changes**: Submit proposals through governance
3. **Submit PRs**: Contribute code, content, or documentation
4. **Earn Recognition**: Receive contributor badges and tokens
5. **Build Community**: Help grow the VISE ecosystem

---

## Key Features

### 🎓 Comprehensive Curriculum
- 6 core modules covering full Web3 stack
- 3 hands-on sprint projects
- 100+ practical exercises
- AI-enhanced learning throughout

### 🏆 On-Chain Credentials
- Soulbound NFT achievements
- Verifiable, permanent record
- Portable to any platform
- Dynamic NFTs showing progress

### 🤖 AI Integration
- Prompt engineering fundamentals
- AI-assisted development workflows
- Automated code review
- Smart contract generation

### 🔒 Security Focus
- Dedicated security module
- CTF challenges (Ethernaut, Damn Vulnerable DeFi)
- Audit training and certification
- Bug bounty participation

### 🏛️ Community Governance
- Token-weighted voting
- Progressive decentralization
- Transparent decision-making
- Community treasury management

### 💼 Career Development
- Portfolio-worthy projects
- Job board access
- Industry connections
- Grant funding opportunities

---

## Documentation

### Core Documentation
- [Governance Framework](./governance/governance-framework.md) - How VISE is governed
- [Token Utility](./utility/token-utility.md) - Economic model and token benefits

### Curriculum
- [Module 1: Prompt Engineering](./curriculum/module-1-prompt-engineering.md)
- [Module 2: Solidity Smart Contracts](./curriculum/module-2-solidity-smart-contracts.md)
- [Module 3: NFT Engineering](./curriculum/module-3-nft-engineering.md)
- [Module 4: Tokenomics](./curriculum/module-4-tokenomics.md)
- [Module 5: Privacy & Security](./curriculum/module-5-privacy-security.md)
- [Module 6: AI-Assisted DevOps](./curriculum/module-6-ai-assisted-devops.md)

### Projects
- [Sprint 1: AI Mini App](./sprints/sprint-1-ai-mini-app.md)
- [Sprint 2: NFT/Token Integration](./sprints/sprint-2-nft-token-integration.md)
- [Sprint 3: Full Web3 Deployment](./sprints/sprint-3-full-web3-deployment.md)

### Exercises
- [Exercise Overview](./exercises/README.md)
- [Module 1 Exercises](./exercises/module-1-exercises.md)
- [All Module Exercises](./exercises/all-modules-exercises.md)

---

## Technology Stack

### Smart Contracts
- Solidity 0.8+
- Hardhat / Foundry
- OpenZeppelin Contracts
- ERC-721 (Soulbound)
- ERC-20 (Governance)

### Frontend
- React / Next.js
- TypeScript
- Wagmi + RainbowKit
- TailwindCSS

### Backend
- Node.js
- PostgreSQL
- IPFS (NFT.Storage/Pinata)
- The Graph (Indexing)

### DevOps
- GitHub Actions
- Vercel / Railway
- Tenderly (Monitoring)
- Defender (Automation)

---

## Roadmap

### Phase 1: Foundation (Q1 2024)
- ✅ Complete curriculum development
- ✅ Governance framework design
- ✅ Token utility specification
- 🔄 Smart contract development
- 🔄 Platform MVP

### Phase 2: Launch (Q2 2024)
- Deploy achievement NFT contracts
- Launch VISE governance token
- Onboard first cohort of students
- Recruit mentor panel
- Establish governance processes

### Phase 3: Growth (Q3-Q4 2024)
- Scale to 1,000+ students
- Launch job board
- Establish partnerships
- Implement grant program
- Community governance activation

### Phase 4: Expansion (2025)
- Multi-chain expansion
- Corporate training programs
- Advanced specializations
- Global community events
- Full DAO transition

---

## Community

### Join the Conversation
- **Discord**: [Join VISE Community](#) _(coming soon)_
- **Twitter**: [@VISEedu](#) _(coming soon)_
- **Forum**: [discuss.vise.edu](#) _(coming soon)_
- **GitHub**: [Fused-Gaming/vise](https://github.com/Fused-Gaming/vise)

### Weekly Events
- **Office Hours**: Get help from mentors
- **Demo Days**: Showcase your projects
- **Security Workshops**: Learn auditing techniques
- **Governance Meetings**: Shape the platform

---

## Contributing

We welcome contributions from the community! Here's how you can help:

### Types of Contributions
- **Content**: Improve curriculum, add exercises, write tutorials
- **Code**: Build platform features, smart contracts, tools
- **Design**: UI/UX improvements, graphics, NFT artwork
- **Mentorship**: Review student work, provide guidance
- **Governance**: Participate in proposals and voting

### Contribution Process
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit with clear messages (`git commit -m 'Add amazing feature'`)
5. Push to your branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

### Contributor Recognition
- Contributor badges (on-chain)
- VISE token rewards
- Featured in community showcase
- Path to mentor/admin roles

[→ Read the full Contribution Guidelines](#) _(coming soon)_

---

## Frequently Asked Questions

### Is VISE free?
Core curriculum is free. Advanced features and premium content may require VISE tokens or fees.

### Are the achievement tokens transferable?
No. Achievement tokens are Soulbound NFTs (non-transferable) to prevent credential fraud.

### How long does it take to complete?
- Core modules: 6 weeks (full-time) to 12 weeks (part-time)
- Sprint projects: 6-10 additional weeks
- Total: 3-6 months depending on pace

### What if I fail an assessment?
You can retake assessments. Some restrictions may apply to prevent gaming the system.

### Can I skip modules?
No. The curriculum is sequential - each module builds on previous knowledge.

### What are the prerequisites?
- Module 1: None (beginner-friendly)
- Basic programming knowledge helpful but not required
- Modules 2-6: Previous module tokens required

### What jobs can I get after completing VISE?
- Smart Contract Developer
- Web3 Frontend Developer
- Security Auditor
- Tokenomics Designer
- NFT Engineer
- DevOps Engineer (Web3)
- And more!

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- OpenZeppelin for secure contract libraries
- Ethereum Foundation for blockchain infrastructure
- Anthropic & OpenAI for AI assistance
- All contributors and community members

---

## Support

Need help? Reach out:

- **Technical Issues**: [GitHub Issues](https://github.com/Fused-Gaming/vise/issues)
- **General Questions**: [Discord Community](#) _(coming soon)_
- **Partnerships**: partnerships@vise.edu _(coming soon)_
- **Press**: press@vise.edu _(coming soon)_

---

<div align="center">

**Built with ❤️ by the Web3 community, for the Web3 community**

[Get Started](./curriculum/module-1-prompt-engineering.md) | [Documentation](./governance/governance-framework.md) | [Community](#community)

</div>
