# Prism DAO — Anonymous Voting System for Aleo

> A privacy-first governance system where vote choices, voter identity, and tally counts are all encrypted on-chain using Aleo's zero-knowledge record model.

[![Aleo Buildathon](https://img.shields.io/badge/Aleo-Buildathon%204-00D9FF)](https://www.aleo.org/)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)
[![Demo](https://img.shields.io/badge/Demo-Live%20%F0%9F%94%97-ff6b6b)](https://aleo-prism-dao.vercel.app)

## 🎯 Overview

**Prism DAO** demonstrates the full power of Aleo's privacy capabilities through a complete anonymous voting system. Unlike traditional DAOs where every vote is public, Prism DAO uses ZK proofs to keep everything private while maintaining verifiability.

## ✨ Features

| Feature | Description |
|---------|-------------|
| **Anonymous Registration** | Voter eligibility verified via ZK proof without exposing balance |
| **Encrypted Voting** | Vote choices encrypted on-chain, never linkable to voter |
| **Nullifier System** | Prevents double-voting without revealing voter identity |
| **ZK Verification** | Final tally verified without exposing individual votes |
| **Flexible Proposals** | Support for public or private proposal details |

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INTERFACE                          │
│                  (Web UI at aleo-prism-dao.vercel.app)         │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
    ┌──────────┐        ┌──────────┐        ┌──────────┐
    │  VOTER   │        │  VOTING  │        │  TALLY   │
    │  PROGRAM │        │  PROGRAM │        │  PROGRAM │
    ├──────────┤        ├──────────┤        ├──────────┤
    │ Register │        │ Cast Vote│        │Verify &  │
    │ ZK Proof │        │ Encrypt  │        │ Tally    │
    │ Balance  │        │ Nullifier│        │ Results  │
    └──────────┘        └──────────┘        └──────────┘
```

## 📁 Project Structure

```
aleo-prism-dao/
├── programs/
│   ├── voter.leo           # Voter registration + ZK balance proof
│   ├── voting.leo          # Encrypted vote casting + nullifier
│   ├── tally.leo           # ZK-verified vote aggregation
│   └── tests/              # Unit tests for each program
├── ui/
│   ├── index.html          # Interactive demo (wallet simulation)
│   └── package.json        # Dependencies
├── docs/
│   ├── PRIVACY.md          # Threat model & privacy analysis
│   └── ARCHITECTURE.md     # System design documentation
├── DEMO_SCRIPT.md          # Video demo script
├── DEMO_RECORDING.md       # Complete recording guide
└── SUBMISSION.md           # Buildathon submission template
```

## 🔒 Privacy Model

| Data | Visibility | Protection |
|------|------------|------------|
| Voter Address | **Hidden** | Not stored in vote records |
| Vote Choice | **Hidden** | Encrypted in Vote record |
| Voting Weight | **Hidden** | ZK proof without exposure |
| Proposal Details | **Public** | Transparency for governance |
| Final Tally | **Public** | Verified via ZK proof |

## 🚀 Quick Start

### Run Demo Locally

```bash
cd ui
npm install
npm run dev
# Open http://localhost:3000
```

### View Live Demo

👉 **https://aleo-prism-dao.vercel.app**

## 📹 Demo Video

Recording guide available in [DEMO_RECORDING.md](DEMO_RECORDING.md)

## 🧪 Testing

```bash
# Test voter program
leo test programs/tests/voter_test.leo

# Test voting program  
leo test programs/tests/voting_test.leo

# Test tally program
leo test programs/tests/tally_test.leo
```

## 📄 Documentation

- [Privacy Analysis](docs/PRIVACY.md) — What data is protected and how
- [Architecture](docs/ARCHITECTURE.md) — System design and data flow
- [Demo Script](DEMO_SCRIPT.md) — Word-for-word demo narration

## 🏆 Buildathon Submission

See [SUBMISSION.md](SUBMISSION.md) for submission details.

## 📜 License

GNU General Public License v3.0 — see [LICENSE](LICENSE)

---

Built with 🔐 for the [Aleo Privacy Buildathon Wave 4](https://www.aleo.org/buildathon)
