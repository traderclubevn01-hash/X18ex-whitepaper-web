# Cross-Chain Infrastructure

## Chain Abstraction: Users Need Not Know the Chain

X18ex implements a **Chain Abstraction** architecture — users only see assets and markets, without needing to know which chain they reside on.

---

## Intent-Based Cross-Chain Protocol

```
┌──────────────────────────────────────────────────────┐
│                  USER EXPERIENCE                     │
│                                                      │
│  "Swap 100 BNB → USDC at best price"                 │
│  (User doesn't know BNB is on opBNB,                 │
│   best USDC pool is on Base)                         │
│                                                      │
└─────────────────────┬────────────────────────────────┘
                      │
┌─────────────────────▼────────────────────────────────┐
│              X18 INTENT RESOLVER                     │
│                                                      │
│  1. Parse user intent                                │
│  2. Scan liquidity: BSC, opBNB, Arbitrum, Base       │
│  3. Calculate: direct swap vs cross-chain route      │
│  4. Factor: gas, slippage, bridge risk, speed        │
│  5. Present best option to user                      │
│                                                      │
│  Result: Split 70% Arbitrum + 30% Base               │
│  Savings: 0.4% better vs single-chain                │
│                                                      │
└─────────────────────┬────────────────────────────────┘
                      │
┌─────────────────────▼────────────────────────────────┐
│           RESOLVER NETWORK (Execution)               │
│                                                      │
│  Professional market makers compete to fill          │
│  the intent at or better than quoted price.          │
│                                                      │
│  • Dutch auction mechanism                           │
│  • Staked $X18 as collateral                         │
│  • Slashing for failed fills                         │
│                                                      │
└─────────────────────┬────────────────────────────────┘
                      │
┌─────────────────────▼────────────────────────────────┐
│             SETTLEMENT & VERIFICATION                │
│                                                      │
│  On-chain escrow contracts on both chains            │
│  Atomic settlement: both sides or neither            │
│  No custodial risk, no bridge token exposure         │
│                                                      │
└──────────────────────────────────────────────────────┘
```

---

## Supported Chains

### Day 1 — Launch Chains

| Chain | Type | TVL | Reason |
|:---|:---|:---|:---|
| **BNB Chain** | L1 | $50B+ | High throughput, massive ecosystem |
| **Arbitrum** | L2 | $15B+ | DeFi hub, low gas, fast |
| **Base** | L2 | $10B+ | Coinbase ecosystem, retail growth |
| **BSC** | L1 | $8B+ | Massive volume, low cost |
| **Polygon** | L2 | $5B+ | Enterprise adoption |

### Month 6-12 — Expansion

| Chain | Type | Reason |
|:---|:---|:---|
| **Solana** | L1 (non-EVM) | Speed champion, growing DeFi |
| **Avalanche** | L1 | Institutional DeFi, subnets |
| **Optimism** | L2 | Superchain ecosystem |

### Year 2 — Full Coverage
Sei, Mantle, Blast, zkSync, Scroll, Linea, Aptos, Sui

---

## Unified Liquidity Pool

Instead of each chain having separate liquidity, X18ex creates a **Unified Liquidity Layer**:

```
Traditional:
  BNB/USDC on opBNB: $50M liquidity
  BNB/USDC on Base:     $20M liquidity
  BNB/USDC on BSC:      $30M liquidity
  → User on Arbitrum only accesses $50M

X18ex Unified:
  BNB/USDC across all chains: $100M unified liquidity
  → User on ANY chain accesses the entire $100M
  → Slippage reduced 3-5x for large trades
```

---

## Security Model

### No Use of Traditional Bridge

X18ex **DOES NOT** use traditional lock-and-mint bridges (source of >$2.5B hacks). Instead:

| Traditional Bridge | X18 Cross-Chain |
|:---|:---|
| Lock tokens on Chain A | Intent signed by user |
| Mint wrapped tokens on Chain B | Resolvers fill on target chain |
| ❌ Wrapped tokens = custodial risk | ✅ Native tokens, no wrapping |
| ❌ Bridge contract = honeypot | ✅ Escrow with atomic settlement |
| ❌ Single point of failure | ✅ Distributed resolver network |

### Fallback & Safety

- **Timeout Protection**: If fill is not completed within 10 minutes → auto-refund
- **Resolver Insurance**: Resolvers stake $X18 → slashed if failed fill
- **Multi-sig Escrow**: Escrow contracts are audited, multi-sig upgradeable

---

> **Next:** [MEV Protection & Security →](mev-protection.md)