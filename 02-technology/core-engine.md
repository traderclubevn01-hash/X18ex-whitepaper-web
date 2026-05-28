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

<div class="x18-diagram-box">
<div class="x18-diagram-title">X18 CORE ENGINE ARCHITECTURE</div>

<div class="x18-diagram-row cols-2">
<div class="x18-diagram-card">
<div class="card-icon">📖</div>
<div class="card-title">CLOB Engine</div>
<div class="card-desc">
<strong>Off-chain Sequencer</strong>
<ul style="text-align: left; margin: 8px 0 0 0; padding-left: 16px; font-size: 12px; color: #b0b7c3;">
<li>Limit Orders</li>
<li>Market Orders</li>
<li>Stop Orders</li>
<li>TWAP/VWAP</li>
</ul>
</div>
</div>

<div class="x18-diagram-card">
<div class="card-icon">🎛️</div>
<div class="card-title">AMM Engine</div>
<div class="card-desc">
<strong>On-chain Concentrated LP</strong>
<ul style="text-align: left; margin: 8px 0 0 0; padding-left: 16px; font-size: 12px; color: #b0b7c3;">
<li>Passive Liquidity</li>
<li>Custom Curves</li>
<li>Auto-rebalance</li>
<li>Range Orders</li>
</ul>
</div>
</div>
</div>

<div class="x18-flow-arrow">▼</div>

<div class="x18-diagram-row cols-1">
<div class="x18-diagram-card" style="border-color: rgba(155, 81, 224, 0.4) !important;">
<div class="card-icon">🧠</div>
<div class="card-title">UNIFIED MATCHING ENGINE</div>
<div class="card-desc">
• Best price from CLOB or AMM → auto-route<br/>
• Smart order splitting across both engines<br/>
• ZK-Privacy: Zero-Knowledge proofs mask order intent and user identity pre-execution
</div>
</div>
</div>

<div class="x18-flow-arrow">▼</div>

<div class="x18-diagram-row cols-1">
<div class="x18-diagram-card" style="border-color: rgba(0, 242, 254, 0.4) !important;">
<div class="card-icon">⛓️</div>
<div class="card-title">ON-CHAIN SETTLEMENT & DATA AVAILABILITY</div>
<div class="card-desc">
• Fast execution sequenced on opBNB (L2)<br/>
• Atomic settlement finalized on BSC (L1)<br/>
• Trade history & Order states on BNB Greenfield
</div>
</div>
</div>
</div>


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

<div class="x18-diagram-box" style="max-width: 480px; margin: 30px auto;">
<div class="x18-diagram-title" style="color: #60a5fa;">UNIFIED MARGIN ACCOUNT</div>
<ul class="x18-node-details" style="margin: 10px 0 !important;">
<li><span class="label">💰 Spot Assets</span><span class="value" style="color: #34d399;">100 BNB ($60,000)</span></li>
<li><span class="label">📈 Perp Positions</span><span class="value" style="color: #60a5fa;">Long BTC 2x ($20,000)</span></li>
<li><span class="label">🏦 Lending Deposits</span><span class="value" style="color: #a78bfa;">5,000 USDC</span></li>
<li style="border-bottom: 2px solid rgba(255,255,255,0.1); padding-bottom: 12px; margin-bottom: 8px !important;"></li>
<li><span class="label">Total Collateral Value</span><span class="value">$50,000</span></li>
<li><span class="label">Used Margin</span><span class="value">$20,000</span></li>
<li><span class="label">Free Margin</span><span class="value" style="color: #34d399;">$30,000</span></li>
<li><span class="label">Health Factor</span><span class="value" style="color: #34d399;">2.50 ✅</span></li>
</ul>
<div style="font-size: 12px; color: #fcd34d; background: rgba(245, 158, 11, 0.05); padding: 10px; border-radius: 6px; border: 1px solid rgba(245, 158, 11, 0.15); margin-top: 8px;">
💡 <strong>Unrealized profit</strong> from BNB spot offsets BTC perp margin requirements.
</div>
</div>

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
<div class="x18-flow-process">
<div class="x18-flow-step">
<div class="step-num">1</div>
<div class="step-content"><strong>Initialization:</strong> beforeInitialize ➜ afterInitialize</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">2</div>
<div class="step-content"><strong>Swap execution:</strong> beforeSwap ➜ afterSwap</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">3</div>
<div class="step-content"><strong>Liquidity additions:</strong> beforeAddLiquidity ➜ afterAddLiquidity</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">4</div>
<div class="step-content"><strong>Liquidity withdrawals:</strong> beforeRemoveLiquidity ➜ afterRemoveLiquidity</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">5</div>
<div class="step-content"><strong>Settlement finalization:</strong> beforeSettle ➜ afterSettle</div>
</div>
</div>

### Plugin Use Cases
- **Dynamic Fee Plugin** — Fees adjust based on volatility
- **TWAMM Plugin** — Time-Weighted AMM for large orders
- **KYC Gate Plugin** — Pools for verified users only
- **Yield Optimizer Plugin** — Auto-compound LP rewards
- **Notification Plugin** — Custom alerts when conditions are met

---

> **Next:** [Intelligence Layer — X18 Brain →](intelligence-layer.md)