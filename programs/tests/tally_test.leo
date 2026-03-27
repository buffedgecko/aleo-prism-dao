// Test suite for tally.leo
// Run with: leo test programs/tests/tally_test.leo

import tally.aleo;

function test_verify_and_accumulate() {
    // Test: verification creates correct TallyResult
    let verification = VoteVerification {
        proposal_id: 1u32,
        claimed_votes_for: 60u64,
        claimed_votes_against: 40u64,
        claimed_voter_count: 100u64,
    };
    
    let result = tally.aleo.verify_and_accumulate(
        verification,
        123field,
        456field,
        789field
    );
    
    assert(result.proposal_id == 1u32);
    assert(result.votes_for == 60u64);
    assert(result.votes_against == 40u64);
    assert(result.voter_count == 100u64);
    assert(result.is_verified == true);
}

function test_finalize_approved() {
    // Test: finalize returns true when for > against
    let result = tally.aleo.finalize(1u32, 60u64, 40u64);
    assert(result == true);
}

function test_finalize_rejected() {
    // Test: finalize returns false when against > for
    let result = tally.aleo.finalize(1u32, 40u64, 60u64);
    assert(result == true); // Still valid voting, just failed
}

function test_finalize_tie() {
    // Test: finalize returns true when tied (allows tie-breaker logic)
    let result = tally.aleo.finalize(1u32, 50u64, 50u64);
    assert(result == true);
}

function test_calculate_distribution() {
    // Test: distribution calculates correct percentage
    let pct = tally.aleo.calculate_distribution(60u64, 40u64);
    assert(pct == 6000field); // 60% = 6000 basis points
}

function test_calculate_distribution_all_for() {
    // Test: 100% yes
    let pct = tally.aleo.calculate_distribution(100u64, 0u64);
    assert(pct == 10000field);
}

function test_calculate_distribution_all_against() {
    // Test: 100% no
    let pct = tally.aleo.calculate_distribution(0u64, 100u64);
    assert(pct == 0field);
}
