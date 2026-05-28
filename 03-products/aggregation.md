# Smart Aggregation

## Find the Best Price Across All Chains, All Sources

X18 Route is an aggregation engine that scans **200+ liquidity sources** across **10+ chains** to ensure users always receive the best possible price.

---

## Comparison with Competitors

| Feature | 1inch | Jupiter | X18ex |
|:---|:---:|:---:|:---:|
| EVM Aggregation | ✅ | ❌ | ✅ |
| Solana Aggregation | ❌ | ✅ | ✅ |
| Cross-chain routing | ✅ (Fusion+) | ❌ | ✅ |
| AI-powered routing | ❌ | ❌ | ✅ |
| Gasless execution | ✅ | ❌ | ✅ |
| MEV Protection | ✅ | Partial | ✅ |
| Integrated spot/perp | ❌ | ✅ | ✅ |

---

## Liquidity Sources

### DEX Protocols
PancakeSwap V2/V3/V4, ApolloX, Venus, BiSwap, Thena, SushiSwap, Curve, Balancer, Trader Joe, Raydium, Orca, and 190+ other protocols across BSC and multi-chain.

### Private Liquidity
- Professional market makers (RFQ system)
- OTC desks for large trades
- X18 native pools

### Cross-chain Sources
- All DEXs on every supported chain
- Bridge liquidity pools
- Resolver network fill capacity

---

## Intent-Based Execution

### Flow
```
1. User: "Buy 100 BNB with my USDC, best price"
         │
2. X18 Brain: Scan all sources, all chains
         │
3. Options presented:
   ├── Option A: 100% on Arbitrum — $250,050 — ⚡ 2s
   ├── Option B: 70% Arb + 30% Base — $249,800 — ⏱️ 15s
   └── Option C: AI Optimized — $249,650 — ⏱️ 8s ★ Recommended
         │
4. User selects → Resolver network executes
         │
5. Settlement → Tokens in user wallet
```

### Gasless Mode
- Users DO NOT need to hold native tokens (BNB, MATIC, etc.) for gas
- Gas is paid by resolvers, factored into the swap price
- Particularly useful for cross-chain: no need for gas tokens on the destination chain

---

> **Next:** [X18 Bot Platform →](bot-platform.md)