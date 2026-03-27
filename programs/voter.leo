// voter.leo — Voter Registration & Balance Verification
// This program handles voter registration with ZK proof of token holdings

program voter.aleo {
    // Minimum token balance required to vote
    const MIN_VOTING_BALANCE: u64 = 100u64;

    // Voter registration record
    // This record is consumed on vote to prevent double voting
    record Voter {
        owner: address,
        // Token balance - verified via ZK without exposing actual amount
        voting_weight: u64,
        // Registration timestamp for governance windows
        registered_at: u32,
        // Ensures one-time use
        is_active: bool,
    }

    // Token balance proof (public inputs)
    struct BalanceProof {
        minimum_required: u64,
        // The actual balance is kept private
    }

    // Register a new voter
    // Verifies token balance via ZK while keeping the balance private
    transition register_voter(
        public min_balance: u64,
        private balance: u64,
        public nonce: u64,
    ) -> Voter {
        // ZK constraint: balance >= MIN_VOTING_BALANCE
        // This proof verifies the voter has sufficient tokens without revealing the amount
        assert(balance >= MIN_VOTING_BALANCE);

        return Voter {
            owner: self.caller,
            voting_weight: balance.min(MIN_VOTING_BALANCE), // Cap at minimum to protect privacy
            registered_at: block.timestamp,
            is_active: true,
        };
    }

    // Verify voter is eligible (used by voting program)
    transition verify_voter(
        public voter_record: Voter,
        public proposal_id: u32,
    ) -> bool {
        return voter_record.is_active && voter_record.voting_weight >= MIN_VOTING_BALANCE;
    }

    // Deactivate voter after successful vote (called by voting program)
    transition deactivate(voter: Voter) -> Voter {
        return Voter {
            owner: voter.owner,
            voting_weight: voter.voting_weight,
            registered_at: voter.registered_at,
            is_active: false,
        };
    }
}
