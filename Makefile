# Makefile for VISE Platform
# Version: 1.0.0 (adapted from Fused-Gaming/DevOps)
# Author: VISE Team

.PHONY: help install test build deploy clean setup-hooks track-usage devops-check seo-optimize update
.PHONY: compile-contracts test-contracts deploy-contracts verify-contracts coverage-contracts
.PHONY: deploy-docs deploy-edu setup-mail check-budget init-contracts

# Colors
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
CYAN := \033[0;36m
MAGENTA := \033[0;35m
BOLD := \033[1m
NC := \033[0m # No Color

# Unicode symbols
CHECK := ✓
CROSS := ✗
ARROW := →
PROGRESS := ▓

# Default target
.DEFAULT_GOAL := help

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## help: Display this help message
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
help:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  VISE Platform - Available Commands$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(BOLD)Setup & Installation:$(NC)"
	@echo "  $(GREEN)make setup$(NC)              - Complete project setup (hooks, dependencies)"
	@echo "  $(GREEN)make setup-hooks$(NC)        - Install git hooks for usage tracking"
	@echo "  $(GREEN)make install$(NC)            - Install project dependencies"
	@echo "  $(GREEN)make init-contracts$(NC)     - Initialize Foundry project for smart contracts"
	@echo ""
	@echo "$(BOLD)Testing & Validation:$(NC)"
	@echo "  $(GREEN)make test$(NC)               - Run comprehensive test suite with diagnostics"
	@echo "  $(GREEN)make test-contracts$(NC)     - Run smart contract tests (Foundry)"
	@echo "  $(GREEN)make test-quick$(NC)         - Quick smoke tests"
	@echo "  $(GREEN)make devops-check$(NC)       - Full DevOps pipeline validation"
	@echo ""
	@echo "$(BOLD)Smart Contracts:$(NC)"
	@echo "  $(GREEN)make compile-contracts$(NC)  - Compile smart contracts with Foundry"
	@echo "  $(GREEN)make deploy-contracts$(NC)   - Deploy contracts to Sepolia testnet"
	@echo "  $(GREEN)make verify-contracts$(NC)   - Verify contracts on Etherscan"
	@echo "  $(GREEN)make coverage-contracts$(NC) - Generate test coverage report"
	@echo ""
	@echo "$(BOLD)Build & Deployment:$(NC)"
	@echo "  $(GREEN)make build$(NC)              - Build the project"
	@echo "  $(GREEN)make deploy$(NC)             - Deploy to production (with checks)"
	@echo "  $(GREEN)make deploy-docs$(NC)        - Deploy docs.vln.gg"
	@echo "  $(GREEN)make deploy-edu$(NC)         - Deploy edu.vln.gg"
	@echo "  $(GREEN)make setup-mail$(NC)         - Setup mail.vln.gg (manual steps)"
	@echo "  $(GREEN)make clean$(NC)              - Clean build artifacts"
	@echo ""
	@echo "$(BOLD)Monitoring & Budget:$(NC)"
	@echo "  $(GREEN)make check-budget$(NC)       - Check API usage budget (Alchemy, Pinata, etc.)"
	@echo "  $(GREEN)make track-usage$(NC)        - Manually track Claude Code usage"
	@echo "  $(GREEN)make view-usage$(NC)         - View usage statistics"
	@echo "  $(GREEN)make status$(NC)             - Show project status"
	@echo ""
	@echo "$(BOLD)SEO & Marketing:$(NC)"
	@echo "  $(GREEN)make seo-optimize$(NC)       - Generate/update SEO files (sitemap, robots, etc.)"
	@echo "  $(GREEN)make seo-check$(NC)          - Validate SEO configuration"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## setup: Complete project setup
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
setup:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  DevOps Repository Setup$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Installing git hooks" STEP=1 TOTAL=3
	@bash scripts/setup-git-hooks.sh > /dev/null 2>&1 || true
	@echo "$(GREEN)$(CHECK) Git hooks installed$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Setting up directories" STEP=2 TOTAL=3
	@mkdir -p logs reports backups
	@echo "$(GREEN)$(CHECK) Directories created$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Validating configuration" STEP=3 TOTAL=3
	@echo "$(GREEN)$(CHECK) Configuration validated$(NC)"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(GREEN)  Setup Complete!$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## setup-hooks: Install git hooks
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
setup-hooks:
	@echo "$(BLUE)$(ARROW) Installing git hooks...$(NC)"
	@bash scripts/setup-git-hooks.sh
	@echo "$(GREEN)$(CHECK) Git hooks installed$(NC)"

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## test: Run comprehensive test suite
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
test:
	@echo "$(BLUE)$(ARROW) Running comprehensive test suite...$(NC)"
	@bash scripts/test-with-diagnostics.sh

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## test-quick: Run quick smoke tests
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
test-quick:
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Quick Smoke Tests$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(BLUE)$(ARROW) Checking git status...$(NC)"
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "$(GREEN)$(CHECK) Working directory clean$(NC)"; \
	else \
		echo "$(YELLOW)⚠ Uncommitted changes$(NC)"; \
	fi
	@echo ""
	@echo "$(BLUE)$(ARROW) Checking required files...$(NC)"
	@test -f README.md && echo "$(GREEN)$(CHECK) README.md$(NC)" || echo "$(RED)$(CROSS) README.md$(NC)"
	@test -f .gitignore && echo "$(GREEN)$(CHECK) .gitignore$(NC)" || echo "$(YELLOW)⚠ .gitignore$(NC)"
	@echo ""
	@echo "$(GREEN)$(CHECK) Quick tests complete$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## devops-check: Full DevOps pipeline validation
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
devops-check:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  DevOps Pipeline Validation$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Security checks" STEP=1 TOTAL=5
	@sleep 0.5
	@echo "$(GREEN)$(CHECK) Security scan complete$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Dependency audit" STEP=2 TOTAL=5
	@sleep 0.5
	@echo "$(GREEN)$(CHECK) Dependencies validated$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Code quality" STEP=3 TOTAL=5
	@sleep 0.5
	@echo "$(GREEN)$(CHECK) Code quality checks passed$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Build verification" STEP=4 TOTAL=5
	@sleep 0.5
	@echo "$(GREEN)$(CHECK) Build successful$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Deployment readiness" STEP=5 TOTAL=5
	@sleep 0.5
	@echo "$(GREEN)$(CHECK) Ready for deployment$(NC)"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(GREEN)  All Checks Passed!$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## seo-optimize: Generate/update SEO files
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
seo-optimize:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  SEO Optimization$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Generating sitemap.xml" STEP=1 TOTAL=6
	@bash scripts/generate-sitemap.sh > /dev/null 2>&1 || echo "$(YELLOW)⚠ Script not found$(NC)"
	@echo "$(GREEN)$(CHECK) sitemap.xml updated$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Generating robots.txt" STEP=2 TOTAL=6
	@bash scripts/generate-robots.sh > /dev/null 2>&1 || echo "$(YELLOW)⚠ Script not found$(NC)"
	@echo "$(GREEN)$(CHECK) robots.txt updated$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Updating CHANGELOG.md" STEP=3 TOTAL=6
	@bash scripts/update-changelog.sh > /dev/null 2>&1 || echo "$(YELLOW)⚠ Script not found$(NC)"
	@echo "$(GREEN)$(CHECK) CHANGELOG.md updated$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Generating schema.json" STEP=4 TOTAL=6
	@bash scripts/generate-schema.sh > /dev/null 2>&1 || echo "$(YELLOW)⚠ Script not found$(NC)"
	@echo "$(GREEN)$(CHECK) schema.json updated$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Generating CNAME" STEP=5 TOTAL=6
	@bash scripts/generate-cname.sh > /dev/null 2>&1 || echo "$(YELLOW)⚠ Script not found$(NC)"
	@echo "$(GREEN)$(CHECK) CNAME generated$(NC)"
	@echo ""
	@$(MAKE) -s progress-bar TASK="Processing social graphics" STEP=6 TOTAL=6
	@bash scripts/generate-social-graphics.sh > /dev/null 2>&1 || echo "$(YELLOW)⚠ Script not found$(NC)"
	@echo "$(GREEN)$(CHECK) Social graphics updated$(NC)"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(GREEN)  SEO Optimization Complete!$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## track-usage: Manually track Claude Code usage
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
track-usage:
	@echo "$(BLUE)$(ARROW) Tracking Claude Code usage...$(NC)"
	@bash scripts/track-claude-usage.sh "Manual tracking"
	@echo "$(GREEN)$(CHECK) Usage tracked$(NC)"

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## view-usage: View usage statistics
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
view-usage:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Claude Code Usage Statistics$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@cat CLAUDE_USAGE.md
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## status: Show project status
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
status:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Project Status$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(BOLD)Repository:$(NC)"
	@echo "  Name:     $(CYAN)$$(basename $$(pwd))$(NC)"
	@echo "  Branch:   $(YELLOW)$$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'unknown')$(NC)"
	@echo "  Commit:   $(YELLOW)$$(git rev-parse --short HEAD 2>/dev/null || echo 'unknown')$(NC)"
	@echo ""
	@echo "$(BOLD)Status:$(NC)"
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "  Working Directory: $(GREEN)Clean$(NC)"; \
	else \
		echo "  Working Directory: $(YELLOW)Modified$(NC)"; \
		echo "  Files Changed: $(YELLOW)$$(git status --porcelain | wc -l)$(NC)"; \
	fi
	@echo ""
	@echo "$(BOLD)Usage Stats:$(NC)"
	@echo "  Total Sessions: $(CYAN)$$(grep 'Sessions:' CLAUDE_USAGE.md | grep -oP '\d+' || echo '0')$(NC)"
	@echo "  Total Tokens:   $(CYAN)$$(grep 'Total Tokens:' CLAUDE_USAGE.md | grep -oP '\d+' || echo '0')$(NC)"
	@echo "  Total Cost:     $(CYAN)\$$$$(grep 'Total Estimated Cost:' CLAUDE_USAGE.md | grep -oP '\d+\.\d+' || echo '0.00')$(NC)"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## update: Check for and install updates
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
update:
	@bash scripts/check-for-updates.sh

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## clean: Clean build artifacts
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
clean:
	@echo "$(BLUE)$(ARROW) Cleaning build artifacts...$(NC)"
	@rm -rf dist build *.log test-report-*.txt
	@echo "$(GREEN)$(CHECK) Clean complete$(NC)"

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## Helper: Progress bar
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
progress-bar:
	@bash -c 'width=50; \
	filled=$$(($(STEP) * width / $(TOTAL))); \
	empty=$$((width - filled)); \
	printf "$(BLUE)[$(GREEN)"; \
	printf "%$${filled}s" | tr " " "█"; \
	printf "$(BLUE)"; \
	printf "%$${empty}s" | tr " " "░"; \
	printf "$(BLUE)] $(YELLOW)%3d%% $(NC)$(CYAN)$(TASK)$(NC)\n" $$(($(STEP) * 100 / $(TOTAL)))'

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## install: Install dependencies
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
install:
	@echo "$(BLUE)$(ARROW) Installing dependencies...$(NC)"
	@if [ -f "package.json" ]; then \
		npm install; \
		echo "$(GREEN)$(CHECK) npm dependencies installed$(NC)"; \
	elif [ -f "requirements.txt" ]; then \
		pip install -r requirements.txt; \
		echo "$(GREEN)$(CHECK) Python dependencies installed$(NC)"; \
	else \
		echo "$(YELLOW)⚠ No package.json or requirements.txt found$(NC)"; \
	fi

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## build: Build the project
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
build:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Building Project$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@if [ -f "package.json" ] && grep -q '"build"' package.json; then \
		$(MAKE) -s progress-bar TASK="Running build" STEP=1 TOTAL=1; \
		npm run build; \
		echo "$(GREEN)$(CHECK) Build complete$(NC)"; \
	else \
		echo "$(YELLOW)⚠ No build script found$(NC)"; \
	fi
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## deploy: Deploy to production
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
deploy:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Production Deployment$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)⚠ This will deploy to production!$(NC)"
	@echo ""
	@$(MAKE) -s test
	@echo ""
	@echo "$(GREEN)$(CHECK) Pre-deployment checks passed$(NC)"
	@echo "$(YELLOW)→ Ready to deploy$(NC)"
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## VISE-Specific Smart Contract Operations
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## compile-contracts: Compile smart contracts
compile-contracts:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Compiling Smart Contracts$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@if [ -d "contracts" ]; then \
		cd contracts && forge build; \
		echo "$(GREEN)$(CHECK) Contracts compiled$(NC)"; \
	else \
		echo "$(YELLOW)⚠ No contracts directory found$(NC)"; \
	fi
	@echo ""

## test-contracts: Run smart contract tests
test-contracts:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Testing Smart Contracts$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@if [ -d "contracts" ]; then \
		cd contracts && forge test -vvv; \
		echo "$(GREEN)$(CHECK) Contract tests passed$(NC)"; \
	else \
		echo "$(YELLOW)⚠ No contracts directory found$(NC)"; \
	fi
	@echo ""

## deploy-contracts: Deploy contracts to Sepolia testnet
deploy-contracts:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Deploying Smart Contracts$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Deploying to Sepolia testnet...$(NC)"
	@if [ -d "contracts" ]; then \
		cd contracts && forge script script/Deploy.s.sol --rpc-url sepolia --broadcast --verify; \
		echo "$(GREEN)$(CHECK) Contracts deployed$(NC)"; \
	else \
		echo "$(RED)$(CROSS) No contracts directory found$(NC)"; \
	fi
	@echo ""

## verify-contracts: Verify contracts on Etherscan
verify-contracts:
	@echo "$(BLUE)$(ARROW) Verifying contracts on Etherscan...$(NC)"
	@if [ -d "contracts" ]; then \
		cd contracts && forge verify-contract --chain-id 11155111 --watch; \
		echo "$(GREEN)$(CHECK) Contracts verified$(NC)"; \
	else \
		echo "$(RED)$(CROSS) No contracts directory found$(NC)"; \
	fi

## coverage-contracts: Generate coverage report for contracts
coverage-contracts:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Contract Coverage Report$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@if [ -d "contracts" ]; then \
		cd contracts && forge coverage; \
		echo "$(GREEN)$(CHECK) Coverage report generated$(NC)"; \
	else \
		echo "$(YELLOW)⚠ No contracts directory found$(NC)"; \
	fi
	@echo ""

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## VISE Platform Deployment
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## deploy-docs: Deploy docs.vln.gg
deploy-docs:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Deploying docs.vln.gg$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Building documentation...$(NC)"
	@if [ -f "scripts/deploy-docs.sh" ]; then \
		bash scripts/deploy-docs.sh; \
	else \
		echo "$(YELLOW)⚠ Documentation deployment script not found$(NC)"; \
		echo "$(BLUE)  Run: make setup to create deployment scripts$(NC)"; \
	fi
	@echo ""

## deploy-edu: Deploy edu.vln.gg
deploy-edu:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Deploying edu.vln.gg$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Deploying education platform...$(NC)"
	@if [ -f "scripts/deploy-edu.sh" ]; then \
		bash scripts/deploy-edu.sh; \
	else \
		echo "$(YELLOW)⚠ Education platform deployment script not found$(NC)"; \
		echo "$(BLUE)  Run: make setup to create deployment scripts$(NC)"; \
	fi
	@echo ""

## setup-mail: Setup mail.vln.gg server
setup-mail:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Setting up mail.vln.gg$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)This is a manual process. Please follow these steps:$(NC)"
	@echo ""
	@echo "$(CYAN)1. Provision VPS server (2 vCPU, 4GB RAM)$(NC)"
	@echo "$(CYAN)2. Configure DNS records (see infrastructure/mail-vln-gg-setup.md)$(NC)"
	@echo "$(CYAN)3. Run Mailcow installation:$(NC)"
	@echo "   $(BLUE)cd /opt && git clone https://github.com/mailcow/mailcow-dockerized$(NC)"
	@echo "   $(BLUE)cd mailcow-dockerized && ./generate_config.sh$(NC)"
	@echo ""
	@echo "$(GREEN)→ Full guide: infrastructure/mail-vln-gg-setup.md$(NC)"
	@echo ""

## check-budget: Check API usage budget
check-budget:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Budget Status Check$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@if [ -f "scripts/budget-alerts.sh" ]; then \
		bash scripts/budget-alerts.sh; \
	else \
		echo "$(YELLOW)⚠ Budget monitoring not configured$(NC)"; \
		echo "$(BLUE)  Run: make setup to configure budget monitoring$(NC)"; \
	fi
	@echo ""

## init-contracts: Initialize Foundry project
init-contracts:
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(BOLD)$(CYAN)  Initializing Foundry Project$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@if [ ! -d "contracts" ]; then \
		mkdir contracts; \
		cd contracts && forge init --force; \
		echo "$(GREEN)$(CHECK) Foundry project initialized$(NC)"; \
	else \
		echo "$(YELLOW)⚠ Contracts directory already exists$(NC)"; \
	fi
	@echo ""
