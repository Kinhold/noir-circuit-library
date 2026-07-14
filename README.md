# Noir Circuit Library

Kinhold’s shared Noir primitive shelf for `kinhold.io`.

This repository is a **working circuit library prototype**, not a
production-grade or audited cryptography package. Its canonical package
entrypoint is `src/lib.nr`.

## Exported package surface

The library currently exports:

- `primitives`: Pedersen Merkle-root calculation, nullifier derivation, HTLC
  checks, state updates, and basic order constraints.
- `data_structures`: indexed Merkle non-membership and state-transition
  prototypes.
- `defi`: fixed-point arithmetic, HTLC, and order-matching prototypes.
- `privacy`: note commitment/encryption, private-token, range, and
  signal/nullifier prototypes.
- `range`: a small liquidity-bracket constraint.

Every exported module is compiler-checked. This does **not** establish protocol
correctness, security, interoperability, or suitability for production.

## Authentication is intentionally unavailable

There is no authentication or signature-verification function in the exported
module graph. The old function under `primitives/auth.nr` always returned
success, while a second wrapper depended on a missing `std::schnorr` API.
Both are preserved only as clearly disabled historical source in
[`quarantine/`](quarantine/README.md), outside `src/`.

Downstream circuits must provide and test a real signature scheme; do not use
the quarantined code.

## Integration

For development against the unreleased branch:

```toml
[dependencies]
noir_circuit_library = { git = "https://github.com/Kinhold/noir-circuit-library", branch = "main" }
```

Branch dependencies are mutable. Pin a reviewed release tag once one exists;
until then, pin and review a specific repository revision in your own lockfile
workflow.

## Toolchain and checks

CI installs and runs exactly `nargo 1.0.0-beta.21`:

```bash
noirup -v 1.0.0-beta.21
nargo check
nargo test
```

Nargo does not accept prerelease versions in the manifest's
`compiler_version` requirement, so the authoritative prerelease pin lives in
CI and this documentation. Four tests currently cover range checks, public
primitive composition, and invalid-order rejection.

## Versioning intent

- Current status: unreleased prototype.
- First intended tag: `v0.1.0`, only after API review and a clean pinned CI run.
- `0.x` releases may change APIs and hash constructions.
- A `1.0.0` release requires a documented security model, external review,
  stable vectors, and downstream integration tests.

---
*Developed and maintained through mobile-first terminal infrastructure.*

## 🏆 The First Mobile Prover (May 28, 2026)

This repository also serves as a historical proof-of-concept. The metrics below represent an early mobile proving checkpoint. Treat them as development telemetry, not a benchmark guarantee for every circuit in this library.

**Target Hardware:** Motorola Moto G (Android) via proot-distro/Termux
**Toolchain:** nargo 1.0.0-beta.21 + bb 5.0.0-nightly.20260324

| Pipeline Stage | Execution Time |
| --- | --- |
| **Witness Generation (`nargo execute`)** | 452 ms |
| **Ultra Honk Proving (`bb prove`)** | 500 ms |
| **Proof Verification (`bb verify`)** | 170 ms |

*Raw telemetry and execution logs are being normalized as the library is packaged under the Kinhold umbrella.*

## Current packaging status

- usable as an explicitly experimental source library
- module graph and tests compile on the pinned beta toolchain
- no release tag, audit, or production-security claim
