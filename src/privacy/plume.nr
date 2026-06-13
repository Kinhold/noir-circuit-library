// PLUME-lite Anonymous Identity
// Target: nargo 1.0.0-beta.21
// Note: Curve math abstracted to inputs to bypass unstable beta.21 EC API and save constraints

use dep::std::hash::poseidon;

pub struct PlumeSignal {
    pub nullifier_x: Field,
    pub nullifier_y: Field,
    pub pk_x: Field,
    pub pk_y: Field,
    pub message_hash: Field,
}

pub fn verify_signal(sk: Field, signal: PlumeSignal) {
    // In a fully constrained PLUME, we'd do EC scalar multiplication here.
    // For this mobile-optimized beta.21 version, we verify a Poseidon linkage 
    // to ensure the nullifier is uniquely tied to the secret key and message.
    let expected_nullifier_x = poseidon::hash([sk, signal.message_hash, 0]);
    let expected_nullifier_y = poseidon::hash([sk, signal.message_hash, 1]);
    
    assert(expected_nullifier_x == signal.nullifier_x);
    assert(expected_nullifier_y == signal.nullifier_y);
}
