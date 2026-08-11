# Trading Neural System - Canonical End-to-End Lifecycle

Lifecycle version: **CSL v0.1**

Status: **ACTIVE GOVERNING BASELINE**

Scope: architecture-independent control map from proposed work and source data through live operation, monitoring, retraining, and retirement.

## 1. Purpose

This document defines the one canonical lifecycle that every material project object and task must follow. Its purpose is to prevent code, data, interfaces, experiments, models, and production behavior from being created as disconnected local pieces whose wider consequences are forgotten.

It is subordinate to `MASTER_QUALITY_PROTOCOL.md` and must be used together with `AGENTS.md` and `SYSTEM_STATE.md`.

This document is deliberately a map, not a complete implementation of every future gate. Component-specific contracts and tests are added only when the corresponding component becomes real.

## 2. Non-negotiable use rule

Before material work begins, the task must identify:

1. the lifecycle stage or stages it affects;
2. the boundary or boundaries it crosses or changes;
3. the authoritative inputs and intended outputs;
4. the failure modes that could invalidate a scientific or operational conclusion;
5. the evidence required before the task may be called complete;
6. the upstream assumptions and downstream artifacts affected by a change.

If the work cannot be mapped, stop. Either the work is outside project scope or this lifecycle must be deliberately revised and reapproved before the work proceeds.

No component may bypass a boundary because its implementation makes the boundary inconvenient.

## 3. Meaning of a stage and boundary

- A **stage** owns a distinct responsibility and produces identifiable artifacts or decisions.
- A **boundary** is an authorization point between stages. Crossing it requires a defined contract and evidence.
- An **artifact** is any object capable of changing a conclusion, including specifications, code, schemas, data, configurations, bundles, checkpoints, models, evaluations, packages, and live outputs.
- **Evidence** is a reproducible machine record plus a human-readable conclusion appropriate to the risk.
- **Authorization** means the required evidence exists and all applicable hard gates pass. A file merely existing is not authorization.

## 4. Canonical lifecycle map

```text
L00 Governance and task authorization
  -> L01 Requirements, architecture, and contract qualification
  -> L02 Source and modality qualification
  -> L03 Raw acquisition and preservation
  -> L04 Point-in-time and semantic qualification
  -> L05 Canonical transformation and validation
  -> L06 Observation, dataset, and split construction
  -> L07 Model-input transformation
  -> L08 Experiment specification and sealed bundle
  -> L09 Transfer and compute-provider qualification
  -> L10 Pre-training qualification
  -> L11 Training and checkpoint execution
  -> L12 Model-artifact retrieval and provenance
  -> L13 Independent evaluation and value qualification
  -> L14 Assembly and integration qualification
  -> L15 Production packaging, parity, and replay
  -> L16 Live inference and feed-health control
  -> L17 Monitoring, incident handling, retraining, replacement, and retirement
```

The map is sequential for authorization, but iteration is expected. Returning upstream creates a new version or experiment and triggers impact analysis; it never silently rewrites earlier evidence.

## 5. Lifecycle stages

| ID | Stage | Required result | Hard rule |
|---|---|---|---|
| `L00` | Governance and task authorization | An explicitly scoped task with lifecycle impact, applicable MQVRIP rules, blockers, gates, evidence, and change impact identified | Conflicting governance, unknown scope, or an applicable blocker means stop |
| `L01` | Requirements, architecture, and contract qualification | Approved requirements or component specification defining input, timing, output, interface, training, evidence, value, failure, reproduction, and production behavior | No serious component development from an attractive idea alone; architecture must obey MQVRIP and this lifecycle |
| `L02` | Source and modality qualification | Source decision covering provenance, historical PIT feasibility, recurring future availability, licensing/publication eligibility, and intended role | No affirmative PIT path or credible future source means ineligible for production-intended model development |
| `L03` | Raw acquisition and preservation | Immutable raw artifact, acquisition receipt, source request/response metadata, content identity, completeness checks, and quarantine record where needed | Raw content is never silently repaired, overwritten, or treated as valid because a download completed |
| `L04` | Point-in-time and semantic qualification | Explicit event/publication/availability/ingestion/revision/effective-time meaning, revision behavior, universe meaning, and historical/live semantic assessment | Unknown availability time, revision history, universe semantics, or material source meaning is a blocker |
| `L05` | Canonical transformation and validation | Versioned canonical contract, deterministic transformation, lineage, schema/invariant checks, and golden known-answer fixtures | Downstream code never guesses field, unit, identifier, missingness, or timestamp meaning |
| `L06` | Observation, dataset, and split construction | Stable observation identities, dataset manifest, immutable split manifest, fitting-scope rules, leakage audit, and lockbox governance | Overlap, future contamination, or untraceable observation membership blocks downstream use |
| `L07` | Model-input transformation | Versioned transformation with exact input/output schema, tensor shape/dtype/order/mask/time semantics, learned-statistic scope, and golden tensor outputs | Canonical validity does not imply model-input validity; failed known-answer or fitting-scope checks stop work |
| `L08` | Experiment specification and sealed bundle | Predeclared question, datasets, splits, architecture/configuration, objectives, seeds, evaluation, environment, commands, expected checks, and cryptographically identified bundle | Remote compute may not infer or silently alter scientific meaning |
| `L09` | Transfer and compute-provider qualification | Source/destination identity equality, qualified environment, exact bundle identity, expected runtime, and provider-neutral execution adapter | Transfer success messages are insufficient; any identity or environment mismatch blocks execution |
| `L10` | Pre-training qualification | Remote golden tests, forward/backward smoke test, checkpoint round-trip, synthetic-signal test, and tiny-overfit test where applicable | Expensive training remains denied until every applicable pre-training gate passes |
| `L11` | Training and checkpoint execution | Supervised run state, anomaly detection, verified resumable checkpoints, deterministic recovery rules, and complete run log | Silent NaN/Inf, unknown restart state, unverified checkpoint, or undeclared experiment change invalidates the run |
| `L12` | Model-artifact retrieval and provenance | Retrieved model/checkpoints with transfer identity, complete provenance, code/data/split/environment linkage, and explicit eligibility state | A weight file without reconstructable provenance is research debris, not an eligible model |
| `L13` | Independent evaluation and value qualification | Frozen candidate evaluated outside the training loop against declared baselines, robustness checks, negative controls, ablations, and untouched partitions as applicable | Complexity, source, or module that fails to demonstrate justified value is not promoted |
| `L14` | Assembly and integration qualification | Contract-compatible modules with aligned time, masks, identifiers, normalization ownership, missing-modality behavior, gradients/routing, and end-to-end tests | Valid modules do not imply a valid assembly; unexplained integration behavior blocks promotion |
| `L15` | Production packaging, parity, and replay | Frozen inference package, exact dependencies, research/production parity, historical replay, failure tests, and rollback identity | Unexplained research/production difference or unsafe failure behavior blocks deployment |
| `L16` | Live inference and feed-health control | Qualified live inputs, freshness/semantic/schema checks, prediction identity and lineage, observable failure policy, and decision/output record | Stale, corrupt, semantically changed, or required missing input follows the qualified fail/abstain policy; no silent fallback |
| `L17` | Monitoring, incident handling, retraining, replacement, and retirement | Health evidence, drift/calibration/performance monitoring, incidents, challenger decisions, requalification, replacement, rollback, and retirement record | No automatic promotion merely because a newer model exists; material changes re-enter the applicable upstream stages |

## 6. Canonical boundaries

| ID | Transition | Minimum acceptance evidence | Failure behavior and impact |
|---|---|---|---|
| `B00` | Proposed work -> authorized project task | Lifecycle Impact Declaration, applicable MQVRIP sections, blocker check, acceptance evidence plan | Unmapped, contradictory, prohibited, or unjustified work does not start |
| `B01` | Proposed architecture/component -> serious development | Component contract answering MQVRIP Architecture Entry Gate questions, alternatives considered, Occam justification, dependency impact | Reject or return to design; no implementation authorization |
| `B02` | Candidate source/modality -> acquisition eligibility | Provenance, access/licensing decision, PIT investigation plan, future-live feasibility, intended use | Reject/quarantine; source cannot silently enter production-intended research |
| `B03` | Acquisition attempt -> accepted raw artifact | Acquisition receipt, hash, completeness/schema checks, preserved original bytes, anomaly classification | Reject/quarantine raw artifact; all derived objects prohibited |
| `B04` | Raw artifact -> PIT/semantically qualified source data | Time-semantics proof, revisions/universe/corporate-action assessment, historical/live comparison plan or result | Block eligibility; dependent canonical/data/model objects invalid |
| `B05` | Qualified source data -> accepted canonical artifact | Canonical contract, transformation version, lineage, schema/invariants, golden fixture, independent check where risk warrants | Canonical artifact rejected; all downstream datasets and models stale/invalid |
| `B06` | Canonical artifacts -> accepted research dataset/splits | Observation IDs, dataset and split manifests, no-overlap/future-contamination proof, fitting-scope and lockbox controls | Dataset/splits rejected; all inputs, bundles, models, and evaluations invalid |
| `B07` | Research dataset -> accepted model input | Transformation identity/configuration, schema/tensor contract, frozen learned statistics, golden outputs, causality/order/mask tests | Model input rejected; no experiment or training authorization |
| `B08` | Model inputs plus research question -> sealed experiment | Predeclared specification, exact identities, environment, seeds, commands, expected tests and output manifest | Bundle not sealed; no provider transfer or expensive experiment |
| `B09` | Local sealed bundle -> accepted remote execution environment | Destination hashes equal source, environment qualified, code/config/data/manifests exact, provider adapter changes no semantics | Remote work stops; transferred artifacts quarantined or retransferred |
| `B10` | Qualified remote environment -> full training authorization | Applicable golden, synthetic, tiny-overfit, smoke, gradient, and checkpoint round-trip checks pass | Training authorization denied; investigate without expensive training |
| `B11` | Authorized run -> training complete | Declared run executed without invalidating anomaly, checkpoints verified, logs complete, no silent spec change | Run failed/invalid; artifacts remain ineligible |
| `B12` | Training output -> eligible model artifact | Transfer identity, complete provenance, artifact/run manifest, reproducibility status, anomaly record | Model classified as research debris/experimental and cannot be promoted |
| `B13` | Eligible model -> validated candidate | Independent evaluation, baselines, uncertainty/robustness, negative controls, value evidence, untouched evaluation where applicable | Reject, retain as experimental, or redesign; no assembly/production claim |
| `B14` | Validated components -> integration-validated assembly | Interface/contract tests, temporal and cross-modal alignment, missing-input policy, routing/gradient tests, end-to-end known signal, value ablation | Assembly rejected; component validity is not reused as assembly evidence |
| `B15` | Validated assembly -> production-qualified package | Frozen package, exact environment, research/production parity, replay, live-failure tests, independent final audit, rollback plan | Deployment denied; package remains a candidate |
| `B16` | Production-qualified package plus live inputs -> accepted live prediction | Feed certificates/health, exact package identity, input/prediction lineage, inference checks, qualified abstain/failure behavior | Prediction suppressed/quarantined and incident policy invoked as specified |
| `B17` | Live evidence/new data/change -> continued use, retraining, replacement, or retirement | Monitoring evidence, incident/change record, challenger specification, applicable requalification and comparison | Incumbent remains, rolls back, or retires according to evidence; no automatic replacement |

## 7. Universal boundary contract

Every boundary-specific contract must define, at the level justified by current risk:

1. **Input identity:** exact accepted artifact(s), version(s), and content identity.
2. **Timing legality:** which information exists and is eligible at the decision moment.
3. **Output identity:** exact artifact or decision produced.
4. **Schema and semantics:** types, shapes, units, identifiers, ordering, missingness, masks, and meaning.
5. **Invariants:** properties that must always hold.
6. **Evidence:** tests, measurements, thresholds, independent checks, and saved records.
7. **Failure behavior:** block, quarantine, abstain, warn, retry, rollback, or escalate; never an undeclared fallback.
8. **Dependencies and invalidation:** upstream assumptions and downstream artifacts affected by change or failure.

Fields not yet knowable must be marked `UNRESOLVED` and treated according to risk. They must not be filled with plausible guesses.

## 8. Lifecycle Impact Declaration

Every material task must record this compact declaration before implementation:

```text
Lifecycle stages:
Lifecycle boundaries:
Authoritative inputs:
Intended outputs:
Contracts/invariants affected:
Primary failure modes:
Required gates/evidence:
Upstream dependencies:
Downstream invalidation if changed:
Occam justification:
Authorization blockers:
```

For low-risk work, entries may be brief. For high-risk timing, leakage, split, model-input, remote-transfer, promotion, or production work, entries require stronger detail and independent evidence.

## 9. Definition of done

A material task is complete only when:

- its actual work still matches the declared stages and boundaries;
- required contracts and authoritative objects agree;
- applicable tests and gates pass;
- important guards have been observed rejecting a controlled violation where practical;
- evidence is saved and its claim is no broader than what was tested;
- downstream artifacts are invalidated or revalidated after upstream change;
- obsolete assumptions, interfaces, files, tests, and status statements are removed or updated;
- `SYSTEM_STATE.md` reflects current truth;
- a whole-system coherence review finds no unresolved contradiction;
- added complexity has a concrete reason.

`IMPLEMENTED`, `TESTED`, `VALIDATED`, `INTEGRATION_VALIDATED`, and `PRODUCTION_QUALIFIED` are different states. Completion language must use the state actually earned.

## 10. Change and invalidation rule

Every material change follows:

```text
changed object
  -> direct contracts and evidence reconsidered
  -> downstream dependent artifacts marked STALE / INVALID / REVALIDATION REQUIRED
  -> only affected checks repeated at risk-appropriate depth
  -> obsolete assumptions and paths removed
  -> system state updated
```

Initially, dependency impact may be recorded explicitly in `SYSTEM_STATE.md` and task evidence. An automated dependency engine is added only when the number of real artifacts makes manual control unreliable.

A lifecycle change requires a new lifecycle version or explicit compatible revision, rationale, impact analysis, updated approved SHA-256, G00/G02 verification, controlled fault testing where the guard changes, public synchronization, and human approval for any weakened protection.

## 11. Authorization matrix

| Activity | Minimum lifecycle authorization |
|---|---|
| Architecture/component design | `B00` and `B01` requirements addressed; unresolved material semantics remain explicit blockers |
| Source ingestion for qualification | `B00` and `B02`; raw output remains quarantined until `B03`/`B04` |
| Production-intended dataset construction | `B02` through `B06` accepted |
| Model-input construction | `B07` accepted |
| Expensive or important training | `B08` through `B10` accepted |
| Model validation claim | `B12` and `B13` accepted |
| Assembly validation claim | `B14` accepted |
| Production deployment | `B15` accepted |
| Live prediction acceptance | `B16` accepted continuously |
| Retraining/replacement | `B17` plus all affected upstream boundaries requalified |

The most restrictive applicable rule governs. Exploratory work must be labeled honestly and may not borrow eligibility from later stages.

## 12. Roles

- **Human:** resolves ambiguous semantics, material scientific/architecture tradeoffs, weakened protections, destructive/expensive decisions, and unacceptable residual uncertainty.
- **Codex:** designs and implements within declared lifecycle scope, creates tests, produces evidence, performs coherence review, and does not self-certify unsupported correctness.
- **Gate scripts:** make bounded deterministic checks and emit reproducible evidence.
- **Orchestrator, when later required:** enforces authorized state transitions and supervises deterministic long-running work; it does not invent scientific fixes.
- **GitHub `main`:** approved public snapshot and durable change history; it is not evidence that scientific content is correct without the applicable gate records.

## 13. Fail-closed and Occam rule

For high-consequence integrity uncertainty, stop or quarantine. Never continue on `probably fine`.

At the same time, do not construct machinery before a real stage requires it. The lifecycle is enforced now by persistent instructions, system-state identity, G00/G02 preflights, evidence, and repository checks. Component gates, schemas, registries, and automated invalidation are added incrementally when real components and dependencies make them necessary.

The governing objective is not impossible certainty. It is to make a meaningful error unlikely to survive multiple independent checks while keeping the system understandable enough to audit.

## 14. Current architectural boundary

This lifecycle approves no neural architecture, data source, dataset, training run, model, assembly, or production object.

The next permitted scientific work after this lifecycle is accepted is:

1. qualify the early Stooq historical versus Alpaca SIP live price-data constraint;
2. compare high-level architecture alternatives inside `L01` and `B01`;
3. create the Master System Architecture Specification incrementally;
4. add the smallest necessary component contracts and gates alongside accepted design decisions.

