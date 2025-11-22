# VISE DevOps Quick Start Guide

Welcome to the VISE platform! This guide will help you get started with our integrated DevOps tools.

## 🚀 Quick Setup

```bash
# 1. Clone the repository
git clone https://github.com/Fused-Gaming/vise.git
cd vise

# 2. Run complete setup
make setup

# 3. Copy and configure environment variables
cp .env.example .env
# Edit .env with your actual credentials

# 4. Initialize smart contracts
make init-contracts

# 5. You're ready to develop!
make help
```

## 📋 Essential Commands

### Development

```bash
# Show all available commands
make help

# Run tests
make test

# Test smart contracts
make test-contracts

# Build everything
make build
```

### Smart Contracts

```bash
# Initialize Foundry project
make init-contracts

# Compile contracts
make compile-contracts

# Run contract tests
make test-contracts

# Generate coverage report
make coverage-contracts

# Deploy to Sepolia testnet
make deploy-contracts

# Verify on Etherscan
make verify-contracts
```

### Platform Deployment

```bash
# Deploy documentation site
make deploy-docs

# Deploy education platform
make deploy-edu

# Setup email server (manual)
make setup-mail
```

### Monitoring

```bash
# Check project status
make status

# View usage statistics
make view-usage

# Check API budget
make check-budget
```

## 🔧 Configuration Files

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# Required for smart contracts
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_KEY
PRIVATE_KEY=0x...  # Your deployment wallet
ETHERSCAN_API_KEY=your_key

# Required for IPFS
PINATA_API_KEY=your_key
PINATA_SECRET_KEY=your_secret

# Required for email
SMTP_HOST=mail.vln.gg
SMTP_USER=noreply@vln.gg
SMTP_PASSWORD=your_password
```

### Budget Monitoring

Edit `scripts/config-budget.json` to set budget limits:

```json
{
  "budget": {
    "daily": 10.00,
    "weekly": 50.00,
    "monthly": 200.00
  },
  "services": {
    "alchemy_rpc": {
      "budget_monthly": 50.00
    },
    "pinata_ipfs": {
      "budget_monthly": 20.00
    }
  }
}
```

## 🔒 Security Features

### Git Hooks

Automatically installed with `make setup`:

- ✅ Prevents committing .env files
- ✅ Detects private keys
- ✅ Runs linters before commit
- ✅ Validates contract changes

### CI/CD Pipeline

GitHub Actions automatically:

- 🔍 Scans for secrets
- 🔒 Audits dependencies
- 🔗 Compiles & tests contracts
- 🏗️ Builds platform
- 📊 Generates reports

## 📁 Project Structure

```
vise/
├── contracts/              # Smart contracts (Foundry)
│   ├── src/               # Contract source files
│   ├── test/              # Contract tests
│   └── script/            # Deployment scripts
├── demonstrations/         # Code demonstrations for curriculum
├── infrastructure/         # DevOps documentation
├── docs/                  # Documentation site (VitePress)
├── edu/                   # Education platform (Next.js)
├── scripts/               # Automation scripts
│   ├── deploy-docs.sh
│   ├── deploy-edu.sh
│   ├── budget-alerts.sh
│   └── setup-git-hooks.sh
├── .github/workflows/     # CI/CD pipelines
├── Makefile              # Command shortcuts
└── .env.example          # Environment template
```

## 🎯 Common Workflows

### Starting Development

```bash
# Setup everything
make setup

# Install dependencies
make install

# Start developing
# (each component has its own dev server)
```

### Deploying Smart Contracts

```bash
# 1. Compile contracts
make compile-contracts

# 2. Run tests
make test-contracts

# 3. Check coverage
make coverage-contracts

# 4. Deploy to testnet
make deploy-contracts

# 5. Verify on Etherscan
make verify-contracts
```

### Deploying Platform

```bash
# Deploy documentation
make deploy-docs

# Deploy education platform
make deploy-edu

# Check deployment status
make status
```

### Monitoring & Alerts

```bash
# Check budget status
make check-budget

# View detailed usage
make view-usage

# See project status
make status
```

## 🆘 Troubleshooting

### "Command not found: forge"

Install Foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### "npm: command not found"

Install Node.js 18+:
```bash
# Visit https://nodejs.org/
# Or use nvm:
nvm install 18
```

### "Permission denied" on scripts

Make scripts executable:
```bash
chmod +x scripts/*.sh
```

### ".env file tracked in git"

Remove from git:
```bash
git rm --cached .env
echo ".env" >> .gitignore
git commit -m "Remove .env from git"
```

## 📚 Documentation

- **DevOps Architecture**: `infrastructure/DEVOPS-ARCHITECTURE.md`
- **docs.vln.gg Setup**: `infrastructure/docs-vln-gg-setup.md`
- **edu.vln.gg Setup**: `infrastructure/edu-vln-gg-setup.md`
- **mail.vln.gg Setup**: `infrastructure/mail-vln-gg-setup.md`
- **DevOps Tools Integration**: `infrastructure/DEVOPS-TOOLS-INTEGRATION.md`
- **Curriculum Demos**: `demonstrations/CURRICULUM-DEMOS-GUIDE.md`

## 🔗 Useful Links

- **Repository**: https://github.com/Fused-Gaming/vise
- **Documentation** (coming soon): https://docs.vln.gg
- **Education Platform** (coming soon): https://edu.vln.gg
- **Foundry Book**: https://book.getfoundry.sh/
- **Hardhat Docs**: https://hardhat.org/docs

## 💡 Tips

1. **Always run tests** before deploying: `make test-contracts`
2. **Check budget regularly**: `make check-budget`
3. **Keep .env secure**: Never commit it to git
4. **Use testnet first**: Test everything on Sepolia before mainnet
5. **Review CI/CD logs**: Check GitHub Actions for deployment status

## 🤝 Contributing

See our contribution guidelines for:
- Code style
- Testing requirements
- PR process
- Documentation standards

## 📞 Support

- **GitHub Issues**: https://github.com/Fused-Gaming/vise/issues
- **Documentation**: Check `infrastructure/` directory
- **DevOps Repo**: https://github.com/Fused-Gaming/DevOps

---

**Built with** ❤️ **by the VISE team**

*Last updated: 2025-11-22*
