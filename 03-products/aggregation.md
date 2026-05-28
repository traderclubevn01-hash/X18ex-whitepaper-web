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
<div class="x18-flow-process">
<div class="x18-flow-step">
<div class="step-num">1</div>
<div class="step-content"><strong>User Request:</strong> "Buy 100 BNB with my USDC, best price"</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">2</div>
<div class="step-content"><strong>X18 Brain Scan:</strong> Analyzes all liquidity sources and chain combinations in real-time.</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">3</div>
<div class="step-content">
<strong>Options generation:</strong>
<ul style="margin: 4px 0 0 0; padding-left: 16px; font-size: 12px; color: #b0b7c3;">
<li>Option A: 100% on Arbitrum — $250,050 — ⚡ 2s</li>
<li>Option B: 70% Arb + 30% Base — $249,800 — ⏱️ 15s</li>
<li>Option C (AI Optimized): $249,650 — ⏱️ 8s ★ Recommended</li>
</ul>
</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">4</div>
<div class="step-content"><strong>Selection & Execution:</strong> User chooses option and resolver network executes intent.</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">5</div>
<div class="step-content"><strong>Settlement:</strong> Tokens finalized directly into user's wallet.</div>
</div>
</div>

### Gasless Mode
- Users DO NOT need to hold native tokens (BNB, MATIC, etc.) for gas
- Gas is paid by resolvers, factored into the swap price
- Particularly useful for cross-chain: no need for gas tokens on the destination chain

---

> **Next:** [X18 Bot Platform →](bot-platform.md)