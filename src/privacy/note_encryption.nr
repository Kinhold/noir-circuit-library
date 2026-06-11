// ECIES-style Note Encryption over Baby Jubjub
// Target: nargo 1.0.0-beta.21

use dep::std::ec::tecurve::affine::Curve as BabyJubJub;
use dep::std::ec::tecurve::affine::Point as Point;
use dep::std::hash::poseidon::bn254::hash_2;

// Encrypts a note amount and nullifier blinding factor using a Poseidon stream
pub fn encrypt_note(
    amount: Field,
    blinding_factor: Field,
    ephemeral_private_key: Field,
    recipient_public_key: Point
) -> (Point, [Field; 2]) {
    let bjj = BabyJubJub::new();
    
    // 1. Generate Ephemeral Public Key (R = r * G)
    let ephemeral_public_key = bjj.mul(ephemeral_private_key, bjj.gen());

    // 2. Generate Shared Secret (S = r * P)
    let shared_secret_point = bjj.mul(ephemeral_private_key, recipient_public_key);
    
    // 3. Derive symmetric key via Poseidon (K = H(S.x, S.y))
    let symmetric_key = hash_2([shared_secret_point.x, shared_secret_point.y]);

    // 4. Encrypt payload (Field addition stream cipher for constraint optimization)
    let cipher_amount = amount + hash_2([symmetric_key, 0]);
    let cipher_blinding = blinding_factor + hash_2([symmetric_key, 1]);

    (ephemeral_public_key, [cipher_amount, cipher_blinding])
}
