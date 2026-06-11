// Recursive Proof Verification Wrapper
// Target: nargo 1.0.0-beta.21

use dep::std;

// Standard recursive verification for compressing mobile proofs
// Bounded arrays are used to keep circuit size deterministic
pub fn verify_nested_proof<let N: u32>(
    verification_key: [Field; 114],
    proof: [Field; 93],
    public_inputs: [Field; N],
    key_hash: Field
) {
    // Verifies an internal proof within this circuit
    // Requires the inner circuit to be compiled with the identical proving system
    std::verify_proof(
        verification_key.as_slice(),
        proof.as_slice(),
        public_inputs.as_slice(),
        key_hash
    );
}
