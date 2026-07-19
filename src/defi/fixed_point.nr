// Lightweight Fixed-Point Math for DEX price discovery
// Target: nargo 1.0.0-beta.21

// Scaling factor: 1e8 for constraint-friendly precision
global SCALING_FACTOR: u128 = 100000000;

pub struct FixedPoint {
    pub inner: u64,
}

impl FixedPoint {
    pub fn new(value: u64) -> Self {
        Self { inner: value }
    }

    // Multiply two fixed-point numbers: (A * B) / SCALE
    pub fn mul(self, other: Self) -> Self {
        // Upcast to u128 to prevent overflow during intermediate multiplication
        let result = (self.inner as u128 * other.inner as u128) / SCALING_FACTOR;
        Self { inner: result as u64 }
    }

    // Divide two fixed-point numbers: (A * SCALE) / B
    pub fn div(self, other: Self) -> Self {
        assert(other.inner != 0); // Prevent division by zero
        let result = (self.inner as u128 * SCALING_FACTOR) / other.inner as u128;
        Self { inner: result as u64 }
    }
    
    // Add with overflow protection checking
    pub fn add(self, other: Self) -> Self {
        let result = self.inner as u128 + other.inner as u128;
        assert(result as u64 as u128 == result); // Ensure it fits back in u64
        Self { inner: result as u64 }
    }
}
