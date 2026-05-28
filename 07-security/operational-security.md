# Operational Security

## Operational Security

### Infrastructure Security
- **DDoS Protection**: Enterprise-grade mitigation
- **API Rate Limiting**: Per-key limits prevent abuse
- **Zero Trust Architecture**: Verify everything, trust nothing
- **Key Management**: HSM-backed key storage
- **Monitoring**: 24/7 on-chain + off-chain monitoring
- **Incident Response**: <15 minute response time for critical issues

### Zero-Knowledge (ZK) Data Privacy
To ensure institutional-grade data security and absolute user privacy, X18ex integrates cutting-edge **Zero-Knowledge (ZK) cryptography**:
- **Private Order Matching**: Trading intents, order sizes, and limit prices are masked using zk-SNARKs before being submitted to the matching engine, preventing any form of front-running by nodes.
- **Zero-Trust Identity Verification**: User identity and KYC (when required for certain pools or institutional onboarding) are verified via ZK-proofs, allowing users to prove compliance without ever exposing raw personal data to X18ex servers.
- **Cryptographic Obfuscation**: Portfolio balances, AI trading triggers, and liquidation thresholds are cryptographically blinded, ensuring that only the user and the smart contract can decrypt the specific state, rendering on-chain data unreadable to malicious actors.

### User Protection
- **Non-custodial**: X18ex NEVER holds private keys
- **Transaction Simulation**: Preview all transactions before signing
- **Phishing Protection**: Domain verification warnings
- **Contract Verification**: Auto-check contract source on BscScan
- **Scam Token Detection**: AI detects honeypot, rug pull tokens

### Insurance Fund
- 5% protocol revenue → Insurance fund
- Cover: smart contract bugs, oracle failures
- Managed by DAO vote

---

> **Next:** [Core Team →](../08-team/core-team.md)