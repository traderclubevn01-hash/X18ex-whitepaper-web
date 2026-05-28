# X18 Core Engine

## Hybrid Order Book + AMM Trading Engine

X18 Core is the heart of the entire platform — a trading engine that combines the **Central Limit Order Book (CLOB)** with **Automated Market Maker (AMM)** to achieve both speed and depth of liquidity.

### Mathematical Invariant (The Routing Equation)

The X18ex Unified Matching Engine utilizes a deterministic routing algorithm that dynamically balances execution between the on-chain AMM pools and the off-chain CLOB sequencer. The hybrid liquidity function is defined as:

$$ L_{total} = \alpha \cdot \left( \frac{\Delta y}{\Delta x} \Big|_{x \cdot y = k} \right) + \beta \cdot \sum_{i=1}^{n} (P_i \cdot V_i)_{CLOB} $$

Where:
- $\alpha$ and $\beta$ are dynamic coefficients adjusted in real-time by the **X18 AI Router**, based on gas fees, network congestion, and order size.
- The AMM component relies on the concentrated liquidity formula $x \cdot y = k$ (optimized for specific price ticks).
- The CLOB component calculates exact depth where $P_i$ is the price at tick $i$ and $V_i$ is the available volume.

*By solving this equation for maximum output $y$ given input $x$, X18ex guarantees mathematical zero-slippage routing.*

### Rust Implementation (Pseudo-code)

The core matching engine is written in Rust to achieve memory safety and ultra-low latency (< 50ms). Below is a simplified representation of the `UnifiedMatchingEngine`:

```rust
pub struct UnifiedMatchingEngine<'a> {
    pub clob: &'a mut OrderBook,
    pub amm: &'a mut ConcentratedLiquidityPool,
    pub ai_router: &'a AIRoutingPredictor,
}

impl<'a> UnifiedMatchingEngine<'a> {
    /// Executes trade by optimally splitting volume across CLOB and AMM
    pub fn execute_hybrid_order(&mut self, order: Order) -> Result<ExecutionReceipt, EngineError> {
        // 1. Fetch real-time liquidity depth and gas state
        let clob_depth = self.clob.get_depth(order.price_limit);
        let amm_state = self.amm.get_tick_liquidity(order.price_limit);
        
        // 2. AI calculates dynamic coefficients (α, β) for optimal routing
        let (alpha, beta) = self.ai_router.compute_routing_coefficients(
            order.size, 
            NetworkState::current_gas(), 
            VolatilityMetrics::current()
        );

        // 3. Mathematical zero-slippage distribution
        let volume_to_amm = order.size * alpha;
        let volume_to_clob = order.size * beta;

        // 4. Concurrent atomic execution
        let clob_fill = self.clob.match_order(volume_to_clob, order.price_limit)?;
        let amm_fill = self.amm.swap(volume_to_amm, order.price_limit)?;

        Ok(ExecutionReceipt::new(clob_fill, amm_fill))
    }
}
```

---

## Why Hybrid?

| Model | Advantages | Disadvantages |
|:---|:---|:---|
| **Pure AMM** (PancakeSwap) | Automatic liquidity, permissionless | High slippage, impermanent loss |
| **Pure Order Book** (KiloEx/ApolloX) | High speed, precision | Requires market makers, liquidity cold start |
| **Hybrid** (X18ex) | ✅ Speed + liquidity + permissionless | More complex to build |

---

## Core Engine Architecture

```
┌──────────────────────────────────────────────────────────┐
│                    X18 CORE ENGINE                       │
│                                                          │
│  ┌─────────────────┐         ┌─────────────────────┐    │
│  │   CLOB Engine   │◄───────►│   AMM Engine        │    │
│  │  (Off-chain     │         │  (On-chain           │    │
│  │   Sequencer)    │         │   Concentrated LP)   │    │
│  │                 │         │                      │    │
│  │ • Limit Orders  │         │ • Passive Liquidity  │    │
│  │ • Market Orders │         │ • Custom Curves      │    │
│  │ • Stop Orders   │         │ • Auto-rebalance     │    │
│  │ • TWAP/VWAP     │         │ • Range Orders       │    │
│  └────────┬────────┘         └──────────┬───────────┘    │
│           │                             │                │
│           ▼                             ▼                │
│  ┌──────────────────────────────────────────────────┐    │
│  │              UNIFIED MATCHING ENGINE              │    │
│  │                                                   │    │
│  │  • Best price from CLOB or AMM → auto-route       │    │
│  │  • Smart order splitting across both engines      │    │
│  │  • ZK-Privacy: Zero-Knowledge proofs mask order   │    │
│  │    intent and user identity pre-execution         │    │
│  └────────────────────┬──────────────────────────────┘    │
│                       │                                   │
│                       ▼                                   │
│  ┌──────────────────────────────────────────────────┐    │
│  │      ON-CHAIN SETTLEMENT & DATA AVAILABILITY      │    │
│  │                                                   │    │
│  │  • Fast execution sequenced on opBNB (L2)         │    │
│  │  • Atomic settlement finalized on BSC (L1)        │    │
│  │  • Trade history & Order states on BNB Greenfield │    │
│  └──────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────┘
```

---

## Supported Order Types

### Basic Orders
| Order Type | Description |
|:---|:---|
| **Market Order** | Execute immediately at the best current price |
| **Limit Order** | Set desired price, wait for match |
| **Stop-Loss** | Automatically sell when price drops to a specified level |
| **Take-Profit** | Automatically lock in profit when price reaches target |

### Advanced Orders
| Order Type | Description |
|:---|:---|
| **TWAP** | Time-Weighted Average Price — split over time |
| **VWAP** | Volume-Weighted Average Price — split by volume |
| **Trailing Stop** | Stop-loss that moves with the price |
| **OCO** | One-Cancels-Other — two linked orders |
| **Iceberg** | Hide large order size, display in smaller parts |

### AI-Enhanced Orders (X18 Exclusive)
| Order Type | Description |
|:---|:---|
| **Smart Execute** | AI optimizes timing, splitting, routing |
| **Intent Order** | State intent ("Buy 100 BNB at best price across all chains"), AI handles |
| **Predictive Stop** | AI predicts volatility spike → automatically adjusts stop |

---

## Cross-Margin System

X18ex implements a **Unified Cross-Margin** system — all positions, spot balances, and lending deposits are collectively considered as collateral:

```
┌─────────────────────────────────────────┐
│         UNIFIED MARGIN ACCOUNT          │
│                                         │
│  Spot: 100 BNB ($60,000)               │
│  Perp: Long BTC 2x ($20,000)           │
│  Lending: 5,000 USDC deposited         │
│  ────────────────────────────           │
│  Total Margin: $50,000                  │
│  Used Margin:  $20,000 (Perp)           │
│  Free Margin:  $30,000                  │
│  Health Factor: 2.50 ✅                 │
│                                         │
│  💡 Unrealized profit from BNB spot     │
│     offsets BTC perp margin requirement │
└─────────────────────────────────────────┘
```

**Benefits:**
- Capital efficiency increased by **2-3x** compared to isolated margin
- Reduced liquidation risk due to portfolio netting
- One account for all activities

---

## Performance Targets

| Metric | Target | Comparison |
|:---|:---|:---|
| **Order Latency** | <50ms | Competitors: ~100ms |
| **Orders/Second** | 100,000+ | Competitors: 200K |
| **Settlement Finality** | <2 seconds (L2) | Competitors: ~1s |
| **Uptime** | 99.99% | Industry: 99.9% |
| **Gas Optimization** | 40% less than avg | Via Flash Accounting |

---

## Plugin Hook System

Inspired by programmable liquidity hooks (like PancakeSwap v4 Hooks), X18ex allows developers to attach custom logic to the lifecycle of a pool:

### Hook Points
```
beforeInitialize → afterInitialize
beforeSwap → afterSwap
beforeAddLiquidity → afterAddLiquidity
beforeRemoveLiquidity → afterRemoveLiquidity
beforeSettle → afterSettle
```

### Plugin Use Cases
- **Dynamic Fee Plugin** — Fees adjust based on volatility
- **TWAMM Plugin** — Time-Weighted AMM for large orders
- **KYC Gate Plugin** — Pools for verified users only
- **Yield Optimizer Plugin** — Auto-compound LP rewards
- **Notification Plugin** — Custom alerts when conditions are met

---

> **Next:** [Intelligence Layer — X18 Brain →](intelligence-layer.md)