use std::schnorr;

pub fn verify_auth(
    pub_key_x: Field,
    pub_key_y: Field,
    signature: [Field; 64],
    message: [u8; 32]
) {
    let valid = schnorr::verify_signature(pub_key_x, pub_key_y, signature, message);
    assert(valid);
}
