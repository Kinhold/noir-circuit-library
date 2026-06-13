use poseidon;

pub struct StateTransition {
    pub old_state_hash: Field,
    pub new_state_hash: Field,
    pub state_variables: [Field; 4],
}

pub fn verify_transition(transition: StateTransition) {
    let h1 = poseidon::hash([transition.old_state_hash, transition.state_variables[0]]);
    let h2 = poseidon::hash([h1, transition.state_variables[1]]);
    let h3 = poseidon::hash([h2, transition.state_variables[2]]);
    let computed_new_state = poseidon::hash([h3, transition.state_variables[3]]);
    
    assert(computed_new_state == transition.new_state_hash);
}
