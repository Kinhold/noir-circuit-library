
pub fn verify_swap_secret(secret: Field, expected_hash: Field) {
    // Standard primitive for cross-chain atomic swaps
    let computed_hash = std::hash::pedersen_hash([secret]);
    assert(computed_hash == expected_hash);
}
