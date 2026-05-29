# Noir Circuit Library

A production-grade collection of Zero-Knowledge primitives written in Noir for the Aztec Network. This library provides foundational cryptographic infrastructure for privacy-preserving dApps, decentralized exchanges, and secure state transitions.

## Architecture

This repository is configured as a library (`type = "lib"`) to be imported as a dependency for downstream contracts. It provides raw, mathematically sound constraints for ZK protocols.

### Core Primitives

* **`merkle_util.nr`**: Inclusion verification against a provided root.
* **`nullifier.nr`**: Poseidon-based nullifier derivation for double-spend prevention.
* **`auth.nr`**: Schnorr signature verification for identity and wallet authentication.
* **`range.nr`**: Hidden balance bracket proofs for private liquidity verification.
* **`dex_match.nr`**: Arbitrage-ready order matching logic validating private makers against public takers.
* **`htlc.nr`**: Hash Time-Locked Contract secret verification for cross-chain atomic swaps.
* **`state.nr`**: Private state transition proofs.

## Integration

Add this library to your project's `Nargo.toml`:

```toml
[dependencies]
noir_circuit_library = { git = "https://github.com/StationaryDev37/noir-circuit-library", tag = "main" }
```

## Compilation & Testing

This package requires Nargo `>=0.1.0`. To compile the circuits locally and verify the constraint logic against the test suite:

```bash
nargo check
nargo test
```

---
*Developed and maintained entirely via mobile terminal infrastructure.*

## 🏆 The First Mobile Prover (May 28, 2026)

This repository serves as a historical proof-of-concept. The metrics below represent the first documented instance of a full Barretenberg Ultra Honk proof being generated and verified natively on an Android mobile CPU. No cloud provers. No remote execution. Just raw, optimized ZK on a consumer device.

**Target Hardware:** Motorola Moto G (Android) via proot-distro/Termux
**Toolchain:** nargo 1.0.0-beta.21 + bb 5.0.0-nightly.20260324

| Pipeline Stage | Execution Time |
| --- | --- |
| **Witness Generation (`nargo execute`)** | 452 ms |
| **Ultra Honk Proving (`bb prove`)** | 500 ms |
| **Proof Verification (`bb verify`)** | 170 ms |

*Raw telemetry and execution logs are available in the repository.*
