# edu.vln.gg - Education Platform Setup

**Purpose:** Main education platform for course delivery, progress tracking, and user interaction
**Technology:** Next.js 14 (App Router) + PostgreSQL + Redis
**URL:** https://edu.vln.gg

## Overview

The education platform is the core application where students access courses, submit exercises, track progress, earn achievements, and participate in governance. It includes user authentication, course management, blockchain integration, and community features.

## Technology Stack

### Framework: Next.js 14 with App Router

**Why Next.js 14?**
- React 18 with Server Components
- App Router for improved performance
- Built-in API routes
- Excellent TypeScript support
- Image optimization
- SEO-friendly
- Edge runtime support
- Streaming SSR

### Database: PostgreSQL 15

**Schema Overview:**

```sql
-- Users and Authentication
users (
  id UUID PRIMARY KEY,
  wallet_address VARCHAR(42) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE,
  username VARCHAR(50) UNIQUE,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
)

-- Course Progress
module_progress (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  module_id INTEGER,
  status VARCHAR(20), -- 'not_started', 'in_progress', 'completed'
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  score INTEGER
)

-- Exercise Submissions
submissions (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  exercise_id VARCHAR(100),
  code TEXT,
  status VARCHAR(20), -- 'pending', 'approved', 'rejected'
  feedback TEXT,
  submitted_at TIMESTAMP,
  reviewed_by UUID REFERENCES users(id),
  reviewed_at TIMESTAMP
)

-- Achievement NFTs (on-chain data cached)
achievements (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  token_id INTEGER,
  module_id INTEGER,
  contract_address VARCHAR(42),
  transaction_hash VARCHAR(66),
  metadata_uri VARCHAR(255),
  minted_at TIMESTAMP
)

-- Governance Proposals
proposals (
  id UUID PRIMARY KEY,
  proposer_id UUID REFERENCES users(id),
  title VARCHAR(255),
  description TEXT,
  status VARCHAR(20),
  created_at TIMESTAMP,
  voting_ends_at TIMESTAMP
)

-- Votes
votes (
  id UUID PRIMARY KEY,
  proposal_id UUID REFERENCES proposals(id),
  user_id UUID REFERENCES users(id),
  vote BOOLEAN, -- true = for, false = against
  voting_power INTEGER,
  transaction_hash VARCHAR(66),
  voted_at TIMESTAMP
)
```

### Cache: Redis 7

**Usage:**
- Session storage
- API response caching
- Rate limiting
- Real-time user presence
- Job queue (Bull)

### Blockchain Integration

**Web3 Libraries:**
- `ethers.js` v6 - Contract interaction
- `wagmi` - React hooks for Ethereum
- `viem` - TypeScript-first Ethereum library
- `RainbowKit` - Wallet connection UI

**Smart Contracts:**
- Achievement NFT (ERC-721)
- Governance Token (ERC-20)
- Staking Contract
- Governor Contract

## Project Structure

```
edu-platform/
├── src/
│   ├── app/                      # Next.js App Router
│   │   ├── (auth)/              # Auth layout group
│   │   │   ├── login/
│   │   │   └── signup/
│   │   ├── (dashboard)/         # Dashboard layout group
│   │   │   ├── courses/
│   │   │   ├── achievements/
│   │   │   ├── governance/
│   │   │   └── profile/
│   │   ├── api/                 # API routes
│   │   │   ├── auth/
│   │   │   ├── courses/
│   │   │   ├── submissions/
│   │   │   └── blockchain/
│   │   ├── layout.tsx           # Root layout
│   │   └── page.tsx             # Home page
│   ├── components/
│   │   ├── ui/                  # Shadcn UI components
│   │   ├── course/
│   │   ├── wallet/
│   │   └── shared/
│   ├── lib/
│   │   ├── db/                  # Database utilities
│   │   ├── blockchain/          # Web3 utilities
│   │   ├── auth/                # Authentication
│   │   └── utils/
│   ├── hooks/                   # React hooks
│   ├── types/                   # TypeScript types
│   └── styles/                  # Global styles
├── contracts/                   # Smart contract ABIs
├── prisma/                      # Prisma ORM
│   ├── schema.prisma
│   └── migrations/
├── public/                      # Static assets
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── .env.example
├── docker-compose.yml
├── Dockerfile
├── next.config.js
├── package.json
└── tsconfig.json
```

## Setup Instructions

### Prerequisites

```bash
Node.js >= 18
PostgreSQL >= 15
Redis >= 7
Docker & Docker Compose
```

### Installation

```bash
# Clone repository
git clone https://github.com/Fused-Gaming/vise-platform
cd vise-platform/edu

# Install dependencies
npm install

# Setup environment variables
cp .env.example .env.local

# Start database and Redis with Docker
docker-compose up -d postgres redis

# Run database migrations
npx prisma migrate dev

# Seed database with sample data
npx prisma db seed

# Start development server
npm run dev
```

### Environment Variables

**.env.local:**

```bash
# Database
DATABASE_URL="postgresql://vise:password@localhost:5432/vise_edu"

# Redis
REDIS_URL="redis://localhost:6379"

# Authentication
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="generate-with-openssl-rand-base64-32"

# Blockchain
NEXT_PUBLIC_CHAIN_ID=11155111 # Sepolia testnet
NEXT_PUBLIC_RPC_URL="https://eth-sepolia.g.alchemy.com/v2/YOUR_KEY"
ACHIEVEMENT_NFT_ADDRESS="0x..."
GOVERNANCE_TOKEN_ADDRESS="0x..."
STAKING_CONTRACT_ADDRESS="0x..."

# IPFS
NEXT_PUBLIC_IPFS_GATEWAY="https://gateway.pinata.cloud/ipfs/"
PINATA_API_KEY="your-api-key"
PINATA_SECRET_KEY="your-secret-key"

# Email (for notifications)
SMTP_HOST="smtp.sendgrid.net"
SMTP_PORT=587
SMTP_USER="apikey"
SMTP_PASSWORD="your-sendgrid-api-key"
EMAIL_FROM="noreply@vln.gg"

# Analytics
NEXT_PUBLIC_PLAUSIBLE_DOMAIN="edu.vln.gg"

# Sentry (Error tracking)
SENTRY_DSN="your-sentry-dsn"
```

## Key Features Implementation

### 1. Web3 Authentication

**lib/auth/web3.ts:**

```typescript
import { getCsrfToken, signIn } from 'next-auth/react'
import { SiweMessage } from 'siwe'

export async function signInWithEthereum(
  address: string,
  chainId: number,
  provider: any
) {
  try {
    const message = new SiweMessage({
      domain: window.location.host,
      address,
      statement: 'Sign in to VISE Education Platform',
      uri: window.location.origin,
      version: '1',
      chainId,
      nonce: await getCsrfToken()
    })

    const signer = await provider.getSigner()
    const signature = await signer.signMessage(message.prepareMessage())

    const response = await signIn('credentials', {
      message: JSON.stringify(message),
      signature,
      redirect: false
    })

    return response
  } catch (error) {
    console.error('Error signing in:', error)
    throw error
  }
}
```

**app/api/auth/[...nextauth]/route.ts:**

```typescript
import NextAuth, { NextAuthOptions } from 'next-auth'
import CredentialsProvider from 'next-auth/providers/credentials'
import { SiweMessage } from 'siwe'
import { prisma } from '@/lib/db'

export const authOptions: NextAuthOptions = {
  providers: [
    CredentialsProvider({
      name: 'Ethereum',
      credentials: {
        message: { label: 'Message', type: 'text' },
        signature: { label: 'Signature', type: 'text' }
      },
      async authorize(credentials) {
        try {
          const siwe = new SiweMessage(JSON.parse(credentials?.message || '{}'))
          const result = await siwe.verify({ signature: credentials?.signature })

          if (result.success) {
            // Find or create user
            let user = await prisma.user.findUnique({
              where: { wallet_address: siwe.address }
            })

            if (!user) {
              user = await prisma.user.create({
                data: {
                  wallet_address: siwe.address,
                  username: `user_${siwe.address.slice(2, 8)}`
                }
              })
            }

            return {
              id: user.id,
              address: user.wallet_address,
              username: user.username
            }
          }

          return null
        } catch (error) {
          return null
        }
      }
    })
  ],
  session: {
    strategy: 'jwt'
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.address = user.address
        token.username = user.username
      }
      return token
    },
    async session({ session, token }) {
      session.user.address = token.address
      session.user.username = token.username
      return session
    }
  }
}

const handler = NextAuth(authOptions)
export { handler as GET, handler as POST }
```

### 2. Course Progress Tracking

**app/api/courses/[moduleId]/progress/route.ts:**

```typescript
import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { prisma } from '@/lib/db'
import { authOptions } from '@/app/api/auth/[...nextauth]/route'

export async function GET(
  req: NextRequest,
  { params }: { params: { moduleId: string } }
) {
  const session = await getServerSession(authOptions)
  if (!session) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const progress = await prisma.moduleProgress.findFirst({
    where: {
      user_id: session.user.id,
      module_id: parseInt(params.moduleId)
    }
  })

  return NextResponse.json(progress)
}

export async function POST(
  req: NextRequest,
  { params }: { params: { moduleId: string } }
) {
  const session = await getServerSession(authOptions)
  if (!session) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { status, score } = await req.json()

  const progress = await prisma.moduleProgress.upsert({
    where: {
      user_id_module_id: {
        user_id: session.user.id,
        module_id: parseInt(params.moduleId)
      }
    },
    update: {
      status,
      score,
      completed_at: status === 'completed' ? new Date() : null
    },
    create: {
      user_id: session.user.id,
      module_id: parseInt(params.moduleId),
      status,
      score,
      started_at: new Date()
    }
  })

  return NextResponse.json(progress)
}
```

### 3. Achievement NFT Minting

**lib/blockchain/mint-achievement.ts:**

```typescript
import { ethers } from 'ethers'
import AchievementNFT from '@/contracts/AchievementNFT.json'
import { prisma } from '@/lib/db'
import { uploadMetadataToIPFS } from '@/lib/ipfs'

export async function mintAchievementNFT(
  userId: string,
  moduleId: number,
  signer: ethers.Signer
) {
  try {
    // Generate metadata
    const metadata = await generateMetadata(userId, moduleId)

    // Upload to IPFS
    const metadataUri = await uploadMetadataToIPFS(metadata)

    // Mint NFT
    const contract = new ethers.Contract(
      process.env.ACHIEVEMENT_NFT_ADDRESS!,
      AchievementNFT.abi,
      signer
    )

    const tx = await contract.mint(
      await signer.getAddress(),
      moduleId,
      metadataUri
    )

    const receipt = await tx.wait()

    // Get token ID from event
    const event = receipt.events?.find(e => e.event === 'Transfer')
    const tokenId = event?.args?.tokenId.toNumber()

    // Save to database
    await prisma.achievement.create({
      data: {
        user_id: userId,
        token_id: tokenId,
        module_id: moduleId,
        contract_address: process.env.ACHIEVEMENT_NFT_ADDRESS!,
        transaction_hash: receipt.transactionHash,
        metadata_uri: metadataUri,
        minted_at: new Date()
      }
    })

    return {
      tokenId,
      transactionHash: receipt.transactionHash,
      metadataUri
    }
  } catch (error) {
    console.error('Error minting achievement NFT:', error)
    throw error
  }
}

async function generateMetadata(userId: string, moduleId: number) {
  const user = await prisma.user.findUnique({ where: { id: userId } })
  const progress = await prisma.moduleProgress.findFirst({
    where: { user_id: userId, module_id: moduleId }
  })

  return {
    name: `VISE Achievement - Module ${moduleId}`,
    description: `Proof of completion for VISE Module ${moduleId}`,
    image: `https://assets.vln.gg/achievements/module-${moduleId}.png`,
    attributes: [
      { trait_type: 'Module', value: `Module ${moduleId}` },
      { trait_type: 'Score', value: progress?.score || 0 },
      { trait_type: 'Username', value: user?.username },
      { trait_type: 'Completion Date', value: new Date().toISOString() }
    ]
  }
}
```

### 4. Governance Integration

**components/governance/ProposalCard.tsx:**

```tsx
'use client'

import { useState } from 'react'
import { useContractWrite, useWaitForTransaction } from 'wagmi'
import GovernorABI from '@/contracts/Governor.json'

interface Proposal {
  id: string
  title: string
  description: string
  votesFor: number
  votesAgainst: number
  status: string
}

export function ProposalCard({ proposal }: { proposal: Proposal }) {
  const [voting, setVoting] = useState(false)

  const { write: voteFor } = useContractWrite({
    address: process.env.NEXT_PUBLIC_GOVERNOR_ADDRESS,
    abi: GovernorABI.abi,
    functionName: 'castVote',
    args: [proposal.id, true]
  })

  const { write: voteAgainst } = useContractWrite({
    address: process.env.NEXT_PUBLIC_GOVERNOR_ADDRESS,
    abi: GovernorABI.abi,
    functionName: 'castVote',
    args: [proposal.id, false]
  })

  return (
    <div className="border rounded-lg p-6">
      <h3 className="text-xl font-bold">{proposal.title}</h3>
      <p className="text-gray-600 mt-2">{proposal.description}</p>

      <div className="mt-4 flex gap-4">
        <div>
          <span className="text-green-600 font-semibold">For: </span>
          {proposal.votesFor}
        </div>
        <div>
          <span className="text-red-600 font-semibold">Against: </span>
          {proposal.votesAgainst}
        </div>
      </div>

      <div className="mt-6 flex gap-3">
        <button
          onClick={() => voteFor?.()}
          disabled={voting || proposal.status !== 'active'}
          className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700"
        >
          Vote For
        </button>
        <button
          onClick={() => voteAgainst?.()}
          disabled={voting || proposal.status !== 'active'}
          className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700"
        >
          Vote Against
        </button>
      </div>
    </div>
  )
}
```

## Deployment

### Docker Configuration

**Dockerfile:**

```dockerfile
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npx prisma generate
RUN npm run build

FROM node:18-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/prisma ./prisma

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]
```

**docker-compose.yml:**

```yaml
version: '3.8'

services:
  app:
    build: .
    container_name: vise-edu
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://vise:${DB_PASSWORD}@postgres:5432/vise_edu
      - REDIS_URL=redis://redis:6379
    env_file:
      - .env.production
    depends_on:
      - postgres
      - redis
    networks:
      - vise-network

  postgres:
    image: postgres:15-alpine
    container_name: vise-postgres
    restart: unless-stopped
    environment:
      - POSTGRES_USER=vise
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_DB=vise_edu
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./backups:/backups
    networks:
      - vise-network

  redis:
    image: redis:7-alpine
    container_name: vise-redis
    restart: unless-stopped
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - vise-network

volumes:
  postgres_data:
  redis_data:

networks:
  vise-network:
    external: true
```

### GitHub Actions CI/CD

**.github/workflows/deploy-edu.yml:**

```yaml
name: Deploy Education Platform

on:
  push:
    branches: [main]
    paths:
      - 'edu/**'
  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

      - name: Run type check
        run: npm run type-check

      - name: Run unit tests
        run: npm run test:unit

      - name: Run integration tests
        run: npm run test:integration

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build and push Docker image
        run: |
          docker build -t vise/edu:${{ github.sha }} .
          docker tag vise/edu:${{ github.sha }} vise/edu:latest
          echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
          docker push vise/edu:${{ github.sha }}
          docker push vise/edu:latest

      - name: Run database migrations
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.EDU_SERVER_HOST }}
          username: deploy
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /opt/vise-edu
            docker-compose run --rm app npx prisma migrate deploy

      - name: Deploy application
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.EDU_SERVER_HOST }}
          username: deploy
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /opt/vise-edu
            docker-compose pull
            docker-compose up -d
            docker image prune -f

      - name: Health check
        run: |
          sleep 15
          curl -f https://edu.vln.gg/api/health || exit 1

      - name: Notify deployment
        if: always()
        run: echo "Deployment ${{ job.status }}"
```

## Monitoring & Analytics

### Health Check Endpoint

**app/api/health/route.ts:**

```typescript
import { NextResponse } from 'next/server'
import { prisma } from '@/lib/db'
import { redis } from '@/lib/redis'

export async function GET() {
  const checks = {
    database: false,
    redis: false,
    blockchain: false
  }

  try {
    await prisma.$queryRaw`SELECT 1`
    checks.database = true
  } catch (error) {
    console.error('Database health check failed:', error)
  }

  try {
    await redis.ping()
    checks.redis = true
  } catch (error) {
    console.error('Redis health check failed:', error)
  }

  const healthy = Object.values(checks).every(check => check === true)

  return NextResponse.json(
    { status: healthy ? 'healthy' : 'unhealthy', checks },
    { status: healthy ? 200 : 503 }
  )
}
```

### Performance Monitoring

**lib/monitoring/metrics.ts:**

```typescript
import { Counter, Histogram, Registry } from 'prom-client'

export const register = new Registry()

export const httpRequestDuration = new Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register]
})

export const httpRequestTotal = new Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register]
})

export const blockchainTransactions = new Counter({
  name: 'blockchain_transactions_total',
  help: 'Total blockchain transactions',
  labelNames: ['type', 'status'],
  registers: [register]
})
```

## Cost Estimate

```
VPS (4 vCPU, 8GB RAM):          $40/mo
PostgreSQL (managed):            $25/mo (or included in VPS)
Redis (managed):                 $15/mo (or included in VPS)
Object storage:                  $10/mo
IPFS pinning:                    $20/mo
RPC provider:                    $0-50/mo (depends on usage)
Email (SendGrid):                $15/mo

Total monthly cost:              ~$125-175/mo
```

## Success Metrics

- Daily active users (DAU)
- Course completion rates
- Average time to complete modules
- NFT minting success rate
- API response times (p95, p99)
- Database query performance
- Error rates and types
- User retention (weekly, monthly)
- Governance participation rate

---

**Next:** [mail.vln.gg Setup](./mail-vln-gg-setup.md) | [Back to Architecture](./DEVOPS-ARCHITECTURE.md)
