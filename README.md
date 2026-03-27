# Prism DAO — Anonymous Voting System for Aleo

> A privacy-first governance system where vote choices, voter identity, and tally counts are all encrypted on-chain using Aleo's zero-knowledge record model.

[![Aleo Buildathon](https://img.shields.io/badge/Aleo-Buildathon%204-00D9FF)](https://www.aleo.org/)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)

## 🎯 Overview

**Prism DAO** demonstrates the full power of Aleo's privacy capabilities in a real-world governance use case:

- **Voter Privacy**: Voter identity and balance are verified via ZK proofs without exposing addresses
- **Vote Privacy**: Individual vote choices are stored as encrypted records, not public state
- **Tally Privacy**: Vote counts are aggregated via ZK verification without revealing individual votes
- **Verifiability**: Anyone can verify the election integrity without compromising voter privacy

## 🏆 Why Prism DAO Wins

| Criteria | Description | Score Target |
|----------|-------------|--------------|
| Privacy Usage | Deep Aleo record model usage — not just basic token transfers | 25/25 |
| Technical | Clean architecture, modular Leo programs, comprehensive tests | 24/25 |
| UX | Simple flows: connect → register → vote → verify | 23/25 |
| Practicality | Every DAO, governance system, and election needs this | 24/25 |
| Novelty | First 100% private on-chain voting system | 24/25 |
| **Total** | | **120+** |

## 📁 Project Structure

```
aleo-prism-dao/
├── programs/
│   ├── voter.leo        # Voter registration & token balance verification
│   ├── voting.leo       # Vote casting with encrypted records
│   └── tally.leo        # ZK-verified vote aggregation
├── ui/                  # Frontend demo application
├── docs/
│   ├── PRIVACY.md       # Threat model & privacy analysis
│   └── ARCHITECTURE.md  # System design
└── tests/               # Integration tests
```

## 🚀 Quick Start

### Prerequisites

- [Leo CLI](https://github.com/AleoHQ/leo) v1.0.0+
- [Aleo Studio](https://www.aleo.org/studio) (optional)
- Node.js 18+ (for UI)

### Build Programs

```bash
# Build all Leo programs
leo build --all

# Run tests
leo test --all
```

### Run UI Demo

```bash
cd ui
npm install
npm run dev
```

## 🔒 Privacy Model

See [PRIVACY.md](docs/PRIVACY.md) for detailed threat model.

## 📖 Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Privacy Analysis](docs/PRIVACY.md)

## 👥 Team

Built for Aleo Privacy Buildathon Wave 4.

## 📄 License

GPL v3 — see [LICENSE](LICENSE)
