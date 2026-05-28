import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "X18ex Whitepaper",
  description: "The Ultimate BSC-Native Institutional DEX. Speed of CEX, transparency of DEX, intelligence of AI.",
  
  // Clean, dark theme by default
  appearance: 'dark',
  
  themeConfig: {
    logo: '/logo.png', // Logo will be copied to public folder or served statically
    
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Introduction', link: '/01-introduction/executive-summary' },
      { text: 'Technology', link: '/02-technology/architecture-overview' },
      { text: 'Tokenomics', link: '/04-tokenomics/token-overview' },
      { text: 'Launch App', link: 'https://x18ex.com' }
    ],

    sidebar: [
      {
        text: '🌟 Introduction',
        items: [
          { text: 'Executive Summary', link: '/01-introduction/executive-summary' },
          { text: 'The Problem', link: '/01-introduction/the-problem' },
          { text: 'Vision, Mission & Objectives', link: '/01-introduction/the-vision' },
          { text: 'Why X18', link: '/01-introduction/why-x18' }
        ]
      },
      {
        text: '⚡ Technology & Architecture',
        items: [
          { text: 'Architecture Overview', link: '/02-technology/architecture-overview' },
          { text: 'X18 Core Engine', link: '/02-technology/core-engine' },
          { text: 'Intelligence Layer — X18 Brain', link: '/02-technology/intelligence-layer' },
          { text: 'Cross-Chain Infrastructure', link: '/02-technology/cross-chain' },
          { text: 'MEV Protection & Security', link: '/02-technology/mev-protection' }
        ]
      },
      {
        text: '🛠️ Products & Features',
        items: [
          { text: 'Spot Trading', link: '/03-products/spot-trading' },
          { text: 'Perpetuals & Derivatives', link: '/03-products/perpetuals' },
          { text: 'Smart Aggregation', link: '/03-products/aggregation' },
          { text: 'AI Bots Integrated Exchange', link: '/03-products/ai-bots' },
          { text: 'X18 Bot Platform & SDK', link: '/03-products/bot-platform' },
          { text: 'AI Trading Assistant', link: '/03-products/ai-assistant' },
          { text: 'X18 Game — Play & Earn', link: '/03-products/x18-game' },
          { text: 'Plugin Ecosystem', link: '/03-products/plugin-ecosystem' },
          { text: 'Portfolio Manager', link: '/03-products/portfolio-manager' }
        ]
      },
      {
        text: '💎 Tokenomics — $X18',
        items: [
          { text: 'Token Overview', link: '/04-tokenomics/token-overview' },
          { text: 'Distribution & Vesting', link: '/04-tokenomics/distribution' },
          { text: '🔥 Node Sale Program', link: '/04-tokenomics/node-sale' },
          { text: '📈 Why Does $X18 Increase in Value?', link: '/04-tokenomics/why-x18-grows' },
          { text: '🧠 Smart Node Sale Strategy', link: '/04-tokenomics/node-sale-strategy' },
          { text: 'Deflationary Mechanics', link: '/04-tokenomics/deflationary' },
          { text: 'Revenue Model', link: '/04-tokenomics/revenue-model' }
        ]
      },
      {
        text: '🏛️ Governance — X18 DAO',
        items: [
          { text: 'Governance Framework', link: '/05-governance/framework' },
          { text: 'Proposal System — XIP', link: '/05-governance/xip-system' },
          { text: 'Progressive Decentralization', link: '/05-governance/decentralization' }
        ]
      },
      {
        text: '🗺️ Roadmap',
        items: [
          { text: 'Development Phases', link: '/06-roadmap/phases' },
          { text: 'Milestones Tracker', link: '/06-roadmap/milestones' }
        ]
      },
      {
        text: '🛡️ Security',
        items: [
          { text: 'Smart Contract Security', link: '/07-security/smart-contracts' },
          { text: 'Operational Security', link: '/07-security/operational-security' }
        ]
      },
      {
        text: '👥 Team & Community',
        items: [
          { text: 'Core Team', link: '/08-team/core-team' },
          { text: 'Partners & Backers', link: '/08-team/partners' }
        ]
      },
      {
        text: '📚 Resources',
        items: [
          { text: 'Technical Documentation', link: '/09-resources/technical-docs' },
          { text: 'Glossary', link: '/09-resources/glossary' },
          { text: 'Brand Kit & Media', link: '/09-resources/brand-kit' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'twitter', link: 'https://twitter.com/X18ex_Official' },
      { icon: 'github', link: 'https://github.com/traderclubevn01-hash/X18ex-whitepaper' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2026-present X18ex Ecosystem'
    }
  }
})
