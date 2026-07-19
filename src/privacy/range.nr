// Hidden Balance Bracket Proofs
// Target: nargo 1.0.0-beta.21

pub fn verify_in_range(value: u64, min: u64, max: u64) {
    assert(value >= min);
    assert(value <= max);
}
