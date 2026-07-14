use crate::primitives::dex_match::match_orders;
use crate::primitives::htlc::verify_swap_secret;
use crate::primitives::nullifier::derive;
use crate::primitives::state::verify_update;
use crate::range::verify_liquidity;

#[test]
fn test_public_primitives_work_together() {
    let secret = 42;
    let secret_hash = std::hash::pedersen_hash([secret]);
    verify_swap_secret(secret, secret_hash);

    let old_state = 7;
    let action = derive(11, 13, 17);
    let next_state = std::hash::pedersen_hash([old_state, action]);
    verify_update(old_state, action, next_state);

    match_orders(100, 20, 105, 10);
    verify_liquidity(500, 100, 1_000);
}

#[test(should_fail)]
fn test_public_primitives_reject_invalid_order() {
    match_orders(105, 20, 100, 10);
}
