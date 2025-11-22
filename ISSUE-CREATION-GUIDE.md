# VISE Curriculum Issue Creation Guide

## Overview

This document serves as the master index for creating GitHub issues for all VISE curriculum modules. Each module has a dedicated guide with detailed instructions for creating lesson issues that match the structure of Module 1.

## Module Structure

The VISE curriculum consists of 6 modules, each with 7 days of content (lessons). The lesson numbering is sequential across all modules:

| Module | Lessons | Token Earned | Prerequisite |
|--------|---------|--------------|--------------|
| Module 1: Prompt Engineering | Lessons 1-6 | PE-1 | None |
| Module 2: Solidity Smart Contracts | Lessons 7-13 | SOL-1 | PE-1 |
| Module 3: NFT Engineering | Lessons 14-20 | NFT-1 | SOL-1 |
| Module 4: Tokenomics | Lessons 21-27 | TOK-1 | NFT-1 |
| Module 5: Privacy & Security | Lessons 28-34 | PRIV-1 | TOK-1 |
| Module 6: AI-Assisted DevOps | Lessons 35-41 | DEV-1 | PRIV-1 |

## Issue Creation Guides

Detailed guides for each module are available in the following files:

- **Module 2**: [module-2-issues-guide.md](./module-2-issues-guide.md) - Lessons 7-13
- **Module 3**: [module-3-issues-guide.md](./module-3-issues-guide.md) - Lessons 14-20
- **Module 4**: [module-4-issues-guide.md](./module-4-issues-guide.md) - Lessons 21-27
- **Module 5**: [module-5-issues-guide.md](./module-5-issues-guide.md) - Lessons 28-34
- **Module 6**: [module-6-issues-guide.md](./module-6-issues-guide.md) - Lessons 35-41

## Issue Structure Template

Each lesson issue follows this consistent format:

### Required Fields

- **Title**: `Lesson X: — [Topic Name]`
- **Milestone**: Module X: [Module Name]
- **Project**: V.I.S.E. VLN-Certifications
- **Project Status**: Curriculum
- **Blocked by**: Previous lesson or parent module issue
- **Blocks**: Next lesson or next module

### Description Format

```markdown
### [Topic Name]

**Learning Objectives:**

- ✔️ [Objective 1]
- ✔️ [Objective 2]
- ✔️ [Objective 3]
...
```

### Assessment Lessons (Final lesson of each module)

Assessment lessons (Lessons 6, 13, 20, 27, 34, 41) have a different format:

```markdown
### Assessment & [TOKEN]-1 Token Issuance

**Assessment Components:**

- ✔️ [Component 1 with weight]
- ✔️ [Component 2 with weight]
- ✔️ [Component 3 with weight]

**Project Requirements:**

- ✔️ [Requirement 1]
- ✔️ [Requirement 2]
...

**Passing Criteria:**

[Criteria description]

**Token Issuance:**

[Token details and what it unlocks]
```

## Parent Module Issues

Each module has a parent issue that tracks the overall module:

- **Issue #1**: 🧪Module 1 (Prompt Engineering)
- **Issue #10**: 🧪Module 2 (Solidity Smart Contracts)
- **Issue #11**: 🧪Module 3 (NFT Engineering)
- **Issue #12**: 🧪Module 4 (Tokenomics)
- **Issue #13**: 🧪Module 5 (Privacy & Security)
- **Issue #14**: 🧪Module 6 (AI-Assisted DevOps)

Each parent issue should be updated with:
- Learning objectives list
- Milestone assignment
- Project assignment (V.I.S.E. VLN-Certifications)
- Blocking relationships (blocks next module, blocked by previous module)
- Label: "backlog"

## Blocking Relationships

The curriculum follows a progressive structure:

1. Each lesson blocks the next lesson in sequence
2. The last lesson of a module blocks the first lesson of the next module
3. Parent module issues block each other in sequence
4. Module 1 parent issue (#1) blocks Module 2 parent issue (#10)
5. Each module's first lesson is blocked by its parent module issue

## Creation Order

For each module, create issues in this order:

1. Update the parent module issue
2. Create Lesson issues in sequential order (first lesson to last)
3. Set up blocking relationships as you create each issue

## Quick Reference: All Lessons

### Module 1: Prompt Engineering (Lessons 1-6)
Already created. See existing issues #2, #4, #5, #6, #7, #8, #9.

### Module 2: Solidity Smart Contracts (Lessons 7-13)
- Lesson 7: Blockchain & Ethereum Fundamentals
- Lesson 8: Solidity Basics
- Lesson 9: Intermediate Solidity
- Lesson 10: Advanced Patterns & Security
- Lesson 11: Testing & Development Workflow
- Lesson 12: AI-Assisted Smart Contract Development
- Lesson 13: Assessment & SOL-1 Token Issuance

### Module 3: NFT Engineering (Lessons 14-20)
- Lesson 14: NFT Fundamentals
- Lesson 15: ERC-721 Implementation
- Lesson 16: Advanced NFT Standards & Features
- Lesson 17: Minting Mechanisms & Economics
- Lesson 18: NFT Metadata & Art Generation
- Lesson 19: Integration & Marketplaces
- Lesson 20: Assessment & NFT-1 Token Issuance

### Module 4: Tokenomics (Lessons 21-27)
- Lesson 21: Token Economics Fundamentals
- Lesson 22: ERC-20 Implementation & Extensions
- Lesson 23: Governance Mechanisms
- Lesson 24: Staking & Rewards Systems
- Lesson 25: Advanced Tokenomics Patterns
- Lesson 26: Token Launch & Distribution
- Lesson 27: Assessment & TOK-1 Token Issuance

### Module 5: Privacy & Security (Lessons 28-34)
- Lesson 28: Smart Contract Security Fundamentals
- Lesson 29: Advanced Security Vulnerabilities
- Lesson 30: Security Auditing & Testing
- Lesson 31: Cryptography & Privacy Technologies
- Lesson 32: Zero-Knowledge Applications
- Lesson 33: Operational Security & Best Practices
- Lesson 34: Assessment & PRIV-1 Token Issuance

### Module 6: AI-Assisted DevOps (Lessons 35-41)
- Lesson 35: DevOps Fundamentals for Web3
- Lesson 36: Smart Contract Deployment Automation
- Lesson 37: AI-Powered Development Tools
- Lesson 38: Testing & Quality Assurance
- Lesson 39: Monitoring & Observability
- Lesson 40: Infrastructure & Scaling
- Lesson 41: Assessment & DEV-1 Token Issuance

## GitHub Labels

Use these labels consistently:
- **backlog**: For parent module issues
- Additional labels can be added as needed for organization

## Milestones

Ensure these milestones exist in GitHub:
- Module 1: Prompt Engineering
- Module 2: Solidity Smart Contracts
- Module 3: NFT Engineering
- Module 4: Tokenomics
- Module 5: Privacy & Security
- Module 6: AI-Assisted DevOps

## Project Board

All issues should be added to:
- **Project**: V.I.S.E. VLN-Certifications
- **Status**:
  - "Educational Milestone" for parent module issues
  - "Curriculum" for lesson issues

## Tips for Issue Creation

1. **Use the guides**: Each module guide has copy-paste ready content
2. **Check blocking**: Ensure each issue correctly blocks/is blocked by the right issues
3. **Consistent formatting**: Use the ✔️ checkmark for all learning objectives
4. **Verify numbering**: Double-check lesson numbers are sequential
5. **Test one first**: Create one issue first to verify format, then create the rest
6. **Batch similar actions**: Create all issues for a module, then set up all blocking relationships

## Automation Possibilities

Consider using GitHub CLI or API to automate issue creation:

```bash
# Example using gh CLI
gh issue create --title "Lesson 7: — Blockchain & Ethereum Fundamentals" \
  --body-file lesson-7-body.md \
  --milestone "Module 2: Solidity Smart Contracts" \
  --project "V.I.S.E. VLN-Certifications"
```

## Verification Checklist

After creating issues for a module, verify:

- [ ] All 7 lesson issues created
- [ ] Parent module issue updated
- [ ] All issues have correct milestone
- [ ] All issues added to V.I.S.E. VLN-Certifications project
- [ ] Blocking relationships set up correctly
- [ ] Lesson numbers are sequential
- [ ] Learning objectives formatted consistently
- [ ] Assessment lesson includes all required sections

## Support

For questions or issues with this guide, refer to:
- [Module curriculum files](./curriculum/)
- [Existing Module 1 issues](https://github.com/Fused-Gaming/vise/issues) for reference
- VISE Discord for community support
