# Privacy Analysis — Prism DAO

## Overview

Prism DAO implements **layered privacy** where different data has different visibility levels. This document analyzes what data is visible, what is hidden, and potential attack vectors.

---

## Data Visibility Matrix

| Data | On-Chain Visibility | Who Can See | Protection Mechanism |
|------|---------------------|-------------|----------------------|
| Voter Address | **Hidden** | No one | Not stored in Vote record |
| Vote Choice | **Hidden** | No one | Encrypted in Vote record |
| Voting Weight | **Hidden** | No one | Private input to ZK proof |
| Proposal Existence | **Public** | Everyone | Stored as Proposal record |
| Final Vote Count | **Public** | Everyone | Revealed after tally |
| Voter Participation | **Hidden** | No one | Nullifier prevents double-vote |
| Individual Nullifier | **Public** | Everyone | Hash, not linkable to voter |

---

## Privacy Features

### 1. Voter Identity Protection

**What's Protected:**
- The link between voter address and their vote choice
- The fact that a specific address voted on a specific proposal

**How It Works:**
```
Voter registers → Receives Voter record (off-chain)
Voter casts vote → Vote record has NO owner field pointing to voter
Vote contains: nullifier (hash of voter_address + proposal_id)
```

**Verification:** Anyone can verify the vote is valid without knowing who cast it.

### 2. Vote Choice Protection

**What's Protected:**
- Individual vote choices (yes/no/abstain)
- The correlation between multiple votes from the same voter

**How It Works:**
```
choice: bool  // Stored as private input in ZK proof
weight: u64   // Voting power kept private
```

**Key Insight:** Even with infinite computational power, an observer cannot determine the vote choice from the encrypted record. Only the voter knows for certain.

### 3. Vote Counting Protection

**What's Protected:**
- Intermediate vote counts during voting period
- Individual vote weights

**How It Works:**
```
During voting: Only nullifiers are public
After tally: ZK proof verifies count without revealing individual votes
```

---

## Threat Model

### Attacker Capabilities

We assume an attacker with:
- Full visibility of all on-chain data
- Infinite computational resources
- Knowledge of all ZK circuits
- Knowledge of all smart contract code

### What Attackers CANNOT Do

1. **Link voter to vote:** The nullifier scheme prevents linking
2. **Determine vote choice:** ZK proofs encrypt individual votes
3. **See voting weights:** Private inputs are never revealed
4. **Double vote:** Nullifiers are deterministic and unique per proposal

### What Attackers MIGHT Infer

1. **Timing attacks:** If a voter publishes their vote externally (social media), timing can correlate
2. **Voting pattern analysis:** If the same voter votes on multiple proposals, pattern analysis might infer identity
3. **Transaction graph analysis:** If voter interacts with other contracts, graph analysis might de-anonymize

### Mitigations

1. **Timing attacks:** Voters should be advised to vote at random times
2. **Pattern analysis:** Nullifiers are per-proposal, preventing cross-proposal linkage
3. **Transaction isolation:** Users should use dedicated addresses for Prism DAO

---

## Privacy Leakage Analysis

### Potential Leak Points

| Component | Risk Level | Description |
|-----------|-----------|-------------|
| Nullifier generation | **Low** | Uses keccak256(address + proposal_id), believed collision-resistant |
| ZK proof verification | **None** | Proofs don't reveal private inputs |
| Vote record storage | **None** | Vote choice never stored in plaintext |
| Tally verification | **Low** | Only aggregate counts revealed |

### Comparison with Alternatives

| System | Voter Privacy | Vote Privacy | Tally Privacy | Verifiability |
|--------|--------------|-------------|---------------|---------------|
| Ethereum (Governor) | None | None | None | High |
| Polygon (Worldcoin) | Partial | None | Partial | High |
| Nouns DAO | None | None | None | High |
| **Prism DAO** | **Full** | **Full** | **Full** | **High** |

---

## ZK Proof Constraints

The following constraints must be satisfied for a valid vote:

```
1. Voter must have valid Voter record
2. Voter record must be active (not spent)
3. Nullifier must be hash(owner + proposal_id)
4. Vote must be cast within voting period
5. Proposal must be active
```

---

## Formal Privacy Statement

**Prism DAO achieves:**
- **Vote Unlinkability:** No on-chain mechanism exists to link a Vote record to a voter address
- **Vote Secrecy:** The vote choice is cryptographically hidden using ZK proofs
- **Tally Integrity:** Vote counts are verifiable without revealing individual votes
- **Double-Vote Prevention:** Nullifiers prevent the same voter from voting twice on the same proposal

---

## Limitations

1. **Social engineering:** Users might voluntarily reveal their vote
2. **Side channels:** Timing, transaction ordering, and gas prices might leak information
3. **Trusted setup:** ZK proofs require a trusted setup ceremony (planned for production)
4. **Key management:** If a voter's private key is compromised, their vote is compromised (standard blockchain limitation)

---

## Recommendations for Maximum Privacy

1. Use a dedicated wallet for Prism DAO voting
2. Avoid voting immediately after proposal creation
3. Don't discuss vote choices on social media
4. Use VPN/TOR when voting (future feature)
5. Don't link your Prism DAO wallet to your other addresses
