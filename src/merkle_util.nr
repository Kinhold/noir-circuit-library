use dep::std;

pub fn verify_inclusion(root: Field, leaf: Field, index: Field, hash_path: [Field; 32]) {
    let computed_root = std::merkle::compute_merkle_root(leaf, index, hash_path);
    assert(root == computed_root);
}
