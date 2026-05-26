use dep::std;

fn main(secret: Field, public_hash: pub Field) {
    // Hash the private secret
    let computed_hash = std::hash::pedersen_hash([secret]);
    
    // Assert the computed hash matches the public hash
    assert(computed_hash == public_hash);
}
