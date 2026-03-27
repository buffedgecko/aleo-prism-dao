# Prism DAO — Video Demo Script

## Demo Overview
**Duration:** 3-4 minutes  
**Purpose:** Show how Prism DAO provides anonymous on-chain voting

---

## Scene 1: Opening (15 seconds)
*[Host on camera]*

> "Hi everyone! Today I'm showing Prism DAO — a 100% private voting system built on Aleo. No one can see who you voted for, how much tokens you have, or even that you voted at all. Let's dive in."

---

## Scene 2: The Problem (30 seconds)
*[Screen recording: Show public governance on Ethereum]*

> "Traditional DAO voting looks like this — every address, every vote choice, every voting power is visible on-chain. 

Your competitors can see your strategy. Whale wallets can be identified. And your vote history is forever linked to your identity."

*[Transition to Prism DAO demo]*

> "Prism DAO fixes this. Let me show you."

---

## Scene 3: Demo Flow (2 minutes)

### Step 1: Registration
*[Screen: UI shows "Connect Wallet" → "Register as Voter"]*

> "First, voters register. The system verifies you have enough tokens to vote — but here's the key: it uses a ZK proof to verify your balance WITHOUT revealing how many tokens you actually have."

*[Click Register]*

> "The record is stored on-chain, but your balance? Hidden."

---

### Step 2: Create Proposal
*[Screen: Admin creates a new proposal]*

> "Now, any registered voter can create a proposal. In this case, 'Allocate 50,000 ALEO to Dev Fund.' The proposal details are public so the community knows what they're voting on."

---

### Step 3: Vote Anonymously
*[Screen: User casts vote — UI shows transaction being processed]*

> "When you vote, you select Yes or No. Here's where the magic happens: your vote choice is encrypted. Your address is not stored. And your voting weight is proven via ZK proof."

*[Show the Vote record structure]*

> "This is what gets stored on-chain. Notice — no voter address, no vote choice, just encrypted data that can be verified later."

---

### Step 4: Tally & Verify
*[Screen: Admin closes voting, ZK verification runs]*

> "Once voting ends, anyone can verify the results. The ZK proof confirms the final count is correct — without revealing any individual votes."

---

## Scene 4: Privacy Deep Dive (45 seconds)
*[Screen: Show PRIVACY.md visualization]*

> "Let me break down what we protect:

- **Voter Identity:** Hidden — not stored in vote records
- **Vote Choice:** Hidden — encrypted in vote records  
- **Voting Weight:** Hidden — proven via ZK without exposure
- **Proposal Details:** Public — so people know what they vote on
- **Final Tally:** Public — verified and trustworthy"

---

## Scene 5: Why This Matters (30 seconds)
*[Screen: Show market opportunity]*

> "Every DAO, every governance system, every election needs this. Today, on Ethereum, you can't have private voting without sacrificing decentralization.

Prism DAO proves it's possible — 100% on-chain, 100% verifiable, 100% private."

---

## Scene 6: Closing (15 seconds)

> "That's Prism DAO. Privacy by default, verification by design. 

Check out the repo, try the demo, and let's build a more private future together."

*[Show repo URL and demo link]*

---

## Recording Tips

1. **Use Loom or OBS** for screen recording
2. **Show wallet address** — but explain it's simulated for demo
3. **Highlight the encrypted records** — zoom in on the data structures
4. **Add background music** — royalty-free via Uppbeat or Pixabay
5. **Speed up** registration/voting clicks slightly in post

---

## Thumbnail Suggestion

```
┌────────────────────────────────────────┐
│                                        │
│   [PRISM DAO logo - gradient effect]  │
│                                        │
│   🗳️ ANONYMOUS VOTING                  │
│      ON ALEO BLOCKCHAIN                │
│                                        │
│   [Gradient: cyan → purple → pink]     │
│                                        │
└────────────────────────────────────────┘
```
