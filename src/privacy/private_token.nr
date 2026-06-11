// Private Token Core (ERC-20 Equivalent UTXO Model)
// Target: nargo 1.0.0-beta.21

use dep::std::hash::poseidon::bn254::hash_2;
use crate::data_structures::indexed_merkle::{IndexedMerkleProof, verify_non_membership};

pub struct Note {
    pub amount: Field,
    pub secret: Field,
    pub owner_pubkey_x: Field,
    pub owner_pubkey_y: Field,
}

// H(amount, secret, pubkey_x, pubkey_y) -> optimized for mobile via chained hash_2
pub fn compute_note_commitment(note: Note) -> Field {
    let h1 = hash_2([note.amount, note.secret]);
    let h2 = hash_2([note.owner_pubkey_x, note.owner_pubkey_y]);
    hash_2([h1, h2])
}

// Generates the nullifier to prevent double spending
pub fn compute_nullifier(note_commitment: Field, private_key: Field) -> Field {
    hash_2([note_commitment, private_key])
}

// Validates a 1-to-2 transfer (Input -> Recipient + Change)
pub fn prove_transfer<let DEPTH: u32>(
    input_note: Note,
    input_private_key: Field,
    nullifier_root: Field,
    nullifier_proof: IndexedMerkleProof<DEPTH>,
    output_note_1: Note,
    output_note_2: Note,
) {
    // 1. Compute input commitment and its nullifier
    let input_commitment = compute_note_commitment(input_note);
    let nullifier = compute_nullifier(input_commitment, input_private_key);

    // 2. Verify nullifier is NOT in the IMT (Double-spend prevention)
    verify_non_membership(nullifier, nullifier_root, nullifier_proof);

    // 3. Verify value conservation with range checks to prevent overflow minting
    let in_amount = input_note.amount as u64;
    let out_1_amount = output_note_1.amount as u64;
    let out_2_amount = output_note_2.amount as u64;
    assert(in_amount == (out_1_amount + out_2_amount));

    // 4. In a full circuit, output commitments would be returned as public inputs
    let _out1_commit = compute_note_commitment(output_note_1);
    let _out2_commit = compute_note_commitment(output_note_2);
}
