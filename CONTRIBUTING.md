# Contributing to VISE

Thank you for your interest in contributing to VISE (Verified in Skills: Exploits)! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Contribution Workflow](#contribution-workflow)
- [Development Guidelines](#development-guidelines)
- [Submitting Changes](#submitting-changes)
- [Review Process](#review-process)
- [Recognition](#recognition)

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- **Be respectful**: Treat all community members with respect and kindness
- **Be inclusive**: Welcome contributors of all backgrounds and skill levels
- **Be collaborative**: Work together to build the best educational platform
- **Be constructive**: Provide helpful feedback and accept it graciously
- **Be professional**: Keep discussions focused and productive

## How Can I Contribute?

There are many ways to contribute to VISE:

### 📚 Content Contributions

- **Curriculum**: Improve module content, add examples, clarify explanations
- **Exercises**: Create new practice exercises or improve existing ones
- **Demonstrations**: Develop hands-on coding demonstrations
- **Documentation**: Enhance README files, guides, and tutorials
- **Translations**: Help make VISE accessible in multiple languages

### 💻 Code Contributions

- **Smart Contracts**: Develop and improve achievement NFT contracts
- **Platform Features**: Build education platform functionality
- **Tools**: Create developer tools and automation scripts
- **Bug Fixes**: Identify and fix bugs in existing code
- **Testing**: Write tests to improve code coverage

### 🎨 Design Contributions

- **UI/UX**: Improve platform interface and user experience
- **Graphics**: Create visual assets, diagrams, and illustrations
- **NFT Artwork**: Design achievement token artwork
- **Branding**: Enhance brand identity and marketing materials

### 🤝 Community Contributions

- **Mentorship**: Review student work and provide guidance
- **Issue Triage**: Help organize and prioritize GitHub issues
- **Testing**: Test new features and report bugs
- **Governance**: Participate in proposals and voting
- **Support**: Answer questions in Discord and forums

## Getting Started

### Prerequisites

Before contributing, ensure you have:

- **Git**: For version control
- **GitHub Account**: To submit pull requests
- **Node.js 18+**: For JavaScript/TypeScript development
- **Foundry**: For smart contract development (optional)
- **Text Editor**: VS Code recommended with Solidity extensions

### Setup Your Development Environment

1. **Fork the Repository**
   
   Click the "Fork" button at the top right of the [VISE repository](https://github.com/Fused-Gaming/vise) to create your own copy.

2. **Clone Your Fork**

   ```bash
   git clone https://github.com/YOUR-USERNAME/vise.git
   cd vise
   ```

3. **Add Upstream Remote**

   ```bash
   git remote add upstream https://github.com/Fused-Gaming/vise.git
   ```

4. **Run Setup**

   ```bash
   make setup
   ```

5. **Configure Environment**

   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

6. **Verify Installation**

   ```bash
   make help
   make test
   ```

## Contribution Workflow

### 1. Find or Create an Issue

- **Browse Issues**: Check [GitHub Issues](https://github.com/Fused-Gaming/vise/issues) for open tasks
- **Good First Issues**: Look for issues labeled `good-first-issue` if you're new
- **Create New Issue**: If you have a new idea, create an issue to discuss it first
- **Get Assignment**: Comment on the issue to get it assigned to you

### 2. Create a Feature Branch

Always create a new branch for your work:

```bash
# Update your main branch
git checkout main
git pull upstream main

# Create a feature branch
git checkout -b feature/your-feature-name
```

**Branch Naming Conventions:**
- `feature/` - New features or enhancements
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `test/` - Test additions or improvements
- `refactor/` - Code refactoring

Examples:
- `feature/module-2-exercises`
- `fix/broken-link-in-readme`
- `docs/contributing-guide`

### 3. Make Your Changes

- **Follow Guidelines**: Adhere to coding standards and style guides
- **Write Tests**: Add tests for new functionality
- **Update Documentation**: Keep docs in sync with code changes
- **Commit Regularly**: Make small, focused commits

### 4. Commit Your Changes

Write clear, descriptive commit messages:

```bash
git add .
git commit -m "Add exercises for Module 2: Solidity Smart Contracts"
```

**Commit Message Guidelines:**
- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Keep first line under 50 characters
- Add detailed description if needed after a blank line
- Reference issue numbers when applicable

Examples:
```
Add Module 2 exercise set (#123)

- Foundation exercises covering Solidity basics
- Intermediate exercises for smart contract patterns
- Advanced exercises for security and optimization
- Integration exercises combining multiple concepts

Closes #123
```

### 5. Keep Your Branch Updated

Regularly sync with the upstream repository:

```bash
git fetch upstream
git rebase upstream/main
```

If there are conflicts, resolve them and continue:

```bash
# After resolving conflicts
git add .
git rebase --continue
```

### 6. Push Your Changes

```bash
git push origin feature/your-feature-name
```

If you rebased and need to force push:

```bash
git push --force-with-lease origin feature/your-feature-name
```

### 7. Open a Pull Request

1. Go to your fork on GitHub
2. Click "Compare & pull request"
3. Fill out the PR template:
   - **Title**: Clear, descriptive title
   - **Description**: What changes were made and why
   - **Issue Reference**: Link to related issues
   - **Testing**: How you tested the changes
   - **Screenshots**: For UI changes
4. Submit the pull request

## Development Guidelines

### Content Standards

#### Curriculum Content

- **Accuracy**: Ensure technical accuracy of all information
- **Clarity**: Write in clear, accessible language
- **Structure**: Follow the established module format
- **Examples**: Provide practical, working examples
- **References**: Cite sources and external resources

#### Exercise Creation

Follow the structure established in Module 1:

- **Foundation Exercises**: Basic skills (3-4 exercises)
- **Intermediate Exercises**: Practical scenarios (3-4 exercises)
- **Advanced Exercises**: Deep understanding (3-4 exercises)
- **Integration Exercises**: Combining concepts (3-4 exercises)

Each exercise should include:
- **Objective**: What the exercise teaches
- **Tasks**: Clear, numbered steps
- **Success Criteria**: How to verify completion

### Code Standards

#### Smart Contracts

- **Solidity Version**: Use 0.8.20 or later
- **Style Guide**: Follow [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)
- **Security**: Follow security best practices
- **Comments**: Use NatSpec documentation
- **Testing**: Achieve >90% code coverage
- **Gas Optimization**: Optimize for reasonable gas costs

Example:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title AchievementToken
 * @notice Soulbound NFT for VISE achievements
 * @dev Implements ERC-721 with transfer restrictions
 */
contract AchievementToken {
    // Contract implementation
}
```

#### JavaScript/TypeScript

- **Style**: Follow existing code style
- **Linting**: Code must pass ESLint
- **Types**: Use TypeScript for type safety
- **Testing**: Write unit tests for new code
- **Comments**: Document complex logic

### Documentation Standards

- **Markdown**: Use proper Markdown formatting
- **Links**: Verify all links work
- **Code Blocks**: Use appropriate syntax highlighting
- **Images**: Optimize images for web (< 500KB)
- **Spelling**: Check spelling and grammar

### Testing Requirements

#### Before Submitting

- **Run Tests**: `make test`
- **Check Linting**: Ensure code passes linters
- **Build**: Verify project builds without errors
- **Manual Testing**: Test your changes manually
- **Documentation**: Update relevant documentation

#### Smart Contract Testing

```bash
# Compile contracts
make compile-contracts

# Run tests
make test-contracts

# Check coverage
make coverage-contracts
```

## Submitting Changes

### Pull Request Checklist

Before submitting your PR, ensure:

- [ ] Code follows project style guidelines
- [ ] All tests pass locally
- [ ] New code includes appropriate tests
- [ ] Documentation is updated
- [ ] Commit messages are clear and descriptive
- [ ] Branch is up to date with main
- [ ] No merge conflicts
- [ ] PR description is complete and clear
- [ ] Related issues are referenced
- [ ] You've reviewed your own code

### Pull Request Template

Your PR should include:

1. **Summary**: Brief description of changes
2. **Motivation**: Why this change is needed
3. **Changes**: Detailed list of modifications
4. **Testing**: How changes were tested
5. **Screenshots**: For UI changes
6. **Breaking Changes**: Any breaking changes
7. **Related Issues**: Links to related issues

## Review Process

### What to Expect

1. **Initial Review**: Maintainers review within 2-3 business days
2. **Feedback**: You may receive requests for changes
3. **Discussion**: Be open to discussion and feedback
4. **Iterations**: Make requested changes and push updates
5. **Approval**: PR approved once all feedback is addressed
6. **Merge**: Maintainer merges your PR

### Responding to Feedback

- **Be Receptive**: Consider all feedback constructively
- **Ask Questions**: If feedback is unclear, ask for clarification
- **Make Changes**: Address feedback promptly
- **Update PR**: Push changes to the same branch
- **Discuss**: If you disagree, explain your reasoning respectfully

### After Merge

- **Celebrate**: Your contribution is now part of VISE! 🎉
- **Clean Up**: Delete your feature branch
- **Stay Involved**: Look for more ways to contribute

## Recognition

Contributors are recognized in several ways:

### Contributor Badges

- **First Contribution**: On-chain badge for first merged PR
- **Regular Contributor**: 5+ merged PRs
- **Core Contributor**: 20+ merged PRs
- **Domain Expert**: Significant contributions in specific area

### VISE Token Rewards

Quality contributions may earn VISE tokens:

- **Minor Contribution**: Documentation fixes, small improvements
- **Major Contribution**: New features, substantial content
- **Critical Contribution**: Major features, security fixes

### Community Recognition

- **Contributors Page**: Featured on VISE website
- **Showcase**: Projects highlighted in community showcases
- **Mentor Path**: Path to becoming a VISE mentor
- **Admin Roles**: Opportunity for leadership positions

## Getting Help

### Resources

- **Documentation**: Check [README](./README.md) and docs
- **Issues**: Search existing issues
- **Discussions**: GitHub Discussions for questions
- **Discord**: Join VISE Discord for community support
- **Office Hours**: Weekly community office hours

### Asking Questions

When asking for help:

1. **Search First**: Check if question was already answered
2. **Be Specific**: Provide context and details
3. **Show Work**: Explain what you've tried
4. **Be Patient**: Maintainers are volunteers
5. **Be Grateful**: Thank those who help you

## Quick Reference

### Common Commands

```bash
# Setup
make setup                  # Complete setup
make help                   # Show all commands

# Development
make test                   # Run all tests
make test-contracts         # Test smart contracts
make build                  # Build project

# Git Workflow
git checkout main           # Switch to main branch
git pull upstream main      # Update from upstream
git checkout -b feature/X   # Create feature branch
git add .                   # Stage changes
git commit -m "Message"     # Commit changes
git push origin feature/X   # Push to your fork

# Sync with upstream
git fetch upstream
git rebase upstream/main
git push --force-with-lease origin feature/X
```

### File Structure

```
vise/
├── curriculum/           # Module curriculum content
├── exercises/           # Practice exercises
├── demonstrations/      # Code demonstrations
├── sprints/            # Sprint project guides
├── governance/         # Governance documentation
├── infrastructure/     # DevOps documentation
├── scripts/            # Automation scripts
└── contracts/          # Smart contracts (if applicable)
```

## Types of Contributions Needed

Current priorities (check issues for latest):

- [ ] Exercise files for Modules 2-6
- [ ] Code demonstrations for all modules
- [ ] Smart contract implementations
- [ ] Platform frontend development
- [ ] Testing infrastructure
- [ ] Documentation improvements
- [ ] Tutorial videos and walkthroughs

## Contact

- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For questions and ideas
- **Discord**: For community chat and support
- **Email**: For private inquiries (coming soon)

---

**Thank you for contributing to VISE!** Your efforts help make Web3 education accessible to everyone. 🚀

---

## Contributors

This guide was created with contributions from:
- **@jmenichole** - Repository owner and VISE project lead

*Last Updated: 2025-11-24*
