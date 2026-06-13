use std::hash::poseidon;
use crate::data_structures::indexed_merkle::{IndexedMerkleProof, verify_non_membership};

pub struct Note {
    pub amount: Field,
    pub secret: Field,
    pub owner_pubkey_x: Field,
    pub owner_pubkey_y: Field,
}

pub fn compute_note_commitment(note: Note) -> Field {
    let h1 = std::hash::poseidon::hash([note.amount, note.secret]);
    let h2 = std::hash::poseidon::hash([note.owner_pubkey_x, note.owner_pubkey_y]);
    std::hash::poseidon::hash([h1, h2])
}

pub fn compute_nullifier(note_commitment: Field, private_key: Field) -> Field {
    std::hash::poseidon::hash([note_commitment, private_key])
}

pub fn prove_transfer<let DEPTH: u32>(
    input_note: Note,
    input_private_key: Field,
    nullifier_root: Field,
    nullifier_proof: IndexedMerkleProof<DEPTH>,
    output_note_1: Note,
    output_note_2: Note,
) {
    let input_commitment = compute_note_commitment(input_note);
    let nullifier = compute_nullifier(input_commitment, input_private_key);

    verify_non_membership(nullifier, nullifier_root, nullifier_proof);

    let in_amount = input_note.amount as u64;
    let out_1_amount = output_note_1.amount as u64;
    let out_2_amount = output_note_2.amount as u64;
    assert(in_amount == (out_1_amount + out_2_amount));

    let _out1_commit = compute_note_commitment(output_note_1);
    let _out2_commit = compute_note_commitment(output_note_2);
}
