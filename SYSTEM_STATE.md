# Trading Neural System - Current System State

This file is the short, authoritative statement of current project reality. It prevents future agents and humans from reconstructing status from memory or assuming that an object is valid merely because it exists.

Last updated: 2026-08-11

## Governance identity

- Overall governance status: ACTIVE
- Protocol version: MQVRIP v0.1
- Authoritative protocol: `MASTER_QUALITY_PROTOCOL.md`
- Approved protocol SHA-256: `6E188E56876FC76B714F5A33E2DE5562ABC743DBE2A67606A9662A174C546C6B`
- Approved AGENTS SHA-256: `B4D5DC1CB165D35171CB073D9D42503840603E31453E7073DA213AF4518EA3FD`
- Lifecycle version: CSL v0.1
- Authoritative lifecycle: `architecture/CANONICAL_SYSTEM_LIFECYCLE.md`
- Approved lifecycle SHA-256: `9F243F31D524F16E2B007413B7379E25CB14AF4EE947BB97A6502E87166E1686`
- Historical source snapshot: `Master_Quality_Verfication_Research_Integrity/MQVRIP v0.1.md`
- Project instructions: `AGENTS.md`
- Governance preflight: `quality/gates/G00_governance_preflight.ps1`
- Public-publication preflight: `quality/gates/G01_publication_preflight.ps1`
- Lifecycle preflight: `quality/gates/G02_lifecycle_preflight.ps1`
- Automatic repository preflight: `.github/workflows/quality-preflight.yml`
- Latest preflight evidence: `quality/evidence/governance_preflight.latest.json`
- Latest publication evidence: `quality/evidence/publication_preflight.latest.json`
- Latest lifecycle evidence: `quality/evidence/lifecycle_preflight.latest.json`
- Latest GitHub synchronization receipt: `quality/evidence/github_sync.latest.json`
- Controlled protocol-tamper test evidence: `quality/evidence/governance_preflight.protocol_tamper_test.json`
- Controlled instruction-tamper test evidence: `quality/evidence/governance_preflight.agents_tamper_test.json`
- Controlled line-ending-control test evidence: `quality/evidence/governance_preflight.gitattributes_test.json`
- Controlled publication-secret test evidence: `quality/evidence/publication_preflight.secret_test.json`
- Controlled lifecycle-tamper test evidence: `quality/evidence/lifecycle_preflight.tamper_test.json`

## Current phase

Governance foundation and canonical architecture-independent lifecycle CSL v0.1 are active. G00, G02, G01, remote file-identity verification, and the automatic GitHub workflow passed for the lifecycle publication checkpoint. Detailed neural architecture has not been designed or approved.

The next scientific work is limited to early price-data qualification and high-level architecture planning inside CSL. This state does not authorize model training, remote compute, model promotion, or production use.

## Public GitHub synchronization

- Repository: `ImrichV/Regime-Aware-Multiscale-Neural-Architecture`
- Visibility: PUBLIC
- Public repository policy: `PUBLIC_REPOSITORY_POLICY.md`
- Approved-path allowlist: `quality/publication/approved_paths.txt`
- Generated public manifest: `PUBLICATION_MANIFEST.json`
- Synchronization status: CSL v0.1 PUBLICATION CHECKPOINT REMOTELY VERIFIED THROUGH PULL REQUEST 3
- Remote baseline before this publication: `main` commit `50dd6c68a91e56cf03758e1f816f2be47c91fe3a`
- Publication branch: `agent/public-safety-foundation`
- Merged pull request: `https://github.com/ImrichV/Regime-Aware-Multiscale-Neural-Architecture/pull/1`
- Initial accepted public commit: `890622beb4522c9990c3ff5a7044ba75536c279a`
- Lifecycle publication pull request: `https://github.com/ImrichV/Regime-Aware-Multiscale-Neural-Architecture/pull/3`

The local project is the active working area. GitHub `main` is the latest approved public snapshot. The initial safety foundation was accepted only after G00 and G01 passed and every remote Git blob identity matched the local publication manifest.

## Current authoritative objects

| Object | Status | Meaning |
|---|---|---|
| MQVRIP v0.1 | BASELINE | Governing constitution; content identity recorded above |
| `AGENTS.md` | ACTIVE | Mandatory Codex working rules for this project tree |
| `SYSTEM_STATE.md` | ACTIVE | Current truth and authorization boundary |
| Canonical system lifecycle CSL v0.1 | ACTIVE | Mandatory architecture-independent stages, boundaries, authorization, and invalidation map; content identity recorded above |
| Governance preflight G00 | ACTIVE | Detects missing control files, protocol hash drift, and missing mandatory instructions |
| Public-publication preflight G01 | ACTIVE | Restricts public upload to allowlisted, small, content-scanned files and generates an identity manifest |
| Lifecycle preflight G02 | ACTIVE | Rejects lifecycle identity drift, missing stages/boundaries, missing persistent instructions, and missing automatic workflow wiring |
| Automatic repository quality workflow | ACTIVE, REMOTELY VERIFIED | Runs public-scope, G00, G02, and G01 checks on pull requests and changes to `main` |
| Neural architecture | NOT DESIGNED | No architecture decision has been approved |
| Data-source eligibility | NOT STARTED | No source has passed PIT and live-feed eligibility in this project |
| Training authorization | DENIED | Required data, split, model-input, and training gates do not yet exist or pass |
| Production eligibility | DENIED | No production-qualified artifact exists |

## Verified in the governance foundation

- The root protocol is an exact byte-for-byte copy of the existing MQVRIP v0.1 baseline at establishment time.
- The approved protocol content has a recorded SHA-256 identity.
- The mandatory project instructions have a recorded SHA-256 identity.
- Persistent project instructions require MQVRIP use, evidence-based completion, hard-gate compliance, change-impact analysis, downstream invalidation, and System Coherence review.
- Persistent project instructions require every material task to declare its lifecycle stages, boundaries, failure modes, required evidence, and downstream invalidation.
- A machine-executable governance preflight checks the presence and consistency of the safety foundation.
- A controlled fault injection proved that modifying the protocol without updating its approved identity is rejected.
- A second controlled fault injection proved that modifying the mandatory project instructions without updating their approved identity is rejected.
- A controlled missing-`.gitattributes` violation proved that G00 requires the cross-environment LF identity rule.
- G01 passed on the approved publication set and generated a file-identity manifest.
- A controlled fake-credential injection in an isolated copy was rejected by G01's content-safety check.
- G02 passed on CSL v0.1, all 18 lifecycle stages, all 18 boundaries, persistent instructions, current state, and automatic workflow wiring.
- A controlled lifecycle modification was rejected because its identity no longer matched the approved lifecycle SHA-256.
- A second controlled violation updated the hash but removed stage `L17`; G02 independently rejected the incomplete structure.
- The first remote workflow run rejected cross-environment line-ending identity drift; a repository-wide LF rule corrected the root cause, and the next GitHub workflow run passed all checks.
- All 13 approved public file identities matched the regenerated local publication manifest after the portability fix.

These checks verify governance setup only. They do not validate any future data, architecture, model, result, or production behavior.

## Active blockers and unresolved items

### Blockers before implementation or training

- Local Git remains unavailable. Remote GitHub version control is connected through the authorized GitHub integration. Important implementation and runs must reference a verified published GitHub commit; the initial safety baseline is commit `890622beb4522c9990c3ff5a7044ba75536c279a`. Unpublished local state is not a reproducible run identity.
- The Master System Architecture Specification does not yet exist.
- No executable component-specific MQVRIP gates exist beyond the foundation controls G00, G01, and G02. Component gates must be added only when their real lifecycle stages require them.
- No evidence registry or dependency invalidation engine exists yet. These should be added only when real artifacts and dependencies make them necessary.
- GitHub required-check branch protection is not configured or verified because the connected integration does not expose repository rule management. The workflow runs automatically and Codex instructions prohibit merging without a pass, but a repository administrator could still manually bypass that procedural control. Reconsider branch protection before collaboration broadens or expensive compute begins.

### Scientific and data blockers

- Stooq universe, survivorship, delisting, corporate-action, and PIT suitability are unresolved.
- Stooq historical semantics versus Alpaca SIP live semantics are unresolved.
- No proposed non-price source has been granted PIT or future live-feed eligibility.
- Observation identity, split manifests, leakage controls, model-input contracts, objectives, and evaluation partitions are not yet defined.
- No architecture, module, model, training run, or prediction has any validated status.

## Rejected, stale, or production-eligible objects

- Rejected objects: none recorded yet.
- Stale objects: none recorded yet.
- Production-eligible objects: none.

Absence from these lists is not evidence of eligibility. An object becomes eligible only through explicit gate evidence and a state update.

## Next permitted work

1. Qualify the early Stooq-versus-Alpaca historical/live price-data constraint before serious price-model architecture decisions.
2. Compare high-level architecture alternatives and develop the Master System Architecture Specification inside CSL `L01`/`B01`.
3. As each real component is defined, add the smallest necessary contract, gate, evidence output, and invalidation relationship before allowing risky downstream work.

## Required update rule

Update this file whenever work changes any of the following:

- protocol identity or version;
- project phase or next permitted task;
- validation status;
- blockers or uncertainties;
- rejected, stale, invalidated, or promoted artifacts;
- architecture, data, model, training, remote-compute, or production eligibility;
- evidence locations or required gates.

Never preserve an outdated reassuring status after the underlying evidence or dependency changes.
