use poseidon;

pub fn verify_htlc(
    preimage: Field,
    hash_lock: Field,
    current_time: u64,
    time_lock: u64,
    is_timeout_claim: bool
) {
    if is_timeout_claim {
        assert(current_time >= time_lock);
    } else {
        let computed_hash = poseidon::hash([preimage]);
        assert(computed_hash == hash_lock);
    }
}
