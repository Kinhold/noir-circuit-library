use dep::std;

pub fn verify_signature(pub_key_x: Field, pub_key_y: Field, signature: [u8; 64], message: [u8; 32]) {
    let is_valid = std::schnorr::verify_signature(pub_key_x, pub_key_y, signature, message);
    assert(is_valid);
}
