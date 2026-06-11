// Production-grade Indexed Merkle Tree for non-membership proofs
// Target: nargo 1.0.0-beta.21

use dep::std::hash::poseidon::bn254::hash_2;
use dep::std::hash::poseidon::bn254::hash_4;

pub struct IndexedMerkleProof<let DEPTH: u32> {
    pub low_leaf_value: Field,
    pub low_leaf_next_value: Field,
    pub low_leaf_next_index: Field,
    pub low_index: Field,
    pub low_path: [Field; DEPTH],
}

pub fn verify_non_membership<let DEPTH: u32>(
    nullifier: Field,
    root: Field,
    proof: IndexedMerkleProof<DEPTH>
) {
    // 1. Verify low_leaf is strictly less than the nullifier
    assert(proof.low_leaf_value as u64 < nullifier as u64);
    
    // 2. Verify nullifier is strictly less than next_value (or next is 0 for end of tree)
    let is_end = proof.low_leaf_next_value == 0;
    assert(is_end | (nullifier as u64 < proof.low_leaf_next_value as u64));

    // 3. Hash the low leaf (H(value, next_index, next_value, 0))
    let low_leaf_hash = hash_4([
        proof.low_leaf_value, 
        proof.low_leaf_next_index, 
        proof.low_leaf_next_value, 
        0
    ]);

    // 4. Verify inclusion against the root using low_path
    let mut current_hash = low_leaf_hash;
    let mut index = proof.low_index as u64;

    for i in 0..DEPTH {
        let is_right = index & 1 == 1;
        let sibling = proof.low_path[i];
        
        if is_right {
            current_hash = hash_2([sibling, current_hash]);
        } else {
            current_hash = hash_2([current_hash, sibling]);
        }
        index >>= 1;
    }

    assert(current_hash == root);
}
