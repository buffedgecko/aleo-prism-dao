# 📹 Complete Recording Guide — Prism DAO Demo

## Equipment & Software

| Tool | Purpose | Free? |
|------|---------|-------|
| [OBS Studio](https://obsproject.com/) | Screen recording | ✅ Yes |
| [Loom](https://loom.com/) | Quick sharing | ✅ Free tier |
| [CapCut](https://capcut.com/) | Video editing | ✅ Free |

---

## Pre-Recording Checklist

- [ ] Demo URL deployed (from Vercel)
- [ ] GitHub repo is public
- [ ] Leo code is complete
- [ ] PRIVACY.md and ARCHITECTURE.md written
- [ ] SUBMISSION.md filled out

---

## Recording Sequence

### 📸 Take 1: Screen Only (No facecam)

```
00:00 - 00:15  Opening title card
00:15 - 00:45  Problem statement  
00:45 - 03:30  Full demo flow
03:30 - 04:00  Privacy explanation
04:00 - 04:30  Closing + CTA
```

### 📸 Take 2: Add Voiceover

Record voice separately over screen recording.

---

## What to Say (Word-for-Word)

### INTRO (15 sec)
> "Prism DAO — anonymous voting on Aleo. No one sees who you voted for. No one sees your balance. But it's all verifiable on-chain. Let me show you."

### PROBLEM (30 sec)
> "Traditional DAO voting on Ethereum? Every single vote is public. Your address, your choice, your voting power — all visible. Whales can be targeted. Vote selling is trivial. And your governance history follows you forever.
> 
> Prism DAO solves this with zero-knowledge cryptography built into Aleo's record model."

### DEMO STEP 1: Registration (30 sec)
> "First, voters register. The system needs to verify you have enough tokens — but watch this: it creates a ZK proof of your balance WITHOUT revealing the actual amount.
> 
> See how the record stores only 'voting_weight' — not your actual balance. That's privacy by design."

### DEMO STEP 2: Proposals (20 sec)
> "Any registered voter can create proposals. These details are public — so people know what they're voting on. But the votes themselves? Encrypted."

### DEMO STEP 3: Voting (45 sec)
> "Now the key part. When you vote 'Yes' or 'No' — your choice is encrypted. Your address is NOT stored in the vote record. Only a nullifier to prevent double voting.
> 
> This is what goes on-chain. Nothing identifiable. Nothing traceable."

### DEMO STEP 4: Tallying (30 sec)
> "Once voting closes, the ZK proof verifies the final count is accurate — without exposing any individual votes. The result is public and verifiable, but the process is private."

### PRIVACY EXPLAINER (45 sec)
> "Here's the privacy breakdown:
> - Voter identity: Hidden completely
> - Vote choice: Encrypted, only revealed in final tally
> - Token balance: Proven via ZK without exposure
> - Proposal content: Public for transparency
> - Final results: Public and verifiable

> This is the difference between 'privacy theater' and real privacy."

### OUTRO (15 sec)
> "Prism DAO — privacy by default, verification by design. 
> 
> Check the repo, deploy the demo, and let's build private governance together.
> 
> #AleoBuildathon"

---

## Post-Recording Edits

1. **Add intro/outro** — Use CapCut templates
2. **Add captions** — 90% watch on mute
3. **Add transitions** — Simple fade cuts
4. **Add background music** — Search "copyright free ambient" on YouTube
5. **Export at 1080p** — H.264 for compatibility

---

## One-Click Demo Recording (Alternative)

If you just want to record the browser quickly:

```bash
# Install Chrome extension: "Screen Recorder"
# Or use: QuickTime (Mac) / Xbox Game Bar (Windows)
```

---

## Where to Share

| Platform | Why |
|----------|-----|
| Twitter/X | Buildathon announcement |
| LinkedIn | Professional network |
| YouTube | Long-form demo |
| Discord | Aleo community |

**Post the video link in your submission!**
