# Architecture Overview

## X18ex Architecture Overview

X18ex is designed with a **5-layer architecture** (Five-Layer Stack) — each layer addresses a specific group of issues and operates independently yet is tightly interconnected.

---

## Architecture Diagram

<div class="x18-layer-stack">
<div class="x18-stack-layer ecosystem">
<div class="x18-layer-header">🌍 Layer 5: Ecosystem Layer</div>
<div class="x18-layer-body">
<div class="x18-layer-item">Plugin Marketplace</div>
<div class="x18-layer-item">Developer Community</div>
<div class="x18-layer-item">X18 DAO Governance</div>
</div>
</div>

<div class="x18-stack-layer application">
<div class="x18-layer-header">📱 Layer 4: Application Layer</div>
<div class="x18-layer-body">
<div class="x18-layer-item">Web3 Terminal</div>
<div class="x18-layer-item">Mobile App</div>
<div class="x18-layer-item">Bot Dashboard & API Portal</div>
</div>
</div>

<div class="x18-stack-layer integration">
<div class="x18-layer-header">🔌 Layer 3: Integration Layer</div>
<div class="x18-layer-body">
<div class="x18-layer-item">REST API Gateway</div>
<div class="x18-layer-item">WebSocket Feeds</div>
<div class="x18-layer-item">Webhook & Event System</div>
<div class="x18-layer-item">Wallet Abstraction</div>
<div class="x18-layer-item">Cross-chain Bridge</div>
<div class="x18-layer-item">Account Abstraction</div>
</div>
</div>

<div class="x18-stack-layer intelligence">
<div class="x18-layer-header">🧠 Layer 2: Intelligence Layer</div>
<div class="x18-layer-body">
<div class="x18-layer-item">AI Smart Routing</div>
<div class="x18-layer-item">Risk Guardian</div>
<div class="x18-layer-item">ZK Privacy Engine</div>
<div class="x18-layer-item">Portfolio Pilot</div>
<div class="x18-layer-item">MEV Protect Shield</div>
<div class="x18-layer-item">Liquidation Shield</div>
</div>
</div>

<div class="x18-stack-layer protocol">
<div class="x18-layer-header">⚡ Layer 1: Protocol Layer</div>
<div class="x18-layer-body">
<div class="x18-layer-item">Hybrid Order Book + AMM</div>
<div class="x18-layer-item">Perpetuals Engine</div>
<div class="x18-layer-item">Lending & Borrowing</div>
<div class="x18-layer-item">Liquidity Pools</div>
<div class="x18-layer-item">Settlement Layer</div>
<div class="x18-layer-item">Plugin Hook Engine</div>
</div>
</div>

<div class="x18-stack-layer multichain">
<div class="x18-layer-header">⛓️ Multi-Chain Substrate</div>
<div class="x18-layer-body">
<div class="x18-layer-item">BNB Chain (BSC)</div>
<div class="x18-layer-item">Arbitrum (ARB)</div>
<div class="x18-layer-item">Base</div>
<div class="x18-layer-item">opBNB</div>
<div class="x18-layer-item">Polygon (POL)</div>
<div class="x18-layer-item">Solana (SOL)</div>
<div class="x18-layer-item">Avalanche (AVAX)</div>
<div class="x18-layer-item">Optimism (OP)</div>
</div>
</div>
</div>

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