use std::hash::poseidon;

pub struct PlumeSignal {
    pub nullifier_x: Field,
    pub nullifier_y: Field,
    pub pk_x: Field,
    pub pk_y: Field,
    pub message_hash: Field,
}

pub fn verify_signal(sk: Field, signal: PlumeSignal) {
    let expected_nullifier_x = poseidon::hash([sk, signal.message_hash, 0]);
    let expected_nullifier_y = poseidon::hash([sk, signal.message_hash, 1]);
    
    assert(expected_nullifier_x == signal.nullifier_x);
    assert(expected_nullifier_y == signal.nullifier_y);
}
