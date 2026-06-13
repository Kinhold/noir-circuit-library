use std::hash::poseidon;

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
    assert(proof.low_leaf_value as u64 < nullifier as u64);
    let is_end = proof.low_leaf_next_value == 0;
    assert(is_end | (nullifier as u64 < proof.low_leaf_next_value as u64));

    let low_leaf_hash = poseidon::hash([
        proof.low_leaf_value, 
        proof.low_leaf_next_index, 
        proof.low_leaf_next_value, 
        0
    ]);

    let mut current_hash = low_leaf_hash;
    let mut index = proof.low_index as u64;

    for i in 0..DEPTH {
        let is_right = (index & 1) == 1;
        let sibling = proof.low_path[i];
        
        if is_right {
            current_hash = poseidon::hash([sibling, current_hash]);
        } else {
            current_hash = poseidon::hash([current_hash, sibling]);
        }
        index >>= 1;
    }

    assert(current_hash == root);
}
