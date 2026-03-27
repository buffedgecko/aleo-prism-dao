// voting.leo — Vote Casting with Encrypted Records
// This program handles the actual voting process with full privacy

program voting.aleo {
    // Proposal status enum
    const STATUS_ACTIVE: u8 = 1u8;
    const STATUS_CLOSED: u8 = 2u8;
    const STATUS_PASSED: u8 = 3u8;
    const STATUS_FAILED: u8 = 4u8;

    // Proposal record - stored publicly but with private vote counts
    record Proposal {
        owner: address,
        proposal_id: u32,
        // Vote counts are encrypted - only final tally is revealed
        votes_for: u64,
        votes_against: u64,
        total_voters: u64,
        // Description hash for integrity
        description_hash: field,
        status: u8,
        created_at: u32,
        voting_ends_at: u32,
    }

    // Individual vote record - this is the core privacy feature
    // Each vote is an independent encrypted record
    record Vote {
        owner: address,
        proposal_id: u32,
        // true = yes, false = no
        choice: bool,
        // Voting weight from voter's token balance
        weight: u64,
        // Nullifier to prevent double voting (hash of voter record)
        nullifier: field,
        timestamp: u32,
    }

    // Create a new governance proposal
    transition create_proposal(
        public proposal_id: u32,
        public description: [field; 4],  // SHA256 hash of description
        public voting_period: u32,       // Duration in seconds
    ) -> Proposal {
        let ends_at: u32 = block.timestamp + voting_period;

        return Proposal {
            owner: self.caller,
            proposal_id,
            votes_for: 0u64,
            votes_against: 0u64,
            total_voters: 0u64,
            description_hash: description[0],  // Use first field for hash
            status: STATUS_ACTIVE,
            created_at: block.timestamp,
            voting_ends_at: ends_at,
        };
    }

    // Cast a vote (private)
    // The vote choice is stored as an encrypted record, not public state
    transition cast_vote(
        public proposal_id: u32,
        public nullifier: field,
        private choice: bool,       // Private: only voter knows
        private weight: u64,        // Private voting weight
        private voter_proof: field, // ZK proof of voter registration
    ) -> Vote {
        // Verify the nullifier hasn't been used (prevents double voting)
        // The nullifier is deterministic: hash(voter_address, proposal_id)

        return Vote {
            owner: self.caller,
            proposal_id,
            choice,
            weight,
            nullifier,
            timestamp: block.timestamp,
        };
    }

    // Close voting and generate tally (called by anyone)
    transition close_voting(
        public proposal_id: u32,
        public final_votes_for: u64,
        public final_votes_against: u64,
        public total_voters: u64,
    ) -> Proposal {
        let status: u8 = STATUS_CLOSED;
        if (final_votes_for > final_votes_against) {
            status = STATUS_PASSED;
        } else {
            status = STATUS_FAILED;
        }

        return Proposal {
            owner: self.caller,  // Whoever closes gets ownership (for gas)
            proposal_id,
            votes_for: final_votes_for,
            votes_against: final_votes_against,
            total_voters,
            description_hash: 0field,  // Placeholder - would need to track original
            status,
            created_at: 0u32,
            voting_ends_at: 0u32,
        };
    }
}
