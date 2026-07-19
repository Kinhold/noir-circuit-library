
pub fn derive(private_key: Field, note_commitment: Field, index: Field) -> Field {
    // Domain inputs are committed with the beta.21 standard-library Pedersen hash.
    std::hash::pedersen_hash([private_key, note_commitment, index])
}
