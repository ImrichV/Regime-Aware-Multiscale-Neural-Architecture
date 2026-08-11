# Public GitHub Repository Policy

Repository: `ImrichV/Regime-Aware-Multiscale-Neural-Architecture`

Visibility: **PUBLIC**

## Purpose

GitHub is the permanent history of approved, small, public project artifacts. It is not an automatic mirror of the entire computer or research workspace.

Assume that anything uploaded can be copied permanently, including content later deleted from the visible branch.

## Authoritative roles

- The local project folder is the active working area.
- GitHub `main` is the latest approved public snapshot.
- A GitHub branch is a public proposed snapshot under review. A branch is not private.
- `SYSTEM_STATE.md` describes project truth and eligibility; machine evidence determines whether publication and synchronization claims are valid.

## Allowed public artifacts

Only paths explicitly listed in `quality/publication/approved_paths.txt` may be published by the controlled workflow.

Eligible categories include:

- quality and architecture specifications;
- source code and scripts;
- schemas and contracts;
- small deterministic tests and fixtures;
- safe configuration templates containing no credentials;
- artifact manifests and cryptographic hashes;
- human-readable public reports;
- concise public evidence that contains no private paths or data.

## Forbidden public artifacts

Do not publish:

- API keys, tokens, passwords, credentials, private keys, or `.env` files;
- raw, private, licensed, or redistributability-uncertain datasets;
- sensitive logs or reports containing credentials, private paths, or proprietary details;
- model weights, optimizer states, checkpoints, or large training outputs;
- caches, virtual environments, temporary files, partial downloads, or editor state;
- personal documents or information unrelated to the public research record;
- proprietary execution logic or exploitable production trading information;
- anything whose public eligibility is uncertain.

Uncertainty means publication is blocked until a human resolves it.

## Publication cadence

Perform a publication decision:

- after each completed logical task that changes project truth;
- immediately after a critical protocol, architecture, data, or correctness fix;
- before expensive training or remote compute;
- at stable milestones during long work.

Do not publish every keystroke, temporary experiment, incomplete draft, or generated runtime artifact.

## Mandatory publication workflow

1. Complete the local task and update `SYSTEM_STATE.md` if project truth changed.
2. Run G00 governance preflight.
3. Run G01 public-publication preflight.
4. Review the generated `PUBLICATION_MANIFEST.json`.
5. Create or update a GitHub branch, never treating it as private.
6. Upload only the allowlisted files plus the generated publication manifest.
7. Verify every remote Git blob identity against the approved local manifest.
8. Open a pull request showing the proposed change.
9. Merge into `main` only after required checks pass and the remote snapshot matches.
10. Save a local synchronization receipt containing the remote commit identity and verification result.

## Failure behavior

Any missing governance file, failed MQVRIP gate, secret-pattern match, forbidden path, excessive file size, unexpected file, hash mismatch, or remote mismatch blocks publication.

Never weaken the gate merely to make a publication succeed.
