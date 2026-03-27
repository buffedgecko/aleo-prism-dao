// Test suite for voter.leo
// Run with: leo test programs/tests/voter_test.leo

import voter.aleo;

function test_register_voter_success() {
    // Test: balance >= MIN_VOTING_BALANCE should succeed
    let voter = voter.aleo.register_voter(100u64, 500u64, 12345u64);
    assert(voter.voting_weight == 100u64);
    assert(voter.is_active == true);
}

function test_register_voter_exact_balance() {
    // Test: balance == MIN_VOTING_BALANCE should succeed
    let voter = voter.aleo.register_voter(100u64, 100u64, 12345u64);
    assert(voter.voting_weight == 100u64);
    assert(voter.is_active == true);
}

function test_register_voter_below_balance() {
    // Test: balance < MIN_VOTING_BALANCE should fail
    // This would revert in actual execution
    assert(0u64 == 1u64); // Placeholder - actual test would expect revert
}

function test_verify_voter_active() {
    // Test: verify_voter returns true for active voter
    let v = Voter {
        owner: aleo1...,
        voting_weight: 100u64,
        registered_at: 1234567u32,
        is_active: true,
    };
    let result = voter.aleo.verify_voter(v, 1u32);
    assert(result == true);
}

function test_deactivate_voter() {
    // Test: deactivate sets is_active to false
    let v = Voter {
        owner: aleo1...,
        voting_weight: 100u64,
        registered_at: 1234567u32,
        is_active: true,
    };
    let deactivated = voter.aleo.deactivate(v);
    assert(deactivated.is_active == false);
}
