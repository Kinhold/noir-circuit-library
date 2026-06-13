use std::hash::poseidon;

pub fn encrypt_note(
    amount: Field,
    blinding_factor: Field,
    shared_secret_x: Field,
    shared_secret_y: Field
) -> [Field; 2] {
    let symmetric_key = poseidon::hash([shared_secret_x, shared_secret_y]);
    let cipher_amount = amount + poseidon::hash([symmetric_key, 0]);
    let cipher_blinding = blinding_factor + poseidon::hash([symmetric_key, 1]);

    [cipher_amount, cipher_blinding]
}
