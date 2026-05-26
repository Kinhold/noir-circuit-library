use dep::std;

pub fn verify_swap_secret(secret: Field, expected_hash: pub Field) {
    // Standard primitive for cross-chain atomic swaps
    let computed_hash = std::hash::poseidon::bn254::hash_1([secret]);
    assert(computed_hash == expected_hash);
}
