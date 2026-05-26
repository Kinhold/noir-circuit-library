use crate::range::verify_liquidity;

#[test]
fn test_valid_liquidity_range() {
    // Validates a balance sits within the bracket
    verify_liquidity(500, 100, 1000);
}

#[test(should_fail)]
fn test_invalid_liquidity_range() {
    // Proves the circuit successfully rejects an out-of-bounds balance
    verify_liquidity(50, 100, 1000);
}
