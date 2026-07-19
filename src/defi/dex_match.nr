// ZK Order Matching Engine
// Target: nargo 1.0.0-beta.21

use crate::defi::fixed_point::FixedPoint;

pub struct Order {
    pub asset_id: Field,
    pub amount: u64,
    pub price: FixedPoint,
    pub is_ask: bool,
}

pub fn verify_match(maker: Order, taker: Order) {
    assert(maker.asset_id == taker.asset_id);
    assert(maker.is_ask != taker.is_ask);
    
    if maker.is_ask {
        assert(taker.price.inner >= maker.price.inner);
    } else {
        assert(taker.price.inner <= maker.price.inner);
    }
}
