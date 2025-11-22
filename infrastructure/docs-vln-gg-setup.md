# docs.vln.gg - Documentation Site Setup

**Purpose:** Technical documentation, API references, and developer guides for VISE platform
**Technology:** VitePress (Vue-powered static site generator)
**URL:** https://docs.vln.gg

## Overview

The documentation site serves as the central knowledge base for developers, students, and contributors. It provides comprehensive technical documentation, API references, smart contract documentation, and integration guides.

## Technology Stack

### Framework: VitePress

**Why VitePress?**
- Fast Vue-powered SSG (Static Site Generator)
- Built-in full-text search
- Excellent developer experience
- Git-based content management
- Markdown with Vue component support
- Automatic sidebar generation
- Dark mode support
- Mobile-responsive

**Alternatives Considered:**
- **Docusaurus** - Good, but React-based and heavier
- **GitBook** - Commercial, less control
- **MkDocs** - Python-based, less modern UI

### Content Structure

```
docs/
├── .vitepress/
│   ├── config.ts          # VitePress configuration
│   ├── theme/             # Custom theme components
│   └── components/        # Reusable Vue components
├── guide/
│   ├── getting-started.md
│   ├── installation.md
│   ├── quick-start.md
│   └── concepts.md
├── api/
│   ├── rest-api.md
│   ├── graphql.md
│   └── websocket.md
├── contracts/
│   ├── architecture.md
│   ├── achievement-nft.md
│   ├── governance-token.md
│   ├── staking.md
│   └── abi/              # Contract ABIs
├── integration/
│   ├── web3-wallets.md
│   ├── ipfs.md
│   ├── oracles.md
│   └── subgraphs.md
├── curriculum/
│   ├── overview.md
│   ├── modules/
│   └── exercises/
├── examples/
│   ├── basic-integration.md
│   ├── custom-nft.md
│   └── governance-proposal.md
└── reference/
    ├── cli.md
    ├── sdk.md
    └── errors.md
```

## Setup Instructions

### Prerequisites

```bash
Node.js >= 18
npm >= 9
Git
```

### Installation

```bash
# Create project directory
mkdir vise-docs
cd vise-docs

# Initialize npm project
npm init -y

# Install VitePress
npm install -D vitepress

# Install additional dependencies
npm install -D vue @vueuse/core

# Create directory structure
mkdir -p docs/{.vitepress/{theme,components},guide,api,contracts,integration,curriculum,examples,reference}

# Initialize VitePress
npx vitepress init
```

### Configuration

**docs/.vitepress/config.ts:**

```typescript
import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'VISE Documentation',
  description: 'Technical documentation for VISE - Web3 Education Platform',

  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['meta', { name: 'theme-color', content: '#3eaf7c' }],
    ['meta', { name: 'og:type', content: 'website' }],
    ['meta', { name: 'og:site_name', content: 'VISE Docs' }],
  ],

  themeConfig: {
    logo: '/logo.svg',

    nav: [
      { text: 'Guide', link: '/guide/getting-started' },
      { text: 'API', link: '/api/rest-api' },
      { text: 'Contracts', link: '/contracts/architecture' },
      { text: 'Curriculum', link: '/curriculum/overview' },
      {
        text: 'v1.0.0',
        items: [
          { text: 'Changelog', link: '/changelog' },
          { text: 'Contributing', link: '/contributing' }
        ]
      }
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Getting Started',
          items: [
            { text: 'Introduction', link: '/guide/getting-started' },
            { text: 'Installation', link: '/guide/installation' },
            { text: 'Quick Start', link: '/guide/quick-start' },
            { text: 'Core Concepts', link: '/guide/concepts' }
          ]
        },
        {
          text: 'Fundamentals',
          items: [
            { text: 'Authentication', link: '/guide/authentication' },
            { text: 'NFT Achievements', link: '/guide/achievements' },
            { text: 'Token Economics', link: '/guide/tokenomics' },
            { text: 'Governance', link: '/guide/governance' }
          ]
        }
      ],

      '/api/': [
        {
          text: 'APIs',
          items: [
            { text: 'REST API', link: '/api/rest-api' },
            { text: 'GraphQL', link: '/api/graphql' },
            { text: 'WebSocket', link: '/api/websocket' },
            { text: 'Rate Limits', link: '/api/rate-limits' }
          ]
        }
      ],

      '/contracts/': [
        {
          text: 'Smart Contracts',
          items: [
            { text: 'Architecture', link: '/contracts/architecture' },
            { text: 'Achievement NFT', link: '/contracts/achievement-nft' },
            { text: 'Governance Token', link: '/contracts/governance-token' },
            { text: 'Staking Contract', link: '/contracts/staking' },
            { text: 'Security', link: '/contracts/security' }
          ]
        }
      ],

      '/curriculum/': [
        {
          text: 'Curriculum',
          items: [
            { text: 'Overview', link: '/curriculum/overview' },
            { text: 'Module 1: Prompt Engineering', link: '/curriculum/module-1' },
            { text: 'Module 2: Solidity', link: '/curriculum/module-2' },
            { text: 'Module 3: NFTs', link: '/curriculum/module-3' },
            { text: 'Module 4: Tokenomics', link: '/curriculum/module-4' },
            { text: 'Module 5: Security', link: '/curriculum/module-5' },
            { text: 'Module 6: DevOps', link: '/curriculum/module-6' }
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Fused-Gaming/vise' },
      { icon: 'twitter', link: 'https://twitter.com/VISEedu' },
      { icon: 'discord', link: 'https://discord.gg/vise' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2024-present VISE'
    },

    search: {
      provider: 'local'
    },

    editLink: {
      pattern: 'https://github.com/Fused-Gaming/vise-docs/edit/main/docs/:path',
      text: 'Edit this page on GitHub'
    }
  }
})
```

### Custom Theme

**docs/.vitepress/theme/index.ts:**

```typescript
import DefaultTheme from 'vitepress/theme'
import './custom.css'
import ContractInteraction from '../components/ContractInteraction.vue'
import CodePlayground from '../components/CodePlayground.vue'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    // Register global components
    app.component('ContractInteraction', ContractInteraction)
    app.component('CodePlayground', CodePlayground)
  }
}
```

**docs/.vitepress/theme/custom.css:**

```css
:root {
  --vp-c-brand: #3eaf7c;
  --vp-c-brand-light: #4abf8a;
  --vp-c-brand-lighter: #63d4a0;
  --vp-c-brand-dark: #2d9665;
  --vp-c-brand-darker: #207d50;
}

.dark {
  --vp-c-bg: #0f1419;
  --vp-c-bg-soft: #1a1f26;
}

/* Custom components */
.contract-interaction {
  padding: 1.5rem;
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  margin: 1rem 0;
}

.code-playground {
  background: var(--vp-c-bg-soft);
  border-radius: 8px;
  overflow: hidden;
}
```

## Interactive Components

### Contract Interaction Component

**docs/.vitepress/components/ContractInteraction.vue:**

```vue
<template>
  <div class="contract-interaction">
    <h3>{{ title }}</h3>

    <div v-if="!connected">
      <button @click="connect">Connect Wallet</button>
    </div>

    <div v-else>
      <p>Connected: {{ shortAddress }}</p>

      <div class="method-call">
        <h4>{{ method }}</h4>
        <div v-for="(param, index) in params" :key="index">
          <label>{{ param.name }} ({{ param.type }})</label>
          <input
            v-model="inputs[index]"
            :placeholder="param.placeholder"
          />
        </div>
        <button @click="execute">Execute</button>
      </div>

      <div v-if="result" class="result">
        <h4>Result:</h4>
        <pre>{{ result }}</pre>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { ethers } from 'ethers'

const props = defineProps({
  title: String,
  contractAddress: String,
  abi: Array,
  method: String,
  params: Array
})

const connected = ref(false)
const address = ref('')
const provider = ref(null)
const inputs = ref([])
const result = ref(null)

const shortAddress = computed(() => {
  if (!address.value) return ''
  return `${address.value.slice(0, 6)}...${address.value.slice(-4)}`
})

async function connect() {
  if (typeof window.ethereum !== 'undefined') {
    provider.value = new ethers.BrowserProvider(window.ethereum)
    const accounts = await provider.value.send('eth_requestAccounts', [])
    address.value = accounts[0]
    connected.value = true
  }
}

async function execute() {
  try {
    const signer = await provider.value.getSigner()
    const contract = new ethers.Contract(
      props.contractAddress,
      props.abi,
      signer
    )

    const tx = await contract[props.method](...inputs.value)
    const receipt = await tx.wait()

    result.value = receipt
  } catch (error) {
    result.value = { error: error.message }
  }
}
</script>
```

### API Documentation Generator

**scripts/generate-api-docs.js:**

```javascript
// Auto-generate API documentation from OpenAPI spec
const fs = require('fs')
const path = require('path')

async function generateApiDocs() {
  const spec = require('../api/openapi.json')

  let markdown = `# API Reference\n\n`
  markdown += `Base URL: \`${spec.servers[0].url}\`\n\n`

  for (const [path, methods] of Object.entries(spec.paths)) {
    markdown += `## ${path}\n\n`

    for (const [method, details] of Object.entries(methods)) {
      markdown += `### ${method.toUpperCase()} ${path}\n\n`
      markdown += `${details.description}\n\n`

      if (details.parameters) {
        markdown += `**Parameters:**\n\n`
        details.parameters.forEach(param => {
          markdown += `- \`${param.name}\` (${param.in}): ${param.description}\n`
        })
        markdown += `\n`
      }

      markdown += `**Response:**\n\n`
      markdown += `\`\`\`json\n`
      markdown += JSON.stringify(details.responses['200'].content['application/json'].example, null, 2)
      markdown += `\n\`\`\`\n\n`
    }
  }

  fs.writeFileSync('docs/api/rest-api.md', markdown)
}

generateApiDocs()
```

## Deployment

### Docker Configuration

**Dockerfile:**

```dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run docs:build

FROM nginx:alpine

COPY --from=builder /app/docs/.vitepress/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

**nginx.conf:**

```nginx
server {
    listen 80;
    server_name docs.vln.gg;
    root /usr/share/nginx/html;
    index index.html;

    # Enable gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # SPA fallback
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
}
```

**docker-compose.yml:**

```yaml
version: '3.8'

services:
  docs:
    build: .
    container_name: vise-docs
    restart: unless-stopped
    ports:
      - "3000:80"
    environment:
      - NODE_ENV=production
    networks:
      - vise-network

networks:
  vise-network:
    external: true
```

### GitHub Actions CI/CD

**.github/workflows/deploy-docs.yml:**

```yaml
name: Deploy Documentation

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'
      - '.vitepress/**'
  workflow_dispatch:

jobs:
  deploy:
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

      - name: Build documentation
        run: npm run docs:build

      - name: Build Docker image
        run: |
          docker build -t vise/docs:${{ github.sha }} .
          docker tag vise/docs:${{ github.sha }} vise/docs:latest

      - name: Push to registry
        run: |
          echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
          docker push vise/docs:${{ github.sha }}
          docker push vise/docs:latest

      - name: Deploy to server
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.DOCS_SERVER_HOST }}
          username: deploy
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /opt/vise-docs
            docker-compose pull
            docker-compose up -d
            docker image prune -f

      - name: Verify deployment
        run: |
          sleep 10
          curl -f https://docs.vln.gg || exit 1

      - name: Notify team
        if: always()
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: 'Documentation deployment ${{ job.status }}'
          webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

## Content Guidelines

### Writing Style

- Use clear, concise language
- Include code examples for every concept
- Provide both TypeScript and JavaScript examples
- Link to related documentation
- Include "Prerequisites" section for advanced topics
- Add "Next Steps" at the end of articles

### Code Examples

```markdown
## Example: Mint Achievement NFT

:::tip
Make sure you have completed Module 1 before attempting to mint your first achievement NFT.
:::

<ContractInteraction
  title="Mint PE-1 Token"
  contract-address="0x..."
  :abi="achievementABI"
  method="mint"
  :params="[{ name: 'to', type: 'address' }]"
/>

**Manual Integration:**

```typescript
import { ethers } from 'ethers'
import AchievementNFT from './abi/AchievementNFT.json'

async function mintAchievement(moduleId: number) {
  const provider = new ethers.BrowserProvider(window.ethereum)
  const signer = await provider.getSigner()

  const contract = new ethers.Contract(
    '0x...', // Achievement NFT contract address
    AchievementNFT.abi,
    signer
  )

  const tx = await contract.mint(moduleId)
  const receipt = await tx.wait()

  console.log(`Token minted: ${receipt.transactionHash}`)
}

// Usage
await mintAchievement(1) // Mint PE-1 token
```

:::warning
Always verify transactions on a testnet before deploying to mainnet!
:::
```

### SEO Optimization

**Front matter for all pages:**

```markdown
---
title: Smart Contract Architecture - VISE Docs
description: Learn about the smart contract architecture powering VISE achievement NFTs and governance tokens
head:
  - - meta
    - name: keywords
      content: solidity, smart contracts, NFT, ERC721, governance, VISE
  - - meta
    - property: og:title
      content: VISE Smart Contract Architecture
  - - meta
    - property: og:description
      content: Comprehensive guide to VISE smart contracts
---

# Smart Contract Architecture
```

## Maintenance

### Regular Updates

- **Weekly:** Update changelog, add new examples
- **Monthly:** Review and update deprecated content
- **Quarterly:** Comprehensive content audit
- **On Release:** Update version numbers and migration guides

### Analytics

Track documentation usage with Plausible or Google Analytics:

```typescript
// .vitepress/config.ts
export default defineConfig({
  head: [
    [
      'script',
      {
        defer: '',
        'data-domain': 'docs.vln.gg',
        src: 'https://plausible.io/js/script.js'
      }
    ]
  ]
})
```

## Cost Estimate

```
VitePress hosting (static):     $0 (or ~$5/mo on VPS)
Domain (included in vln.gg):    $0
CDN (Cloudflare):               $0 (free tier)
Build time (GitHub Actions):    $0 (free tier)

Total monthly cost:             $0-5
```

## Success Metrics

- Page views and unique visitors
- Search query analytics
- Time on page
- Bounce rate
- External links to documentation
- GitHub documentation PRs
- User feedback and ratings

---

**Next:** [edu.vln.gg Setup](./edu-vln-gg-setup.md) | [Back to Architecture](./DEVOPS-ARCHITECTURE.md)
