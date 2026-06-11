// PLUME-lite Anonymous Identity / Deterministic Nullifiers
// Target: nargo 1.0.0-beta.21
// Note: Uses BabyJubJub instead of secp256k1 to keep mobile constraints low

use dep::std::ec::tecurve::affine::Curve as BabyJubJub;
use dep::std::ec::tecurve::affine::Point as Point;
use dep::std::hash::poseidon::bn254::hash_2;

pub struct PlumeSignal {
    pub nullifier: Point,
    pub pk: Point,
    pub message_hash: Field,
}

// Hashes a message directly to a point on the BabyJubJub curve
pub fn hash_to_curve(message_hash: Field) -> Point {
    let bjj = BabyJubJub::new();
    // Deterministic generation: taking the message hash as a seed scalar
    // In a full PLUME implementation, this requires try-and-increment or SWU
    bjj.mul(message_hash, bjj.gen())
}

// Generate the deterministic nullifier: nullifier = sk * H_curve(message)
pub fn compute_plume_nullifier(sk: Field, message_hash: Field) -> Point {
    let bjj = BabyJubJub::new();
    let hashed_point = hash_to_curve(message_hash);
    bjj.mul(sk, hashed_point)
}

// Verify the PLUME signal (Auth without identity reveal)
pub fn verify_signal(sk: Field, signal: PlumeSignal) {
    let bjj = BabyJubJub::new();
    
    // 1. Verify Public Key derives from Secret Key
    let derived_pk = bjj.mul(sk, bjj.gen());
    assert(derived_pk.x == signal.pk.x);
    assert(derived_pk.y == signal.pk.y);

    // 2. Verify Nullifier matches the deterministic computation
    let expected_nullifier = compute_plume_nullifier(sk, signal.message_hash);
    assert(expected_nullifier.x == signal.nullifier.x);
    assert(expected_nullifier.y == signal.nullifier.y);
}
