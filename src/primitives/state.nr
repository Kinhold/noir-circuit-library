
pub fn verify_update(old_state_hash: Field, action_hash: Field, expected_new_state: Field) {
    // Proves a valid state transition occurred based on a private action
    let computed_new_state = std::hash::pedersen_hash([old_state_hash, action_hash]);
    assert(computed_new_state == expected_new_state);
}
