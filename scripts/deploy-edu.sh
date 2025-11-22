#!/bin/bash

# Deploy edu.vln.gg (Next.js education platform)
# This script builds and deploys the education platform

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Deploying edu.vln.gg${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if edu directory exists
if [ ! -d "edu" ]; then
    echo -e "${YELLOW}⚠️  edu directory not found${NC}"
    echo -e "${BLUE}  Platform code should be in the 'edu' directory${NC}"
    echo -e "${BLUE}  See infrastructure/edu-vln-gg-setup.md for setup instructions${NC}"
    exit 1
fi

# Navigate to edu directory
cd edu

# Check for required environment variables
echo -e "${YELLOW}→ Checking environment variables...${NC}"

REQUIRED_VARS=(
    "DATABASE_URL"
    "REDIS_URL"
    "NEXTAUTH_SECRET"
    "NEXT_PUBLIC_CHAIN_ID"
    "NEXT_PUBLIC_RPC_URL"
)

MISSING_VARS=()

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        MISSING_VARS+=("$var")
    fi
done

if [ ${#MISSING_VARS[@]} -gt 0 ]; then
    echo -e "${RED}❌ Missing required environment variables:${NC}"
    for var in "${MISSING_VARS[@]}"; do
        echo -e "   - $var"
    done
    echo ""
    echo -e "${BLUE}  Add these to your .env.production file${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Environment variables configured${NC}"

# Install dependencies
echo -e "${YELLOW}→ Installing dependencies...${NC}"
npm ci

# Run database migrations
echo -e "${YELLOW}→ Running database migrations...${NC}"
npx prisma migrate deploy

# Build application
echo -e "${YELLOW}→ Building application...${NC}"
npm run build

# Deploy to platform
echo -e "${YELLOW}→ Deploying to production...${NC}"

if [ -n "$VERCEL_TOKEN" ]; then
    # Deploy with Vercel
    npx vercel --prod --token $VERCEL_TOKEN --yes
    echo -e "${GREEN}✓ Deployed to Vercel${NC}"
elif [ -f "docker-compose.yml" ]; then
    # Deploy with Docker
    echo -e "${BLUE}  Deploying with Docker...${NC}"
    docker-compose build
    docker-compose up -d
    echo -e "${GREEN}✓ Deployed with Docker${NC}"
else
    echo -e "${YELLOW}⚠️  No deployment method configured${NC}"
    echo -e "${BLUE}  Configure VERCEL_TOKEN or docker-compose.yml${NC}"
    exit 1
fi

cd ..

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Education platform deployment complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Site:${NC} https://edu.vln.gg"
echo ""
