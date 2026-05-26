use dep::std;

pub fn derive(private_key: Field, note_commitment: Field, index: Field) -> pub Field {
    // Poseidon hash provides ZK-friendly, gas-efficient nullifier generation
    std::hash::poseidon::bn254::hash_3([private_key, note_commitment, index])
}
