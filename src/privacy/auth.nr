// Schnorr Authentication Wrapper
// Target: nargo 1.0.0-beta.21

use dep::std;

pub fn verify_auth(
    pub_key_x: Field,
    pub_key_y: Field,
    signature: [Field; 64],
    message: [u8; 32]
) {
    let valid = std::schnorr::verify_signature(pub_key_x, pub_key_y, signature, message);
    assert(valid);
}
