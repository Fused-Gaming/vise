#!/bin/bash

# Deploy docs.vln.gg (VitePress documentation site)
# This script builds and deploys the documentation site

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Deploying docs.vln.gg${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if docs directory exists
if [ ! -d "docs" ]; then
    echo -e "${YELLOW}⚠️  docs directory not found${NC}"
    echo -e "${BLUE}  Creating docs directory with VitePress...${NC}"
    mkdir -p docs
    cd docs
    npm init -y
    npm install -D vitepress
    npx vitepress init
    cd ..
fi

# Navigate to docs directory
cd docs

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}→ Installing dependencies...${NC}"
    npm install
fi

# Build documentation
echo -e "${YELLOW}→ Building documentation...${NC}"
npm run docs:build

# Deploy to Vercel (or other platform)
echo -e "${YELLOW}→ Deploying to production...${NC}"

if [ -n "$VERCEL_TOKEN" ]; then
    # Deploy with Vercel
    npx vercel --prod --token $VERCEL_TOKEN --yes
    echo -e "${GREEN}✓ Deployed to Vercel${NC}"
else
    echo -e "${YELLOW}⚠️  VERCEL_TOKEN not set${NC}"
    echo -e "${BLUE}  Manual deployment required${NC}"
    echo -e "${BLUE}  Run: cd docs && npx vercel --prod${NC}"
fi

cd ..

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Documentation deployment complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Site:${NC} https://docs.vln.gg"
echo ""
