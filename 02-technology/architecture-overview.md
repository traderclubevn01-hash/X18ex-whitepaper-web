# Architecture Overview

## X18ex Architecture Overview

X18ex is designed with a **5-layer architecture** (Five-Layer Stack) — each layer addresses a specific group of issues and operates independently yet is tightly interconnected.

---

## Architecture Diagram

```
╔══════════════════════════════════════════════════════════════════╗
║                    🌍 ECOSYSTEM LAYER                          ║
║  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐  ║
║  │   Plugin     │  │  Developer   │  │     X18 DAO          │  ║
║  │ Marketplace  │  │  Community   │  │   Governance         │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
╠═════════╪══════════════════╪═════════════════════╪══════════════╣
║         │          📱 APPLICATION LAYER          │              ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │   Web3       │  │   Mobile     │  │   Bot Dashboard      │  ║
║  │  Terminal    │  │     App      │  │   & API Portal       │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
╠═════════╪══════════════════╪═════════════════════╪══════════════╣
║         │          🔌 INTEGRATION LAYER          │              ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │  REST API    │  │  WebSocket   │  │   Webhook &          │  ║
║  │  Gateway     │  │   Feeds      │  │   Event System       │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │  Wallet      │  │  Cross-chain │  │   Account            │  ║
║  │ Abstraction  │  │   Bridge     │  │   Abstraction        │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
╠═════════╪══════════════════╪═════════════════════╪══════════════╣
║         │          🧠 INTELLIGENCE LAYER         │              ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │  AI Smart    │  │   Risk       │  │   ZK Privacy         │  ║
║  │  Routing     │  │  Guardian    │  │     Engine           │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │  Portfolio   │  │  MEV Protect │  │   Liquidation        │  ║
║  │   Pilot      │  │    Shield    │  │     Shield           │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
╠═════════╪══════════════════╪═════════════════════╪══════════════╣
║         │          ⚡ PROTOCOL LAYER              │              ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │  Hybrid      │  │ Perpetuals   │  │   Lending &          │  ║
║  │ Order Book   │  │   Engine     │  │   Borrowing          │  ║
║  │   + AMM      │  │              │  │                      │  ║
║  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘  ║
║  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────────┴───────────┐  ║
║  │  Liquidity   │  │  Settlement  │  │   Plugin Hook        │  ║
║  │    Pools     │  │    Layer     │  │     Engine            │  ║
║  └──────────────┘  └──────────────┘  └──────────────────────┘  ║
╠══════════════════════════════════════════════════════════════════╣
║                   ⛓️ MULTI-CHAIN SUBSTRATE                     ║
║  ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐     ║
║  │BSC │ │ARB │ │BASE│ │opBNB│ │POL │ │SOL │ │AVAX│ │OP  │    ║
║  └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘     ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## Description of Each Layer

### ⚡ Layer 1: Protocol Layer — "The Foundation"

The foundational layer where all transaction logic occurs on-chain.

| Component | Function | Reference Technology |
|:---|:---|:---|
| **Hybrid Order Book + AMM** | Combines CLOB speed with AMM liquidity | ApolloX V2 + PancakeSwap V4 Hooks |
| **Perpetuals Engine** | Perpetual futures contracts, leverage up to 50x | ApolloX + KiloEx |
| **Lending & Borrowing** | Integrated lending/borrowing within margin | Venus Protocol |
| **Liquidity Pools** | Concentrated liquidity + custom curves | PancakeSwap V4 Hooks |
| **Settlement & Data Layer** | On-chain settlement and Decentralized Storage | BSC / opBNB + BNB Greenfield |
| **Plugin Hook Engine** | Extends functionality via smart contract plugins | PancakeSwap V4 Hooks |

### 🧠 Layer 2: Intelligence Layer — "The Brain"

The AI layer that creates the core differentiation — unmatched by others.

| Component | Function |
|:---|:---|
| **AI Smart Routing** | ML model scans 200+ liquidity sources, predicts slippage & gas |
| **Risk Guardian** | Real-time risk scoring for every trade and position |
| **MEV Protection Shield** | AI detects and prevents MEV attacks |
| **Zero-Knowledge (ZK) Privacy Engine** | Cryptographic proofs for private order matching and user data protection |
| **Portfolio Pilot** | AI automatically rebalances and optimizes portfolios |
| **Market Sentiment** | NLP analyzes social feeds → trading signals |
| **Liquidation Shield** | Predicts liquidation risk 15 minutes ahead, auto-hedge |

### 🔌 Layer 3: Integration Layer — "The Connectors"

The connecting layer between protocol and applications.

| Component | Function |
|:---|:---|
| **REST API Gateway** | Full trading, data, account management API |
| **WebSocket Feeds** | Real-time orderbook, trades, positions, alerts |
| **Webhook System** | Push notifications for events: fills, liquidations |
| **Wallet Abstraction** | Connects all wallet types: EOA, Smart Account, MPC |
| **Cross-chain Bridge** | Intent-based bridging, secure, non-custodial |
| **Account Abstraction & ZK Auth** | Gasless transactions, session keys, zero-trust authentication |

### 📱 Layer 4: Application Layer — "The Interface"

The user interface layer.

| Component | Function |
|:---|:---|
| **Web3 Trading Terminal** | Full-featured trading interface, TradingView charts |
| **Mobile App** | iOS/Android native app |
| **Bot Dashboard** | API key management, strategy deployment, performance analytics |

### 🌍 Layer 5: Ecosystem Layer — "The Community"

The open ecosystem layer.

| Component | Function |
|:---|:---|
| **Plugin Marketplace** | Buy/sell/share plugins |
| **Developer Community** | Grants, hackathons, documentation |
| **X18 DAO** | Governance, treasury, proposals |

---

## Multi-Chain Substrate

X18ex supports multi-chain from day one through **Chain Abstraction** architecture:

### Phase 1 — Launch Chains
| Chain | Type | Reason |
|:---|:---|:---|
| **BNB Chain** | L1 | Fast finality, massive liquidity, institutional trust |
| **Arbitrum** | L2 | Low gas, fast, strong DeFi ecosystem |
| **Base** | L2 | Coinbase ecosystem, retail onboarding |
| **opBNB** | L2 | High volume, extreme low cost, fast finality |

### Phase 2 — Expansion Chains
| Chain | Type | Reason |
|:---|:---|:---|
| **Polygon** | L2 | Massive user base, enterprise |
| **Solana** | L1 | Highest speed, non-EVM diversity |
| **Avalanche** | L1 | Institutional DeFi, subnets |
| **Optimism** | L2 | Superchain ecosystem |

### Phase 3 — Full Coverage
- Sei, Mantle, Blast, zkSync, Scroll, Linea
- Non-EVM: Aptos, Sui (research phase)

---

## Architectural Philosophy

### Modular, Not Monolithic
Each module can be upgraded independently. Upgrading the perpetuals engine does not affect spot trading.

### Open Core, Plugin Extensions
Core protocol is open-source. Extensions via plugin marketplace allow for community-driven innovation.

### On-chain Settlement, Off-chain Speed
Order matching is off-chain for speed. Settlement is on-chain for transparency and security.

### AI-Enhanced, Not AI-Dependent
AI optimizes everything, but the protocol still functions perfectly if the AI layer is offline. No single point of failure.

---

> **Next:** [X18 Core Engine →](core-engine.md)