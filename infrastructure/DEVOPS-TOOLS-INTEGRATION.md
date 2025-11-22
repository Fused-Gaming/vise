# Integrating Fused-Gaming/DevOps Tools into VISE

**Source Repository:** https://github.com/Fused-Gaming/DevOps
**Integration Date:** 2025-11-22
**Purpose:** Leverage existing DevOps infrastructure and tools for VISE project

## Overview

The Fused-Gaming/DevOps repository contains a comprehensive set of DevOps tools, scripts, and workflows that can significantly accelerate VISE's infrastructure setup. This document catalogs the most valuable resources and provides integration instructions.

## High-Value Assets to Commandeer

### 1. Makefile (★★★★★)

**Location:** `/Makefile`

**What it provides:**
- Beautiful CLI interface with colors and progress bars
- Common DevOps commands (setup, test, build, deploy, clean)
- SEO optimization automation
- Usage tracking
- Status reporting

**How to integrate:**

```bash
# Copy to VISE repository
cp /path/to/Fused-Gaming-DevOps/Makefile /path/to/vise/Makefile

# Customize for VISE
# Update project-specific commands
# Add blockchain-specific tasks (deploy contracts, etc.)
```

**Recommended VISE additions:**

```makefile
## Smart Contract Operations
deploy-contracts:
	@echo "$(BLUE)$(ARROW) Deploying smart contracts...$(NC)"
	cd contracts && npx hardhat deploy --network sepolia
	@echo "$(GREEN)$(CHECK) Contracts deployed$(NC)"

verify-contracts:
	@echo "$(BLUE)$(ARROW) Verifying contracts on Etherscan...$(NC)"
	cd contracts && npx hardhat verify --network sepolia
	@echo "$(GREEN)$(CHECK) Contracts verified$(NC)"

mint-test-nft:
	@echo "$(BLUE)$(ARROW) Minting test achievement NFT...$(NC)"
	cd contracts && npx hardhat run scripts/mint-achievement.js --network sepolia
	@echo "$(GREEN)$(CHECK) Test NFT minted$(NC)"
```

---

### 2. CI/CD Enhanced Workflow (★★★★★)

**Location:** `/.github/workflows/ci-cd-enhanced.yml`

**What it provides:**
- Security scanning for exposed secrets
- npm audit for vulnerabilities
- Automated testing
- Build verification
- Job summaries in GitHub Actions

**Integration steps:**

1. **Copy the workflow:**
```bash
mkdir -p .github/workflows
cp /path/to/DevOps/.github/workflows/ci-cd-enhanced.yml .github/workflows/
```

2. **Customize for VISE:**

```yaml
# Add smart contract compilation job
smart-contracts:
  name: 🔗 Smart Contract Compilation & Testing
  runs-on: ubuntu-latest
  steps:
    - name: 📥 Checkout code
      uses: actions/checkout@v4

    - name: 📦 Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18.x'

    - name: 📥 Install Foundry
      uses: foundry-rs/foundry-toolchain@v1

    - name: 🔨 Compile contracts
      run: |
        cd contracts
        forge build

    - name: 🧪 Run contract tests
      run: |
        cd contracts
        forge test -vvv

    - name: 📊 Generate coverage
      run: |
        cd contracts
        forge coverage

    - name: 🔍 Slither static analysis
      run: |
        pip install slither-analyzer
        cd contracts
        slither . || true
```

---

### 3. Budget Alerts Script (★★★★)

**Location:** `/scripts/budget-alerts.sh`

**What it provides:**
- Budget monitoring for API usage (Claude, Alchemy, etc.)
- Alert thresholds (warning, critical)
- Usage tracking across periods (daily, weekly, monthly)
- Logging

**Integration:**

```bash
# Copy script
mkdir -p scripts
cp /path/to/DevOps/scripts/budget-alerts.sh scripts/

# Create VISE-specific config
cat > scripts/config-budget.json << EOF
{
  "budget": {
    "daily": 10.00,
    "weekly": 50.00,
    "monthly": 200.00,
    "quarterly": 500.00
  },
  "thresholds": {
    "warning": 75,
    "critical": 90
  },
  "services": {
    "alchemy_rpc": {
      "budget": 50.00,
      "cost_per_call": 0.0001
    },
    "pinata_ipfs": {
      "budget": 20.00,
      "monthly_fixed": 20.00
    },
    "sendgrid_email": {
      "budget": 15.00,
      "cost_per_email": 0.001
    }
  }
}
EOF

# Add to crontab for daily checks
# crontab -e
# 0 9 * * * /path/to/vise/scripts/budget-alerts.sh
```

---

### 4. Git Hooks Setup (★★★★)

**Location:** `/scripts/setup-git-hooks.sh`

**What it provides:**
- Pre-commit hooks for code quality
- Commit message linting
- Usage tracking
- Automated tests before commit

**Integration:**

```bash
# Copy script
cp /path/to/DevOps/scripts/setup-git-hooks.sh scripts/

# Run setup
chmod +x scripts/setup-git-hooks.sh
./scripts/setup-git-hooks.sh

# Create VISE-specific pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

echo "Running pre-commit checks..."

# Check for .env files
if git diff --cached --name-only | grep -q "\.env$"; then
    echo "ERROR: Attempting to commit .env file!"
    echo "Please remove .env from staging area"
    exit 1
fi

# Check for private keys
if git diff --cached --name-only | grep -q "private.*key"; then
    echo "WARNING: Possible private key in commit!"
    echo "Please verify this is not a real private key"
    exit 1
fi

# Run Solidity linter if contracts changed
if git diff --cached --name-only | grep -q "\.sol$"; then
    echo "Running Solidity linter..."
    cd contracts && npm run lint:sol || exit 1
fi

# Run tests if test files changed
if git diff --cached --name-only | grep -q "\.test\.(js|ts)$"; then
    echo "Running tests..."
    npm run test || exit 1
fi

echo "✓ Pre-commit checks passed"
exit 0
EOF

chmod +x .git/hooks/pre-commit
```

---

### 5. DevOps Panel Quick Start (★★★★)

**Location:** `/devops-panel/quick-start.sh`

**What it provides:**
- Interactive setup wizard
- Environment variable generation
- Dependency installation
- Development server launcher

**Adaptation for VISE:**

Create `scripts/setup-vise-dev.sh`:

```bash
#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  VISE Development Environment Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check prerequisites
echo -e "${YELLOW}→ Checking prerequisites...${NC}"

# Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗ Node.js not found${NC}"
    echo "Install from: https://nodejs.org/"
    exit 1
fi
echo -e "${GREEN}✓ Node.js $(node -v)${NC}"

# Foundry
if ! command -v forge &> /dev/null; then
    echo -e "${YELLOW}⚠ Foundry not found${NC}"
    read -p "Install Foundry? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        curl -L https://foundry.paradigm.xyz | bash
        foundryup
    fi
fi
echo -e "${GREEN}✓ Foundry installed${NC}"

# Setup directories
echo ""
echo -e "${YELLOW}→ Creating directory structure...${NC}"
mkdir -p {contracts,demonstrations,infrastructure,docs,tests,scripts}
echo -e "${GREEN}✓ Directories created${NC}"

# Setup environment variables
echo ""
echo -e "${YELLOW}→ Setting up environment variables...${NC}"

if [ ! -f ".env" ]; then
    cat > .env << EOF
# Blockchain
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_KEY
MAINNET_RPC_URL=https://eth-mainnet.g.alchemy.com/v2/YOUR_KEY
PRIVATE_KEY=0x0000000000000000000000000000000000000000000000000000000000000000

# IPFS
PINATA_API_KEY=your_pinata_api_key
PINATA_SECRET_KEY=your_pinata_secret

# Email
SMTP_HOST=mail.vln.gg
SMTP_PORT=587
SMTP_USER=noreply@vln.gg
SMTP_PASSWORD=your_password

# Verification
ETHERSCAN_API_KEY=your_etherscan_api_key
EOF
    echo -e "${GREEN}✓ .env template created${NC}"
    echo -e "${YELLOW}  Please edit .env with your actual credentials${NC}"
else
    echo -e "${BLUE}  .env already exists${NC}"
fi

# Install dependencies
echo ""
echo -e "${YELLOW}→ Installing dependencies...${NC}"

if [ -f "package.json" ]; then
    npm install
    echo -e "${GREEN}✓ Dependencies installed${NC}"
fi

# Setup contracts
if [ -d "contracts" ]; then
    cd contracts
    if [ ! -f "foundry.toml" ]; then
        forge init --force
        echo -e "${GREEN}✓ Foundry initialized${NC}"
    fi
    cd ..
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ VISE development environment ready!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. Edit .env with your credentials"
echo -e "  2. Get testnet ETH from https://sepoliafaucet.com/"
echo -e "  3. Run: make deploy-contracts"
echo -e "  4. Run: npm run dev"
echo ""
```

---

### 6. Deployment Scripts (★★★★)

**Location:** `/devops-panel/deploy-*.sh`

**What they provide:**
- Automated deployment to various environments
- Subdomain deployment
- Production deployment with checks

**Adapt for VISE services:**

```bash
# scripts/deploy-edu-platform.sh
#!/bin/bash

set -e

ENV=${1:-staging}

echo "Deploying edu.vln.gg to $ENV..."

# Pre-deployment checks
echo "→ Running pre-deployment checks..."
npm run test
npm run lint
npm run type-check

# Build
echo "→ Building application..."
npm run build

# Deploy based on environment
case $ENV in
  staging)
    vercel --prod --scope vise --token $VERCEL_TOKEN
    ;;
  production)
    # Additional production checks
    read -p "Deploy to PRODUCTION? (yes/no): " CONFIRM
    if [ "$CONFIRM" == "yes" ]; then
      vercel --prod --scope vise --token $VERCEL_TOKEN
    fi
    ;;
esac

echo "✓ Deployment complete"
```

---

### 7. GitHub Actions Workflows Collection (★★★★★)

**Useful workflows to copy:**

#### Auto PR Description
```bash
cp DevOps/.github/workflows/auto-pr-description.yml .github/workflows/
```
- Automatically generates PR descriptions from commits
- Adds labels based on file changes
- Creates nice formatted PR bodies

#### Claude Usage Tracking
```bash
cp DevOps/.github/workflows/claude-usage-tracking.yml .github/workflows/
```
- Tracks Claude API usage
- Budget monitoring
- Cost optimization

#### SEO Marketing Automation
```bash
cp DevOps/.github/workflows/seo-marketing-automation.yml .github/workflows/
```
- Auto-generates sitemap.xml
- Updates robots.txt
- Creates social media graphics

#### Milestone Tracking
```bash
cp DevOps/.github/workflows/milestone-tracking.yml .github/workflows/
```
- Tracks progress on milestones
- Auto-updates issue status
- Generates progress reports

---

### 8. Utility Scripts (★★★)

**Copy these useful scripts:**

```bash
# SEO and metadata
cp DevOps/scripts/generate-sitemap.sh scripts/
cp DevOps/scripts/generate-robots.sh scripts/
cp DevOps/scripts/generate-schema.sh scripts/

# Documentation
cp DevOps/scripts/generate-commit-message.sh scripts/
cp DevOps/scripts/update-changelog.sh scripts/

# Monitoring
cp DevOps/scripts/cost-optimization.sh scripts/
cp DevOps/scripts/check-for-updates.sh scripts/
```

---

## VISE-Specific Integration Plan

### Phase 1: Essential DevOps Tools (Week 1)

```bash
# Day 1: Core infrastructure
1. Copy Makefile and customize for VISE
2. Setup git hooks
3. Create .env template

# Day 2: CI/CD
4. Copy ci-cd-enhanced.yml
5. Add smart contract compilation job
6. Add contract testing job

# Day 3: Deployment automation
7. Setup deployment scripts for docs, edu, mail
8. Configure Vercel integration
9. Test staging deployments

# Day 4: Monitoring
10. Setup budget alerts
11. Configure usage tracking
12. Create monitoring dashboard

# Day 5: Testing & validation
13. Run full CI/CD pipeline
14. Test all make commands
15. Validate deployment process
```

### Phase 2: Advanced Features (Week 2)

```bash
# GitHub Actions
16. Auto PR descriptions
17. Milestone tracking
18. SEO automation

# Monitoring & optimization
19. Cost optimization scripts
20. Performance monitoring
21. Automated backups

# Documentation
22. Auto-generate API docs
23. Update changelogs automatically
24. Create deployment runbooks
```

---

## Integration Checklist

### Files to Copy

- [ ] `Makefile` → `/Makefile`
- [ ] `scripts/setup-git-hooks.sh` → `/scripts/`
- [ ] `scripts/budget-alerts.sh` → `/scripts/`
- [ ] `.github/workflows/ci-cd-enhanced.yml` → `/.github/workflows/`
- [ ] `.github/workflows/auto-pr-description.yml` → `/.github/workflows/`
- [ ] `.github/workflows/claude-usage-tracking.yml` → `/.github/workflows/`
- [ ] `.github/workflows/seo-marketing-automation.yml` → `/.github/workflows/`
- [ ] `devops-panel/quick-start.sh` → adapt to `/scripts/setup-vise-dev.sh`

### Configuration Files to Create

- [ ] `scripts/config-budget.json` - Budget tracking config
- [ ] `scripts/config-deployment.json` - Deployment environments
- [ ] `.github/workflows/deploy-contracts.yml` - Smart contract deployment
- [ ] `.github/workflows/deploy-platform.yml` - Platform deployment

### Customizations Needed

- [ ] Update Makefile with blockchain-specific commands
- [ ] Add Foundry/Hardhat steps to CI/CD
- [ ] Configure budget thresholds for Web3 services
- [ ] Setup domain-specific deployment scripts
- [ ] Add contract verification to deployment

---

## Command Reference (After Integration)

```bash
# Setup & Installation
make setup                  # Complete project setup
make install                # Install dependencies

# Development
make dev                    # Start development servers
make test                   # Run all tests
make test-contracts         # Test smart contracts only

# Smart Contracts
make deploy-contracts       # Deploy to testnet
make verify-contracts       # Verify on Etherscan
make mint-test-nft         # Mint test achievement

# Build & Deploy
make build                  # Build all projects
make deploy-docs            # Deploy docs.vln.gg
make deploy-edu             # Deploy edu.vln.gg
make deploy-mail            # Setup mail.vln.gg

# Monitoring
make status                 # Show project status
make view-usage             # View usage statistics
make check-budget           # Check budget alerts

# SEO & Marketing
make seo-optimize           # Generate SEO files
make seo-check              # Validate SEO config

# Cleanup
make clean                  # Clean build artifacts
make clean-contracts        # Clean contract artifacts
```

---

## Estimated Time Savings

By leveraging existing DevOps infrastructure:

| Task | From Scratch | Using DevOps Repo | Time Saved |
|------|-------------|-------------------|------------|
| Makefile setup | 4 hours | 30 min | 3.5 hours |
| CI/CD pipeline | 8 hours | 2 hours | 6 hours |
| Git hooks | 2 hours | 15 min | 1.75 hours |
| Deployment scripts | 6 hours | 1 hour | 5 hours |
| Budget monitoring | 4 hours | 30 min | 3.5 hours |
| SEO automation | 3 hours | 20 min | 2.67 hours |
| **Total** | **27 hours** | **4.5 hours** | **~22.5 hours** |

---

## Security Considerations

### Before Using These Scripts

1. **Review for secrets:** Check all copied files for hardcoded credentials
2. **Update .gitignore:** Ensure .env files are ignored
3. **Token permissions:** Limit GitHub Actions token permissions
4. **API keys:** Rotate any exposed API keys
5. **Audit dependencies:** Run npm audit on copied package.json files

### Recommended Security Enhancements

```bash
# Add to pre-commit hook
# Check for blockchain private keys
if git diff --cached | grep -i "private.*key.*0x[a-f0-9]\{64\}"; then
    echo "ERROR: Blockchain private key detected!"
    exit 1
fi

# Check for RPC URLs with API keys
if git diff --cached | grep -E "alchemy\.com/v2/[a-zA-Z0-9]+"; then
    echo "WARNING: RPC URL with API key detected!"
    exit 1
fi
```

---

## Next Steps

1. **Immediate:** Copy Makefile and ci-cd-enhanced.yml
2. **This week:** Setup deployment scripts for all three domains
3. **Next week:** Implement budget monitoring and usage tracking
4. **Ongoing:** Customize workflows for VISE-specific needs

---

## Resources

- **Source Repo:** https://github.com/Fused-Gaming/DevOps
- **DevOps Docs:** `/design-standards/docs/`
- **Workflow Templates:** `/.github/workflows/`
- **Script Collection:** `/scripts/`

---

**Created:** 2025-11-22
**Last Updated:** 2025-11-22
**Maintained By:** VISE DevOps Team
