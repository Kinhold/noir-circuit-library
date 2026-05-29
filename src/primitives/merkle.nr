use std::hash::pedersen_hash;

pub fn compute_merkle_root(leaf: Field, index: Field, hash_path: [Field; 32]) -> Field {
    let mut current = leaf;
    let index_bits: [bool; 32] = index.to_le_bits();
    
    for i in 0..32 {
        let is_right = index_bits[i];
        let sibling = hash_path[i];
        
        let (left, right) = if is_right {
            (sibling, current)
        } else {
            (current, sibling)
        };
        
        current = pedersen_hash([left, right]);
    }
    current
}
