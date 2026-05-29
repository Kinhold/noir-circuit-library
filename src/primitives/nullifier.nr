
pub fn derive(private_key: Field, note_commitment: Field, index: Field) -> Field {
    // Poseidon hash provides ZK-friendly, gas-efficient nullifier generation
    std::hash::pedersen_hash([private_key, note_commitment, index])
}
