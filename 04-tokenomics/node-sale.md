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

```
╔══════════════════════════════════════════════════════════════════════════╗
║                      X18 NODE PACKAGES                                 ║
╠══════════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  ┌─────────────────────┐  ┌─────────────────────┐  ┌─────────────────┐ ║
║  │  🥉 $1,000 PACKAGE  │  │  🥈 $5,000 PACKAGE  │  │ 🥇 $10,000 PACKAGE│ ║
║  │                     │  │                      │  │                 │ ║
║  │  Price: $1,000      │  │  Price: $5,000       │  │  Price: $10,000 │ ║
║  │  X18 Tokens: 1,000  │  │  X18 Tokens: 5,000   │  │  X18 Tokens:    │ ║
║  │                     │  │                      │  │  10,000         │ ║
║  │  Quantity: 1,000    │  │  Quantity: 1,000     │  │  Quantity:      │ ║
║  │  packages           │  │  packages            │  │  300 packages   │ ║
║  │  Benefits: V1       │  │  Benefits: V2        │  │  Benefits: V3   │ ║
║  │  Mining: 8%/month   │  │  Mining: 9%/month    │  │  Mining:        │ ║
║  │  Bonus: 0%          │  │  Bonus: 5%           │  │  10%/month      │ ║
║  │                     │  │                      │  │  Bonus: 10%     │ ║
║  └─────────────────────┘  └─────────────────────┘  └─────────────────┘ ║
║                                                                        ║
╚══════════════════════════════════════════════════════════════════════════╝
```

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
```
User purchases Node package ($1,000 / $5,000 / $10,000)
         │
         ▼
X18 Tokens allocated to user
         │
         ▼
All tokens are LOCKED ❌
(Cannot withdraw, sell, or transfer)
         │
         ▼
Mining starts automatically ⛏️
```

### 2. Mining & Unlock
```
Each month, user receives mining rewards:
         │
         ├── $1,000 Package:  8% × 1,000 =   80 X18/month
         ├── $5,000 Package:  9% × 5,250 =  472.5 X18/month
         └── $10,000 Package: 10% × 11,000 = 1,100 X18/month
         │
         ▼
Rewards are unlocked and can be:
  ✅ Held (HODL)
  ✅ Traded on X18 DEX
  ✅ Staked to earn more
  ✅ Used in X18 Game
```

### 3. Token Lock & Release
> **Important**: All $X18 Tokens purchased in the initial package will be **LOCKED** and only released monthly through the mining mechanism. This design aims to:
> - **Protect token price** — Prevent dumping immediately after purchase
> - **Long-term commitment** — Incentivize holders to retain and engage with the ecosystem
> - **Even distribution** — Tokens are gradually unlocked, avoiding sell pressure

---

## Countdown Clock

The Node sale program features a **countdown clock** displayed in each user's dashboard:

```
╔═══════════════════════════════════════════════════════╗
║              ⏱️ NODE SALE COUNTDOWN                   ║
╠═══════════════════════════════════════════════════════╣
║                                                       ║
║              67 DAYS : 14 HOURS : 32 MINUTES          ║
║                                                       ║
║  ┌─────────────────────────────────────────────────┐  ║
║  │ $1,000 Package ████████████░░░░░░ 680/1,000 sold │  ║
║  │ $5,000 Package ██████████████░░░░ 720/1,000 sold │  ║
║  │ $10,000 Package █████████████████░ 255/300 sold  │  ║
║  └─────────────────────────────────────────────────┘  ║
║                                                       ║
║  📊 Total sold: 1,655 / 2,300 (71.9%)                 ║
║                                                       ║
║  🔥 Unsold Nodes after 3 months → Permanently BURNED  ║
║                                                       ║
║            [ Buy Node Now ]                           ║
╚═══════════════════════════════════════════════════════╝
```

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

```
Example: If only 1,800 / 2,300 packages are sold:

Unsold packages: 500
Equivalent Tokens: ~2,000,000 $X18 (estimated)
         │
         ▼
🔥 Permanently BURNED — Tokens will never exist
         │
         ▼
Total Supply decreases from 18,000,000 → ~16,000,000
         │
         ▼
💎 Scarcity increases → Token value rises for holders
```

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