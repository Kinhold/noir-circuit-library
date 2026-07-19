# Quarantined prototypes

Files in this directory are deliberately outside `src/` and are not part of
the Nargo package module graph.

- `auth_noop_stub.nr.disabled` is the historical authentication placeholder.
  It always accepts and provides no authentication or signature verification.
- `schnorr_wrapper.nr.disabled` targets a `std::schnorr` API that is absent
  from Nargo `1.0.0-beta.21`; it has never been validated as a package API.
- `recursion.nr.disabled` targets an old recursive-verification API and remains
  archival until it can be redesigned and tested against a supported backend.

Do not copy these prototypes into a circuit. Authentication and recursive
verification are intentionally absent from the exported library surface.
