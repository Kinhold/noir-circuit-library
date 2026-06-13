// Private State Transition Logic
// Target: nargo 1.0.0-beta.21

use dep::std::hash::poseidon;

pub struct StateTransition {
    pub old_state_hash: Field,
    pub new_state_hash: Field,
    pub state_variables: [Field; 4],
}

pub fn verify_transition(transition: StateTransition) {
    // Reconstruct the new state from the old state + variables
    // In a real rollup, this proves the state advanced correctly
    let computed_new_state = poseidon::hash([
        transition.old_state_hash,
        transition.state_variables[0],
        transition.state_variables[1],
        transition.state_variables[2],
        transition.state_variables[3]
    ]);
    
    assert(computed_new_state == transition.new_state_hash);
}
