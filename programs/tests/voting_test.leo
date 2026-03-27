// Test suite for voting.leo
// Run with: leo test programs/tests/voting_test.leo

import voting.aleo;

function test_create_proposal() {
    // Test: creating a proposal sets correct initial state
    let description = [1field, 0field, 0field, 0field];
    let proposal = voting.aleo.create_proposal(1u32, description, 86400u32);
    
    assert(proposal.proposal_id == 1u32);
    assert(proposal.votes_for == 0u64);
    assert(proposal.votes_against == 0u64);
    assert(proposal.total_voters == 0u64);
    assert(proposal.status == 1u8); // STATUS_ACTIVE
}

function test_cast_vote_yes() {
    // Test: casting a yes vote creates correct Vote record
    let vote = voting.aleo.cast_vote(
        1u32,
        12345field,
        true,   // choice: yes
        100u64,  // weight
        67890field  // voter_proof
    );
    
    assert(vote.proposal_id == 1u32);
    assert(vote.choice == true);
    assert(vote.weight == 100u64);
}

function test_cast_vote_no() {
    // Test: casting a no vote creates correct Vote record
    let vote = voting.aleo.cast_vote(
        1u32,
        12345field,
        false,  // choice: no
        50u64,   // weight
        67890field
    );
    
    assert(vote.proposal_id == 1u32);
    assert(vote.choice == false);
    assert(vote.weight == 50u64);
}

function test_close_voting_passed() {
    // Test: closing voting with more yes than no marks as passed
    let proposal = voting.aleo.close_voting(
        1u32,
        60u64,   // final_votes_for
        40u64,   // final_votes_against
        100u64   // total_voters
    );
    
    assert(proposal.votes_for == 60u64);
    assert(proposal.votes_against == 40u64);
    assert(proposal.status == 3u8); // STATUS_PASSED
}

function test_close_voting_failed() {
    // Test: closing voting with more no than yes marks as failed
    let proposal = voting.aleo.close_voting(
        1u32,
        40u64,   // final_votes_for
        60u64,   // final_votes_against
        100u64   // total_voters
    );
    
    assert(proposal.votes_for == 40u64);
    assert(proposal.votes_against == 60u64);
    assert(proposal.status == 4u8); // STATUS_FAILED
}
