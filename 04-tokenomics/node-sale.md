# Initial Node Sale Program

## X18 Node Sale — Asset Growth from Day One

The initial Node sale program allows users to **invest early** in the X18ex ecosystem, receive exclusive benefits, and start mining $X18 tokens before the platform officially launches.

---

## Program Overview

| Information | Details |
|:---|:---|
| **Sale Duration** | **3 months** (countdown clock in dashboard) |
| **$X18 Reference Price** | **$1.00 / token** |
| **Node Types** | 3 packages: $1,000, $5,000, $10,000 |
| **Total Nodes** | **2,300 packages** (finite, no additional issuance) |
| **After Expiry** | Nodes cease operation, no additional packages issued |
| **Unsold Nodes** | **Completely Burned** — increases scarcity |

---

## Node Packages

<div class="x18-node-grid">
<!-- Bronze Package -->
<div class="x18-node-card bronze">
<div class="x18-node-badge">🥉 Tier 1</div>
<div class="x18-node-title">$1,000 Package</div>
<ul class="x18-node-details">
<li><span class="label">Purchase Price</span><span class="value">$1,000</span></li>
<li><span class="label">$X18 Received</span><span class="value">1,000</span></li>
<li><span class="label">Total Quantity</span><span class="value">1,000 packages</span></li>
<li><span class="label">Benefit Level</span><span class="value">V1</span></li>
<li><span class="label">Mining Rate</span><span class="value">8% / month</span></li>
<li><span class="label">Purchase Bonus</span><span class="value">0%</span></li>
</ul>
<a href="#" class="x18-node-btn">Buy Node Now</a>
</div>

<!-- Silver Package -->
<div class="x18-node-card silver">
<div class="x18-node-badge">🥈 Tier 2</div>
<div class="x18-node-title">$5,000 Package</div>
<ul class="x18-node-details">
<li><span class="label">Purchase Price</span><span class="value">$5,000</span></li>
<li><span class="label">$X18 Received</span><span class="value">5,000</span></li>
<li><span class="label">Total Quantity</span><span class="value">1,000 packages</span></li>
<li><span class="label">Benefit Level</span><span class="value">V2</span></li>
<li><span class="label">Mining Rate</span><span class="value">9% / month</span></li>
<li><span class="label">Purchase Bonus</span><span class="value">5% (+250 X18)</span></li>
</ul>
<a href="#" class="x18-node-btn">Buy Node Now</a>
</div>

<!-- Gold Package -->
<div class="x18-node-card gold">
<div class="x18-node-badge">🥇 Tier 3 (Best Value)</div>
<div class="x18-node-title">$10,000 Package</div>
<ul class="x18-node-details">
<li><span class="label">Purchase Price</span><span class="value">$10,000</span></li>
<li><span class="label">$X18 Received</span><span class="value">10,000</span></li>
<li><span class="label">Total Quantity</span><span class="value">300 packages</span></li>
<li><span class="label">Benefit Level</span><span class="value">V3</span></li>
<li><span class="label">Mining Rate</span><span class="value">10% / month</span></li>
<li><span class="label">Purchase Bonus</span><span class="value">10% (+1,000 X18)</span></li>
</ul>
<a href="#" class="x18-node-btn">Buy Node Now</a>
</div>
</div>

### Detailed Benefits Table

| Information | 🥉 $1,000 Package | 🥈 $5,000 Package | 🥇 $10,000 Package |
|:---|:---:|:---:|:---:|
| **Purchase Price** | $1,000 | $5,000 | $10,000 |
| **$X18 Tokens Received** | 1,000 | 5,000 | 10,000 |
| **Package Quantity** | 1,000 packages | 1,000 packages | 300 packages |
| **Benefit Level** | V1 | V2 | V3 |
| **Mining Rate** | 8% / month | 9% / month | 10% / month |
| **Purchase Bonus** | 0% | +5% (+250 X18) | +10% (+1,000 X18) |
| **Total X18 Received** | 1,000 | **5,250** | **11,000** |

---

## Operational Mechanism

### Smart Contract: Trustless Node Manager
To guarantee transparency, the entire Node Sale is governed by an immutable smart contract. Below is a simplified snippet of the core logic:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract X18NodeManager {
    uint256 public constant SALE_DURATION = 90 days;
    uint256 public saleStartTime;
    uint256 public totalNodesSold;
    
    struct Node {
        uint256 lockedTokens;
        uint256 monthlyYieldRate;
        uint256 lastClaimTime;
    }
    
    mapping(address => Node) public userNodes;

    function purchaseNode(uint256 _tier) external payable {
        require(block.timestamp <= saleStartTime + SALE_DURATION, "Sale ended");
        require(_tier == 1 || _tier == 5 || _tier == 10, "Invalid tier");
        
        // Lock tokens and set yield parameters based on tier
        uint256 tokensToLock = calculateTokens(_tier);
        uint256 yieldRate = calculateYieldRate(_tier);
        
        userNodes[msg.sender] = Node(tokensToLock, yieldRate, block.timestamp);
        totalNodesSold++;
    }

    function burnUnsoldTokens() external {
        require(block.timestamp > saleStartTime + SALE_DURATION, "Sale active");
        uint256 unsoldTokens = getUnsoldTokens();
        IX18Token(tokenAddress).burn(unsoldTokens); // Mathematical scarcity guaranteed
    }
}
```

### 1. Node Purchase
<div class="x18-flow-process">
<div class="x18-flow-step">
<div class="step-num">1</div>
<div class="step-content"><strong>Buy Node:</strong> User purchases Node package ($1,000 / $5,000 / $10,000)</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">2</div>
<div class="step-content"><strong>Allocating:</strong> $X18 tokens are allocated to the user's account</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step" style="border-left-color: #ef4444;">
<div class="step-num" style="border-color: #ef4444; color: #ef4444; background: rgba(239, 68, 68, 0.05);">3</div>
<div class="step-content"><strong>Token Lock:</strong> All tokens are locked (cannot withdraw, sell, or transfer)</div>
</div>
<div class="x18-flow-arrow">▼</div>
<div class="x18-flow-step">
<div class="step-num">4</div>
<div class="step-content"><strong>Mining:</strong> Mining starts automatically, gradually paying yields</div>
</div>
</div>

### 2. Mining & Unlock
<div class="x18-diagram-box">
<div class="x18-diagram-title">Monthly Yields & Payouts</div>
<ul class="x18-node-details" style="margin: 10px 0 !important;">
<li><span class="label">🥉 $1,000 Package</span><span class="value">8% × 1,000 = 80 X18/month</span></li>
<li><span class="label">🥈 $5,000 Package</span><span class="value">9% × 5,250 = 472.5 X18/month</span></li>
<li><span class="label">🥇 $10,000 Package</span><span class="value">10% × 11,000 = 1,100 X18/month</span></li>
</ul>
<div style="font-size: 13px; color: #10b981; text-align: center; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 14px; margin-top: 10px; font-weight: 700;">
✔ Yield rewards are 100% unlocked and can be:
</div>
<div class="x18-diagram-row cols-4" style="margin-top: 12px;">
<div class="x18-diagram-card" style="min-height: auto; padding: 8px;">
<div style="font-size: 12px; font-weight: 700;">HODL</div>
</div>
<div class="x18-diagram-card" style="min-height: auto; padding: 8px;">
<div style="font-size: 12px; font-weight: 700;">Trade on DEX</div>
</div>
<div class="x18-diagram-card" style="min-height: auto; padding: 8px;">
<div style="font-size: 12px; font-weight: 700;">Stake for Yield</div>
</div>
<div class="x18-diagram-card" style="min-height: auto; padding: 8px;">
<div style="font-size: 12px; font-weight: 700;">Use in Game</div>
</div>
</div>
</div>

### 3. Token Lock & Release
> **Important**: All $X18 Tokens purchased in the initial package will be **LOCKED** and only released monthly through the mining mechanism. This design aims to:
> - **Protect token price** — Prevent dumping immediately after purchase
> - **Long-term commitment** — Incentivize holders to retain and engage with the ecosystem
> - **Even distribution** — Tokens are gradually unlocked, avoiding sell pressure

---

## Countdown Clock

The Node sale program features a **countdown clock** displayed in each user's dashboard:

<div class="x18-countdown-container">
<div class="x18-countdown-header">⏱️ NODE SALE COUNTDOWN</div>
<div class="x18-countdown-timer">
<div class="x18-timer-unit"><div class="x18-timer-num">67</div><div class="x18-timer-label">Days</div></div>
<div class="x18-timer-unit"><div class="x18-timer-num">14</div><div class="x18-timer-label">Hours</div></div>
<div class="x18-timer-unit"><div class="x18-timer-num">32</div><div class="x18-timer-label">Minutes</div></div>
</div>

<div class="x18-progress-list">
<!-- Bronze Progress -->
<div class="x18-progress-item bronze">
<div class="x18-progress-labels">
<span class="x18-progress-name">🥉 $1,000 Package</span>
<span class="x18-progress-sold">680 / 1,000 sold (68%)</span>
</div>
<div class="x18-progress-bar-bg"><div class="x18-progress-bar"></div></div>
</div>

<!-- Silver Progress -->
<div class="x18-progress-item silver">
<div class="x18-progress-labels">
<span class="x18-progress-name">🥈 $5,000 Package</span>
<span class="x18-progress-sold">720 / 1,000 sold (72%)</span>
</div>
<div class="x18-progress-bar-bg"><div class="x18-progress-bar"></div></div>
</div>

<!-- Gold Progress -->
<div class="x18-progress-item gold">
<div class="x18-progress-labels">
<span class="x18-progress-name">🥇 $10,000 Package</span>
<span class="x18-progress-sold">255 / 300 sold (85%)</span>
</div>
<div class="x18-progress-bar-bg"><div class="x18-progress-bar"></div></div>
</div>
</div>

<div class="x18-countdown-footer">
📊 <strong>Total sold: 1,655 / 2,300 (71.9%)</strong><br/>
🔥 Unsold Nodes after 3 months → Permanently BURNED
</div>
</div>

---

## Benefit Levels (V1, V2, V3)

| Benefits | V1 ($1,000 Package) | V2 ($5,000 Package) | V3 ($10,000 Package) |
|:---|:---:|:---:|:---:|
| Mining $X18 monthly | ✅ 8% | ✅ 9% | ✅ 10% |
| Fee discount on DEX | 10% | 25% | 40% |
| AI Premium access | ❌ | ✅ Basic | ✅ Full |
| Bot API Pro tier | ❌ | ✅ | ✅ |
| X18 Game VIP | ❌ | ✅ Silver | ✅ Gold |
| Governance voting | ✅ 1x | ✅ 1.5x | ✅ 2x |
| Private community access | ❌ | ✅ | ✅ |
| Priority support | ❌ | ❌ | ✅ |
| Early access to new features | ❌ | ✅ | ✅ |
| Exclusive airdrops | ❌ | ❌ | ✅ |

---

## Unsold Node Burn Mechanism

### Burn = Increased Scarcity

After 3 months, all **unsold** Node packages will be completely burned:

<div class="x18-diagram-box" style="max-width: 500px; margin: 30px auto;">
<div class="x18-diagram-title" style="color: #ef4444;">🔥 BURN SCENARIO EXAMPLE</div>
<ul class="x18-node-details" style="margin: 10px 0 !important;">
<li><span class="label">Total Packages</span><span class="value">2,300</span></li>
<li><span class="label">Sold Packages</span><span class="value">1,800</span></li>
<li><span class="label">Unsold Packages</span><span class="value">500</span></li>
<li><span class="label">Equivalent Tokens Burned</span><span class="value" style="color: #ef4444;">~2,000,000 $X18</span></li>
<li style="border-bottom: 2px solid rgba(255,255,255,0.1); padding-bottom: 12px; margin-bottom: 8px !important;"></li>
<li><span class="label">Supply decreases</span><span class="value" style="color: #ef4444;">18M ➜ 16M</span></li>
<li><span class="label">Scarcity benefits</span><span class="value" style="color: #34d399;">Floor price rises for holders</span></li>
</ul>
</div>

> **Commitment**: There is no mechanism to mint burned tokens again. The smart contract ensures immutability.

---

## Why Buy Nodes Early?

### 1. Reference Price $1
The estimated $X18 price during the Node sale phase is **$1.00/token**. When the mainnet platform launches and volume increases, the token price will be market-determined — significant upside potential.

### 2. Mining Rewards
Node holders start earning $X18 **immediately** through mining, before the DEX mainnet launch.

### 3. Early Adopter Benefits
V1/V2/V3 benefits are **permanent** — fee discounts, AI access, and governance power do not expire after the program.

### 4. Burn Scarcity
Unsold Nodes are burned → actual supply lower than 18M → favorable for holders.

---

## Important Notes

> ⚠️ **Disclaimer**
> - Additional % upon purchase is a user benefit of receiving extra % tokens when buying a package
> - All $X18 Tokens purchased in the initial package will be **LOCKED** and only released monthly
> - The number of packages is **finite**, not infinite
> - Package quantities have a counter to show how many are left
> - If not sold out within 3 months, corresponding tokens will be **completely burned**
> - Nodes will cease operation after the term, and no additional packages will be issued

---

## Latest Updates

> *Note: This section is reserved for future updates regarding the Node Sale program. Any new rules, extensions, or additional benefits will be posted here.*

---

> **Next:** [Deflationary Mechanics →](deflationary.md)