# Module 6: AI-Assisted DevOps - Exercises

## Foundation Exercises

### Exercise 6.1: GitHub Actions CI/CD Pipeline
**Objective**: Set up automated testing and deployment

**Tasks**:
1. Create a GitHub repository with a smart contract project
2. Set up GitHub Actions workflow that:
   - Runs on push and pull request
   - Installs dependencies
   - Compiles contracts
   - Runs tests
   - Generates coverage report
3. Add status badges to README
4. Configure workflow for multiple Solidity versions
5. Add deployment workflow for testnet

**Success Criteria**:
- Workflow runs automatically on commits
- All tests must pass for merge
- Coverage report is generated
- Multiple Solidity versions tested
- Testnet deployment works
- Status badges reflect current state

### Exercise 6.2: Smart Contract Testing Framework
**Objective**: Build comprehensive test suite

**Tasks**:
1. Choose a testing framework (Hardhat or Foundry)
2. Create test structure:
   - Unit tests (individual functions)
   - Integration tests (contract interactions)
   - End-to-end tests (full workflows)
3. Implement different test types:
   - Happy path tests
   - Edge case tests
   - Failure case tests
   - Gas usage tests
4. Achieve >95% code coverage
5. Set up coverage reporting

**Success Criteria**:
- Tests are well-organized
- All function paths tested
- Edge cases covered
- Coverage exceeds 95%
- Tests run quickly (<5 minutes)
- Coverage report is clear

### Exercise 6.3: Environment Management
**Objective**: Manage multiple deployment environments

**Tasks**:
1. Set up three environments:
   - Local (Hardhat network)
   - Testnet (Sepolia/Mumbai)
   - Mainnet (configuration only)
2. Create environment-specific configs:
   - Network settings
   - Contract addresses
   - API keys
   - Gas settings
3. Implement deployment scripts that:
   - Work across environments
   - Save deployment addresses
   - Verify contracts automatically
4. Use .env files securely
5. Document environment setup

**Success Criteria**:
- Each environment is properly configured
- Switching environments is easy
- Secrets are managed securely
- Deployment scripts are environment-aware
- Verification works automatically
- Documentation is complete

### Exercise 6.4: Version Control Best Practices
**Objective**: Master Git workflow for teams

**Tasks**:
1. Set up repository with branching strategy:
   - main (production)
   - develop (integration)
   - feature/* (features)
   - hotfix/* (urgent fixes)
2. Create comprehensive .gitignore:
   - Dependencies (node_modules)
   - Environment files (.env)
   - Build artifacts
   - IDE files
3. Write good commit messages
4. Use pull request templates
5. Set up branch protection rules

**Success Criteria**:
- Branching strategy is clear
- .gitignore prevents secret commits
- Commits are well-documented
- PRs follow template
- Branch protection enforced
- History is clean and useful

## Intermediate Exercises

### Exercise 6.5: AI-Assisted Code Generation
**Objective**: Use AI effectively for smart contract development

**Tasks**:
1. Use GitHub Copilot or similar AI tool to:
   - Generate boilerplate contracts
   - Write test cases
   - Create documentation
   - Suggest optimizations
2. Document AI-assisted workflow:
   - What prompts work well
   - What AI struggles with
   - When to use AI vs manual coding
3. Create a library of useful AI prompts for:
   - Common contract patterns
   - Test generation
   - Documentation writing
4. Evaluate code quality from AI
5. Establish AI review checklist

**Success Criteria**:
- AI accelerates development
- Generated code is secure
- Prompts are well-documented
- Quality checklist catches issues
- Workflow is efficient
- Understanding when AI helps vs hinders

### Exercise 6.6: Automated Security Scanning
**Objective**: Integrate security tools into CI/CD

**Tasks**:
1. Add security tools to CI pipeline:
   - Slither (static analysis)
   - Mythril (symbolic execution)
   - Echidna (fuzzing)
2. Configure each tool:
   - Set severity thresholds
   - Exclude false positives
   - Create custom detectors
3. Make security checks mandatory:
   - Block merge on critical findings
   - Require manual review for high findings
   - Auto-approve for clean scans
4. Generate security reports
5. Set up alerting for new vulnerabilities

**Success Criteria**:
- All tools run automatically
- Configuration reduces false positives
- Critical issues block deployment
- Reports are clear and actionable
- Alerts reach right people
- Security is enforced, not optional

### Exercise 6.7: Multi-Network Deployment Automation
**Objective**: Deploy to multiple chains efficiently

**Tasks**:
1. Create deployment system for:
   - Ethereum (Mainnet, Sepolia)
   - Polygon (Mainnet, Mumbai)
   - Arbitrum (Mainnet, Sepolia)
   - Optimism (Mainnet, Sepolia)
2. Implement:
   - Network detection
   - Gas price optimization
   - Deterministic deployment (CREATE2)
   - Address verification across chains
3. Add deployment verification:
   - Automated Etherscan verification
   - Cross-chain address consistency
   - Configuration validation
4. Create deployment dashboard
5. Document deployment process

**Success Criteria**:
- Deploys to all networks work
- Same addresses across chains (if using CREATE2)
- Verification is automatic
- Gas is optimized per network
- Dashboard shows deployment status
- Process is documented

### Exercise 6.8: Contract Upgrade Automation
**Objective**: Automate upgradeable contract deployments

**Tasks**:
1. Set up upgradeable contract system:
   - Proxy pattern (UUPS or Transparent)
   - Implementation contract
   - ProxyAdmin
2. Create upgrade workflow:
   - Deploy new implementation
   - Test in forked environment
   - Propose upgrade via governance
   - Execute upgrade
   - Verify upgrade success
3. Implement safety checks:
   - Storage layout validation
   - Initialization check
   - Rollback capability
4. Add upgrade testing to CI/CD
5. Document upgrade procedures

**Success Criteria**:
- Upgrade process is automated
- Safety checks prevent errors
- Storage collision is prevented
- Rollback works if needed
- Tests verify upgrade safety
- Documentation is clear

## Advanced Exercises

### Exercise 6.9: Infrastructure as Code
**Objective**: Define infrastructure programmatically

**Tasks**:
1. Use IaC tools (Terraform, Pulumi, or CDK) to manage:
   - RPC nodes (Alchemy, Infura)
   - IPFS pinning services
   - Monitoring services (Tenderly)
   - Subgraph indexing
2. Create infrastructure for:
   - Development environment
   - Staging environment
   - Production environment
3. Implement:
   - Resource provisioning
   - Configuration management
   - Secret management (Vault, AWS Secrets)
   - Cost monitoring
4. Version control all infrastructure
5. Set up disaster recovery

**Success Criteria**:
- All infrastructure is code
- Environments are reproducible
- Secrets are secure
- Costs are monitored
- Recovery procedures work
- Documentation is complete

### Exercise 6.10: Monitoring and Observability
**Objective**: Implement comprehensive monitoring

**Tasks**:
1. Set up monitoring for:
   - Contract events (all important events)
   - Transaction status
   - Gas prices
   - Contract state changes
   - Error rates
2. Use monitoring tools:
   - Tenderly (transaction monitoring)
   - The Graph (event indexing)
   - OpenZeppelin Defender (automation)
   - Custom dashboards (Grafana)
3. Implement alerting:
   - Critical events (admin actions)
   - Error conditions
   - Unusual activity
   - Gas price spikes
4. Create dashboards for:
   - Protocol health
   - User activity
   - Financial metrics
5. Set up logging and tracing

**Success Criteria**:
- All important events monitored
- Alerts reach right people promptly
- Dashboards are informative
- Historical data is queryable
- Performance is tracked
- System is observable

### Exercise 6.11: AI-Powered Code Review
**Objective**: Use AI for code review and optimization

**Tasks**:
1. Set up AI code review system:
   - Automated PR review bot
   - Security vulnerability detection
   - Gas optimization suggestions
   - Code quality metrics
2. Integrate with GitHub:
   - Comment on PRs automatically
   - Suggest improvements
   - Flag security issues
   - Check style compliance
3. Create custom rules for:
   - Solidity best practices
   - Project-specific patterns
   - Security requirements
4. Train AI on codebase patterns
5. Measure review effectiveness

**Success Criteria**:
- AI reviews all PRs
- Security issues are flagged
- Suggestions are helpful
- False positives are minimal
- Review quality improves over time
- Human review is enhanced, not replaced

### Exercise 6.12: Chaos Engineering for Smart Contracts
**Objective**: Test system resilience

**Tasks**:
1. Design chaos experiments:
   - High gas price scenarios
   - Network congestion
   - Oracle failures
   - Flash loan attacks
   - Governance attacks
2. Implement chaos testing:
   - Use forked mainnet
   - Simulate attack scenarios
   - Test circuit breakers
   - Verify recovery procedures
3. Create automated chaos tests
4. Document failure modes
5. Improve system resilience based on findings

**Success Criteria**:
- Experiments are realistic
- Weaknesses are identified
- Circuit breakers work
- Recovery is automatic where possible
- Documentation is comprehensive
- System is more resilient

## Integration Exercises

### Exercise 6.13: Complete DevOps Pipeline
**Objective**: Build end-to-end DevOps system

**Tasks**:
1. Create comprehensive pipeline:
   - Code: Version control (Git)
   - Build: Compilation and testing (CI)
   - Test: Automated testing suite
   - Security: Automated scanning
   - Deploy: Multi-environment deployment
   - Monitor: Observability and alerting
   - Operate: Incident response
2. Implement GitOps workflow:
   - All changes via Git
   - Automated deployments
   - Rollback capability
   - Audit trail
3. Add quality gates:
   - Code coverage threshold
   - Security scan pass
   - Gas optimization check
   - Manual approval for production
4. Create runbooks for operations
5. Document entire system

**Success Criteria**:
- Pipeline is fully automated
- Quality is enforced
- Deployments are reliable
- Monitoring is comprehensive
- Operations are documented
- System is production-ready

### Exercise 6.14: AI-Powered Development Environment
**Objective**: Optimize development workflow with AI

**Tasks**:
1. Set up AI-enhanced development:
   - AI code completion (Copilot/Cursor)
   - AI-powered debugging
   - Automated documentation generation
   - Smart test generation
   - Gas optimization suggestions
2. Create AI assistant for:
   - Contract architecture review
   - Security pattern suggestions
   - Best practice recommendations
   - Code refactoring
3. Integrate AI into:
   - IDE
   - CI/CD pipeline
   - Code review process
   - Documentation workflow
4. Measure productivity impact
5. Share best practices

**Success Criteria**:
- AI tools are seamlessly integrated
- Productivity measurably improves
- Code quality increases
- Documentation is better
- Team adopts AI effectively
- Best practices are documented

### Exercise 6.15: Production Deployment System
**Objective**: Deploy and maintain production smart contracts

**Tasks**:
1. Plan production deployment:
   - Security audit (third-party)
   - Economic modeling
   - Risk assessment
   - Insurance consideration
   - Launch strategy
2. Implement deployment:
   - Gradual rollout
   - Liquidity provision
   - Oracle setup
   - Monitoring activation
   - Emergency procedures
3. Post-deployment:
   - User onboarding
   - Community communication
   - Performance monitoring
   - Incident response
   - Continuous improvement
4. Create operations manual
5. Conduct post-mortem reviews

**Success Criteria**:
- Deployment plan is comprehensive
- Risk mitigation is thorough
- Launch executes smoothly
- Monitoring catches issues early
- Communication is effective
- Operations are sustainable

## Practical Application

### Exercise 6.16: Open Source Project Contribution
**Objective**: Contribute to a real open source project

**Tasks**:
1. Find an open source Web3 project
2. Set up development environment
3. Identify improvement opportunities:
   - Bug fixes
   - Feature additions
   - Documentation improvements
   - Test coverage
4. Submit quality contributions:
   - Fork repository
   - Create feature branch
   - Implement changes
   - Write tests
   - Submit pull request
5. Engage with maintainers
6. Document contribution process

**Success Criteria**:
- At least 2 PRs submitted
- Contributions follow project guidelines
- Tests are included
- Documentation is updated
- Code review feedback is addressed
- At least 1 PR is merged

### Exercise 6.17: DevOps Documentation Portfolio
**Objective**: Create comprehensive DevOps documentation

**Task**:
Build a documentation portfolio:
1. Technical documentation:
   - Architecture diagrams
   - Deployment procedures
   - API documentation
   - Configuration guides
2. Operational documentation:
   - Runbooks for common tasks
   - Incident response procedures
   - Monitoring and alerting guides
   - Disaster recovery plans
3. Developer documentation:
   - Getting started guide
   - Development workflow
   - Testing guidelines
   - Contribution guide
4. Use documentation tools:
   - VitePress/Docusaurus
   - Mermaid for diagrams
   - API docs generators
5. Make documentation discoverable and searchable

**Success Criteria**:
- Documentation is comprehensive
- All aspects are covered
- Diagrams clarify complex topics
- Documentation is easy to navigate
- Content is up-to-date
- Documentation is actually useful

### Exercise 6.18: Platform Reliability Engineering
**Objective**: Ensure high availability and reliability

**Task**:
Implement SRE practices for Web3:
1. Define SLOs (Service Level Objectives):
   - Uptime targets
   - Transaction success rate
   - Response time
2. Implement SLI (Service Level Indicators):
   - Monitoring metrics
   - Alerting thresholds
   - Performance baselines
3. Create error budgets:
   - Acceptable downtime
   - Deployment frequency
   - Change management
4. Build reliability:
   - Redundancy
   - Fallback mechanisms
   - Circuit breakers
   - Rate limiting
5. Incident management:
   - On-call rotation
   - Escalation procedures
   - Post-incident reviews
   - Continuous improvement

**Success Criteria**:
- SLOs are realistic and monitored
- SLIs provide visibility
- Error budgets guide decisions
- System meets reliability targets
- Incidents are handled professionally
- Learning from incidents improves system

## Bonus Challenges

### Challenge 6.1: One-Click Deployment
Create a system that deploys entire protocol with single command to any supported network.

### Challenge 6.2: AI DevOps Agent
Build an AI agent that can perform DevOps tasks autonomously (deployment, monitoring, incident response).

### Challenge 6.3: Zero-Downtime Upgrades
Implement upgrade system that maintains service during deployment.

### Challenge 6.4: Multi-Sig Deployment
Create deployment system that requires multi-sig approval at each stage.

## Assessment Preparation

Complete these to prepare for your DEV-1 assessment:

1. **Pipeline Portfolio**: Document 3 different CI/CD pipelines you've built
2. **Deployment Automation**: Create scripts for full protocol deployment
3. **Monitoring Dashboard**: Build comprehensive monitoring system
4. **Operations Manual**: Write complete ops guide for a protocol
5. **Incident Response**: Document handling of at least one incident
6. **Presentation**: Present on "DevOps Best Practices for Web3"
7. **Tool Mastery**: Demonstrate proficiency in 5+ DevOps tools

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Hardhat Documentation](https://hardhat.org/docs)
- [Foundry Book](https://book.getfoundry.sh/)
- [OpenZeppelin Defender](https://docs.openzeppelin.com/defender/)
- [Tenderly Documentation](https://docs.tenderly.co/)
- [The Graph Documentation](https://thegraph.com/docs/)
- [Terraform for Web3](https://www.terraform.io/)

## Tools to Master

1. **Development**:
   - Hardhat / Foundry
   - Remix IDE
   - VS Code + Extensions

2. **Testing**:
   - Mocha/Chai
   - Foundry tests
   - Echidna (fuzzing)

3. **CI/CD**:
   - GitHub Actions
   - GitLab CI
   - CircleCI

4. **Security**:
   - Slither
   - Mythril
   - Certora

5. **Monitoring**:
   - Tenderly
   - The Graph
   - OpenZeppelin Defender
   - Grafana

6. **Infrastructure**:
   - Terraform
   - Docker
   - Kubernetes (for supporting services)

7. **AI Tools**:
   - GitHub Copilot
   - ChatGPT/Claude
   - Cursor

## Tips for Success

1. **Automate Everything**: If you do it twice, automate it
2. **Monitor Everything**: You can't fix what you can't see
3. **Test in Production (Safely)**: Use testnets extensively
4. **Document as You Go**: Future you will thank present you
5. **Use AI Wisely**: Verify AI-generated code thoroughly
6. **Security First**: DevOps doesn't mean moving fast and breaking things
7. **Keep It Simple**: Complex systems fail in complex ways
8. **Learn from Incidents**: Every incident is a learning opportunity
9. **Collaborate**: DevOps is about teamwork
10. **Stay Current**: Tools and practices evolve rapidly

---

DevOps for Web3 requires both traditional DevOps skills and blockchain-specific knowledge. Master both! 🚀

---

**Exercise Author**: @jmenichole
