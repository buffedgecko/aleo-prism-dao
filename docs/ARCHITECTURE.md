# Architecture — Prism DAO

## System Overview

Prism DAO is a privacy-first governance system built on Aleo's zero-knowledge cryptography. The system consists of three interconnected Leo programs that handle different aspects of anonymous voting.

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INTERFACE                          │
│                  (Web UI / CLI / Wallet Integration)            │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
    ┌──────────┐        ┌──────────┐        ┌──────────┐
    │  VOTER   │        │  VOTING  │        │  TALLY   │
    │  .aleo   │        │  .aleo   │        │  .aleo   │
    └──────────┘        └──────────┘        └──────────┘
         │                   │                   │
         └───────────────────┼───────────────────┘
                             ▼
                   ┌──────────────────┐
                   │  Aleo Network    │
                   │  (Record Model)  │
                   └──────────────────┘
```

---

## Core Components

### 1. Voter Program (`voter.leo`)

**Responsibility:** Handle voter registration and eligibility verification

**Records:**
- `Voter` — Registration record proving token holdings

**Transitions:**
- `register_voter` — Create a new voter record (requires ZK proof of balance)
- `verify_voter` — Verify voter eligibility for a specific proposal
- `deactivate` — Mark voter record as spent after voting

**Key Design Decisions:**
- Token balance is verified via ZK without being stored on-chain
- Voting weight is capped at minimum required balance to enhance privacy
- Registration is one-time per voter per proposal

### 2. Voting Program (`voting.leo`)

**Responsibility:** Handle proposal creation and vote casting

**Records:**
- `Proposal` — Governance proposal with encrypted vote counts
- `Vote` — Individual encrypted vote record

**Transitions:**
- `create_proposal` — Initialize a new governance proposal
- `cast_vote` — Cast an encrypted vote (main privacy feature)
- `close_voting` — Finalize voting and determine outcome

**Key Design Decisions:**
- Vote choice is stored as private input, never revealed on-chain
- Nullifier scheme prevents double voting without revealing voter identity
- Voting period is enforced via timestamp

### 3. Tally Program (`tally.leo`)

**Responsibility:** Handle vote verification and aggregation

**Records:**
- `TallyResult` — Verified vote counts

**Transitions:**
- `verify_and_accumulate` — Batch verify votes and accumulate counts
- `finalize` — Mark tally as final
- `calculate_distribution` — Compute voting power distribution

**Key Design Decisions:**
- Vote verification uses ZK proofs to confirm counts without revealing votes
- Multiple verifiers can independently verify (decentralized trust)
- Distribution calculation provides transparency on outcomes

---

## Data Flow

### Registration Flow

```
1. User generates ZK proof: "I have ≥100 tokens"
2. User calls register_voter(min_balance=100, balance=X, nonce)
3. Voter record is created: { voting_weight: min(X, 100), is_active: true }
4. Voter record is stored in user's wallet (not on-chain globally)
```

### Voting Flow

```
1. User retrieves their Voter record from wallet
2. User generates vote: choice=true/false, weight=Voter.voting_weight
3. User generates nullifier: hash(Voter.owner + proposal_id)
4. User calls cast_vote(proposal_id, nullifier, choice, weight, voter_proof)
5. Vote record is created and stored
6. Voter record is marked as spent (prevents double voting)
```

### Tally Flow

```
1. After voting period ends, anyone can trigger tally
2. Collector aggregates all Vote records for the proposal
3. Collector generates ZK proof: "sum of votes = X"
4. Collector calls verify_and_accumulate(verification, commitments)
5. TallyResult record is created with verified counts
6. Proposal status is updated to PASSED/FAILED
```

---

## Record Lifecycle

### Voter Record

```
[Created] ────> [Active] ────> [Spent]
                 │
                 └─── Can vote ────> Vote record created
```

### Vote Record

```
[Created] ────> [Finalized]
                    │
                    └─── Included in tally
```

### Proposal Record

```
[Created] ────> [Active] ────> [Closed] ────> [Finalized]
                                    │
                                    └─── Outcome determined
```

---

## Security Model

### Cryptographic Guarantees

1. **ZK Proofs:** All privacy-critical operations use zero-knowledge proofs
2. **Nullifiers:** Prevent double-voting without revealing identity
3. **Record Model:** Aleo's native record model ensures data isolation

### Trust Assumptions

1. **Aleo Network:** Trust the underlying ZK infrastructure
2. **ZK Circuits:** Trust the circuit design (audited, open source)
3. **User Keys:** User must protect their private keys

---

## Extension Points

### Future Enhancements

1. **Delegated Voting:** Allow voters to delegate their voting power
2. **Time-Locked Votes:** Voters can set votes to be revealed only after a certain time
3. **Quadratic Voting:** Weight votes by square root of token balance
4. **Multi-Chain Governance:** Bridge votes from other chains
5. **Privacy-Preserving Analytics:** Aggregate statistics without individual votes

---

## Deployment

### Testnet

```bash
# Build programs
leo build --all

# Deploy to testnet (requires Aleo wallet)
leo deploy voter --network testnet
leo deploy voting --network testnet
leo deploy tally --network testnet
```

### Mainnet

1. Conduct trusted setup ceremony
2. Audit all ZK circuits
3. Deploy with governance multisig
4. Monitor for privacy breaches

---

## Dependencies

```
- Aleo CLI v1.0.0+
- Leo Compiler v1.0.0+
- snarkOS (for node operations)
```

---

## Version

- **v1.0.0** — Initial release for Buildathon Wave 4
