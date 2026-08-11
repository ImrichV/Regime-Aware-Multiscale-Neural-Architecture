# TRADING NEURAL SYSTEM
# MASTER QUALITY, VERIFICATION & RESEARCH INTEGRITY PROTOCOL
### MQVRIP v0.1 — Architecture-Independent Constitution

---

## 0. PURPOSE

This protocol governs the complete lifecycle of the Trading Neural System:

**source → raw data → canonical data → model input → research dataset → training → remote compute → trained artifact → assembly → validation → production package → live data → prediction → monitoring → retraining/replacement**

Its purpose is not to make errors theoretically impossible.

Its purpose is to make it extremely difficult for a meaningful error to survive unnoticed through the complete system.

The system therefore follows **defense in depth**:

> Important claims must normally be supported by several independent forms of evidence rather than by one test, one program, one metric, or one AI-generated conclusion.

A program completing without an exception is **not evidence that the result is correct**.

---

# 1. GOVERNING PRINCIPLES

## 1.1 Evidence over assumption

Nothing important is considered correct merely because:

- the code ran;
- a file exists;
- training completed;
- a metric looks good;
- Codex says it is correct;
- one test passed;
- two files appear similar;
- documentation suggests something should work.

Important claims require saved evidence.

Examples:

**“This source is PIT-safe.”**

Requires PIT evidence.

**“This transformation is correct.”**

Requires known-answer and invariant tests.

**“There is no split leakage.”**

Requires automatic split audit.

**“The remote machine trained the intended experiment.”**

Requires bundle identity and environment evidence.

**“This model came from these exact data.”**

Requires provenance.

**“Research inference equals production inference.”**

Requires replay comparison.

---

# 2. OCCAM + SYSTEM COHERENCE RULE

Quality does **not** mean maximum complexity.

The default rule is:

> Use the simplest mechanism capable of providing the required protection.

Every additional:

- abstraction;
- service;
- model;
- database;
- transformation;
- quality check;
- provider adapter;
- dependency;
- module;
- monitoring system

must solve an identifiable problem.

Complexity without an identifiable failure mode or capability gain should be rejected.

### SYSTEM COHERENCE GATE

Whenever an existing component changes, the system must not test only that component.

The change process must determine:

1. What changed?
2. What assumptions depended on it?
3. What downstream artifacts become stale?
4. What upstream assumptions may now be invalid?
5. Which interfaces are affected?
6. Which tests must be repeated?
7. Which documentation/configuration must change?
8. Are obsolete rules still present?
9. Does the modified system still make logical sense as a whole?
10. Did the change introduce unnecessary complexity?

A locally correct modification that leaves the overall system inconsistent **fails**.

---

# 3. FAIL-CLOSED PHILOSOPHY

For critical integrity conditions:

> uncertainty means STOP, not “probably fine.”

Three severity classes are used.

### BLOCKER

Integrity may be compromised.

Examples:

- PIT status uncertain;
- checksum mismatch;
- split overlap;
- future contamination detected;
- wrong schema;
- corrupted checkpoint;
- unknown code version;
- remote input mismatch;
- unknown model provenance.

Result:

**STOP immediately.**

No downstream scientific result is accepted.

### QUARANTINE

One source/artifact/component is defective but the rest of the pipeline can remain valid.

Result:

Exclude it from active use and continue only where independence is proven.

### WARNING

Non-critical anomaly with no demonstrated effect on validity.

Result:

Continue, but permanently record the warning.

There must be **no silent fallback** for critical failures.

---

# 4. MACHINE EVIDENCE + HUMAN-READABLE EVIDENCE

Every important gate produces two outputs:

### Machine record

Structured record containing:

- PASS / FAIL;
- test version;
- timestamp;
- artifact identifiers;
- hashes;
- measured values;
- thresholds;
- failure code;
- dependencies.

### Human report

Short explanation answering:

- What was tested?
- Why does it matter?
- What was found?
- Did it pass?
- What remains uncertain?
- What happens next?

The user should never need to inspect thousands of lines of Python to know the project's integrity status.

---

# 5. UNIVERSAL ARTIFACT IDENTITY

Anything capable of changing a research conclusion receives an immutable identity.

Examples:

- raw source files;
- canonical datasets;
- schemas;
- transformations;
- split definitions;
- model-input datasets;
- code;
- configuration;
- environments;
- experiment specifications;
- checkpoints;
- models;
- evaluation outputs;
- production packages.

Identity should normally include a cryptographic content hash such as SHA-256.

The project must distinguish:

**name/version**

from

**actual content identity**.

Two things with the same filename but different hashes are different artifacts.

Two things with different filenames but identical hashes may be the same underlying content.

---

# 6. COMPLETE PROVENANCE

For every important derived artifact, the project must be able to answer:

> Exactly what produced this?

Example for a model:

**Model M**
← training run  
← architecture/configuration  
← model-input dataset  
← split manifest  
← preprocessing version  
← canonical datasets  
← raw datasets  
← source acquisitions  
← exact code  
← exact environment.

No production-eligible model may have a broken provenance chain.

The lineage must be machine-readable.

---

# 7. TIME IS FIRST-CLASS DATA

This is one of the most important rules in the entire project.

Never collapse different meanings of time into one generic `timestamp`.

Where applicable an observation must distinguish:

### event_time
When the real-world event occurred.

### source_publication_time
When the source officially published the information.

### availability_time
Earliest time at which our hypothetical trading system could legitimately have known it.

### ingestion_time
When our infrastructure actually downloaded/received it.

### revision_time
When a previously published observation was changed.

### effective_time
When the information becomes eligible for a trading decision under our operational rules.

These timestamps are **not interchangeable**.

Historical joins must normally operate using **availability/effective time**, not merely event time.

Example:

Economic activity occurred in January.

Report published March 15.

A January timestamp must never allow the January value into a February prediction.

---

# 8. HARD POINT-IN-TIME HISTORICAL INTEGRITY GATE

Every candidate information source must answer:

> Can we affirmatively establish what information would actually have been available at each historical prediction time?

“Probably.”

“Seems unlikely to be revised.”

“The website shows old dates.”

are insufficient.

## PIT eligibility requires affirmative evidence

Acceptable evidence can include, depending on the source:

- immutable event records;
- official publication archives;
- vintage databases;
- revision histories;
- historical snapshots;
- official documentation establishing immutability;
- append-only records with trustworthy publication timestamps;
- another sufficiently authoritative mechanism proving historical availability.

If older values can be silently overwritten and historical states cannot be reconstructed, the source fails.

### FAILURE RESULT

The dataset payload is removed from the active production-intended research pool.

Keep only a minimal rejection record:

- source;
- reason;
- evidence reviewed;
- date;
- decision.

This prevents accidental re-entry later.

---

# 9. HARD FUTURE LIVE-FEED ELIGIBILITY GATE

A historically interesting dataset is not automatically useful for this project.

Before data may participate in production-intended neural research, it must satisfy:

1. Historical PIT integrity proven.
2. Source identity proven.
3. Future recurring source exists.
4. Automated acquisition is technically feasible.
5. Acquisition has been demonstrated, not merely assumed.
6. Historical and future/live semantics are compatible.
7. Canonical transformation is reproducible.
8. Known-answer transformation test passes.
9. Freshness can be monitored.
10. Failure/staleness can be detected.
11. Entity/time semantics are defined.
12. Required licensing/operational usage constraints are understood.

Only then:

**LIVE-FEED ELIGIBLE**

Otherwise:

**NOT DNN ELIGIBLE FOR PRODUCTION-INTENDED RESEARCH**

Release frequency itself does not matter.

A quarterly source is acceptable if it satisfies the gate.

---

# 10. HISTORICAL ↔ LIVE SEMANTIC PARITY GATE

Historical training data and future production data must not merely have similar column names.

They must represent sufficiently equivalent phenomena.

For each modality compare, where relevant:

- definitions;
- units;
- timestamps;
- timezone;
- release delays;
- corrections;
- corporate-action treatment;
- session boundaries;
- sampling methodology;
- missing-data semantics;
- identifiers;
- coverage;
- universe;
- aggregation method;
- rounding;
- filtering;
- schema evolution.

This gate will later be explicitly applied to:

**historical price source ↔ Alpaca SIP production source**

including Stooq qualification.

No serious price-model training should occur before that study is complete.

---

# 11. UNIVERSE / SURVIVORSHIP INTEGRITY

Market data requires an additional distinction:

> Having historically correct prices for the symbols present in a database does not prove that the database represents the historical investable universe correctly.

For stock research determine:

- how symbols entered the dataset;
- whether delisted securities remain;
- whether failed companies disappeared;
- historical ticker changes;
- mergers/acquisitions;
- listing dates;
- delisting dates;
- exchange membership;
- corporate actions;
- point-in-time universe construction where needed.

If universe reconstruction is insufficient, the source may not support claims that depend upon representative cross-sectional historical opportunity sets.

This must be explicitly resolved for Stooq rather than assumed away.

---

# 12. RAW DATA LAYER

Raw acquisition is treated as evidence.

Raw source data should be preserved **unchanged** wherever technically practical.

No manual cleanup inside raw files.

Each acquisition receives:

- source ID;
- retrieval time;
- retrieval mechanism;
- original path/URL/API endpoint identifier where appropriate;
- source parameters;
- file size;
- cryptographic hash;
- acquisition software version;
- success/failure status.

Raw data must be immutable after acceptance.

If corrected data are downloaded later, they become another acquisition—not a silent replacement.

---

# 13. ACQUISITION VALIDATION

Before raw data are accepted:

### Structural checks

- archive opens;
- expected files exist;
- files are readable;
- row/record counts plausible;
- expected fields exist;
- encoding valid;
- no accidental HTML/error page masquerading as data;
- no truncation;
- checksums valid when source provides them.

### Semantic checks

Examples:

- dates within plausible range;
- impossible values detected;
- duplicate identities detected;
- invalid identifiers;
- impossible OHLC relationships where appropriate;
- unknown units;
- unexpected schema versions;
- discontinuous history;
- bizarre missingness.

### Continuity checks

For recurring feeds:

- overlap with previous acquisition;
- gaps;
- duplicates;
- unexpected backfills;
- revisions;
- schema drift;
- volume anomalies.

---

# 14. CANONICAL DATA CONTRACT

Canonical data are the project's stable internal representation.

Every canonical dataset requires an explicit contract defining:

- field name;
- type;
- unit;
- meaning;
- timezone;
- entity identifier;
- timestamp semantics;
- missing-value semantics;
- valid range where meaningful;
- source lineage;
- transformation version;
- revision handling;
- sort/index expectations;
- uniqueness constraints.

No downstream model should need to guess what a field means.

---

# 15. RAW → CANONICAL TRANSFORMATION RULE

Transformations must be:

### Deterministic where possible
Same valid raw input + same transformation version → same canonical result.

### Versioned
Changing transformation logic creates a new version.

### Auditable
Every output can trace back to its raw origin.

### Non-destructive
Raw source remains available.

### Explicit
No undocumented cleaning.

### Testable
Known-answer fixtures must exist.

---

# 16. GOLDEN DATA FIXTURES

For every important transformation chain create very small datasets whose correct answer is understood exactly.

Example:

**raw records**
→ expected canonical records  
→ expected model-input values/tensors.

Include difficult cases:

- missing data;
- duplicates;
- timezone boundary;
- publication delay;
- corporate action;
- market holiday;
- source revision;
- identifier change;
- out-of-order arrival;
- late record.

Expected output should preferably be manually reasoned through once and then frozen.

The golden fixture becomes a permanent regression test.

If later code changes and the output changes unexpectedly:

**STOP.**

---

# 17. PROPERTY / INVARIANT TESTING

Golden examples test known cases.

Properties test classes of cases.

Examples:

- high ≥ low;
- no impossible dates;
- availability_time ≥ publication_time where defined;
- canonical uniqueness constraints;
- monotonic sequence ordering;
- no observation appears before its availability time;
- normalization parameters never use validation/test observations;
- split identities remain unique.

Where reasonable, automatically generate many strange inputs to attack these invariants.

---

# 18. DIFFERENTIAL VERIFICATION

Critical calculations should occasionally be implemented or checked independently.

Examples:

- split-overlap audit;
- timestamp availability check;
- P&L calculation;
- tensor generation;
- return calculation;
- corporate-action adjustment;
- important aggregate statistic.

The independent checker must not simply call the same underlying function being tested.

Otherwise the same bug can produce the same wrong answer twice.

Do this selectively for **high-consequence calculations**, not everything.

Occam still applies.

---

# 19. MODEL-INPUT TRANSFORMATION GATE

Canonical data are not automatically valid neural inputs.

Any transformation between canonical data and model input must have:

- version;
- configuration;
- fitting scope;
- learned statistics;
- input schema;
- output schema;
- shape expectations;
- dtype;
- missingness handling;
- sequence ordering;
- masking rules;
- timestamp rules;
- golden output.

If normalization/scaling learns statistics from data, those statistics must be fitted only using the permitted training partition and then frozen.

Validation, test, lockbox and live data may be transformed by those frozen statistics but must not influence their estimation.

---

# 20. OBSERVATION IDENTITY

Every model observation should have a stable identity sufficient to reconstruct it.

Conceptually:

**entity + decision timestamp + modality context + dataset/split version**

The exact format will be designed later.

This identity is used to prove:

- which examples trained the model;
- which examples validated it;
- which examples were untouched;
- no accidental overlap occurred;
- results can be reconstructed.

---

# 21. SPLIT GOVERNANCE

The project will not have simply:

**train / test**

It requires distinct roles.

Exact percentages and dates will be chosen only after the final data structure is understood.

The conceptual roles are:

### Engineering fixture data
Tiny examples freely inspected during software development.

### Development/training data
Used to learn parameters.

### Model-selection validation
Used for architecture/objective/hyperparameter decisions.

### Integration validation
Used after modules are combined.

### Final lockbox
Untouched by development decisions.

Possibly also:

### entity/ticker holdout

and/or additional temporal robustness partitions where justified.

---

# 22. IMMUTABLE SPLIT MANIFEST

Before training begins, save the exact identity of every observation in every partition.

The system automatically proves:

- no forbidden identity overlap;
- no temporal leakage;
- no illegal entity overlap where required;
- no source-level duplicates leaking across splits;
- no preprocessing fitted using forbidden partitions.

The manifest itself is hashed and becomes part of the experiment identity.

---

# 23. LOCKBOX GOVERNANCE

The final lockbox is treated as consumable scientific capital.

It is not:

- checked during debugging;
- repeatedly inspected;
- used to decide hyperparameters;
- used to decide which architecture looks nicest;
- used to decide which failed experiments to revive.

If information from the lockbox materially influences development, the lockbox is considered **burned**.

It must then either:

- become part of development history and be replaced by a genuinely untouched reserve; or
- be explicitly declared as no longer independent.

No pretending otherwise.

---

# 24. LEAKAGE THREAT MODEL

Leakage testing must explicitly cover several independent mechanisms.

### Temporal leakage

Future information entering earlier predictions.

### Preprocessing leakage

Normalization/statistics learned using forbidden observations.

### Label leakage

Outcome-derived information accidentally entering inputs.

### Cross-sectional leakage

Information about contemporaneous/future constituents improperly leaking between securities.

### Duplicate leakage

Same or near-identical records appearing across partitions.

### Entity leakage

When entity independence is part of the claim.

### Revision leakage

Using values revised after the historical decision time.

### Join leakage

Joining on event date instead of availability date.

### Research leakage

Repeatedly consulting supposedly untouched validation data.

### Production leakage

Live pipeline having access to information unavailable in historical replay.

Zero detected leakage is a **hard gate**.

---

# 25. AUTOMATED LEAKAGE ATTACKS

Do not merely check the intended pipeline.

Actively attempt to break it.

Examples:

- deliberately inject future timestamps;
- intentionally duplicate observations across partitions;
- shift publication dates;
- inject revised data;
- shuffle ordering;
- corrupt a split manifest;
- provide data unavailable at decision time.

The safety system should detect the violation.

This tests the guard itself.

---

# 26. SYNTHETIC KNOWN-SIGNAL TEST

Before trusting complicated training:

Construct artificial data containing a deliberately known predictive relationship.

Run it through the **complete pipeline**.

The system should recover the signal.

Purpose:

Test whether information can actually travel:

**source-like data → canonicalization → model input → architecture → objective → gradients → prediction**

If the model cannot learn a deliberately learnable signal, expensive real-data training is prohibited.

---

# 27. NEGATIVE-CONTROL TESTS

We must also test the opposite direction.

Examples:

### Shuffled outcomes
Real predictive relation intentionally destroyed.

### Random/no-signal data
System should not repeatedly manufacture strong persistent predictive performance.

### Broken causal timing
Future information should trigger leakage guards rather than improve results unnoticed.

### Irrelevant synthetic modality
Adding deliberate noise should not appear reliably useful.

These tests help detect systems capable of producing impressive-looking nonsense.

---

# 28. TINY OVERFIT TEST

Before expensive training:

Train …1356 tokens truncated…e applicable capture:

- model state;
- optimizer state;
- scheduler state;
- mixed-precision scaler;
- training step/epoch;
- random-number-generator states;
- sampler/dataloader state where required;
- configuration identity;
- dataset/split identity;
- code/environment identity;
- training metrics state.

Checkpoint files are hashed.

---

# 39. CHECKPOINT QUALIFICATION

A checkpoint is not trusted merely because it was written.

Periodically test:

**save → terminate → reload → continue**

and verify continuation works.

Use atomic writing where practical:

write temporary artifact → verify → promote/rename.

Never overwrite the only known-good checkpoint with an unverified one.

---

# 40. PROVIDER SWAPPING

Changing provider during training is allowed only if the experiment supports safe migration.

Before migration:

1. Save verified checkpoint.
2. Save current run state.
3. Hash artifacts.
4. Retrieve locally or to trusted storage.
5. Verify retrieval.
6. Transfer to new provider.
7. Verify hashes again.
8. Verify environment compatibility.
9. Load checkpoint.
10. Run continuation sanity test.
11. Resume.

A provider change is permanently recorded in provenance.

Exact numerical trajectory after migration is **not assumed** to be identical across hardware.

---

# 41. TRANSFER INTEGRITY

Every critical transfer follows:

**source hash → transfer → destination hash → equality**

This applies to:

- datasets;
- sealed bundles;
- checkpoints;
- final models;
- evaluation outputs;
- production packages.

Transfer success messages alone are insufficient.

---

# 42. TRAINING SUPERVISION

Training should emit machine-readable state such as:

- current step/epoch;
- loss;
- relevant validation metrics;
- learning rate;
- GPU utilization;
- memory;
- checkpoint age;
- last heartbeat;
- elapsed progress;
- NaN/Inf detection;
- failure state.

The orchestrator observes this without needing Codex continuously.

---

# 43. ORCHESTRATOR RESPONSIBILITY

The orchestrator should perform deterministic supervision.

Examples:

- launch;
- heartbeat checking;
- safe retry;
- checkpoint verification;
- provider status;
- transfer verification;
- resumable workflow state;
- timeout/stall detection;
- logging;
- cleanup;
- Codex escalation.

The orchestrator should not invent scientific fixes.

---

# 44. CODEX RESPONSIBILITY

Codex is an implementer/debugger, not the final authority on correctness.

Codex may:

- write code;
- inspect logs;
- repair implementation;
- create tests;
- investigate failures;
- modify infrastructure.

But a Codex-generated fix is accepted only after the relevant automated gates pass.

The AI saying:

**“fixed”**

does not mean fixed.

Tests and evidence decide.

---

# 45. ESCALATION MODEL

### Orchestrator handles

Known deterministic conditions.

### Codex handles

Unexpected technical failures requiring reasoning/code changes.

### Human handles

Questions involving:

- ambiguous data semantics;
- architectural/scientific tradeoffs;
- unknown PIT status;
- unacceptable integrity uncertainty;
- material strategy changes;
- expensive/destructive decisions.

---

# 46. NO SILENT AUTO-REPAIR OF SEMANTICS

Automation may safely repair known operational issues such as:

- reconnect;
- resume download;
- restart process;
- retry transfer.

It may not silently decide:

- what a strange field means;
- how to repair suspicious financial values;
- how to reinterpret timestamps;
- whether revised data are acceptable;
- whether missing observations should be imputed;
- whether a changed API has equivalent semantics.

Unknown semantics require quarantine/escalation.

---

# 47. TRAINING RUN ARTIFACT

Every completed training run produces a self-contained provenance record.

At minimum:

- run identity;
- sealed bundle identity;
- provider(s);
- hardware;
- environment;
- start/end;
- checkpoint history;
- random seeds;
- training logs;
- metrics;
- final artifact hash;
- anomaly record;
- status.

A neural weight file with no such history is **research debris**, not an eligible model.

---

# 48. MODEL ELIGIBILITY STATES

Models move through explicit states.

Example:

**EXPERIMENTAL**

↓

**TRAINING_COMPLETE**

↓

**REPRODUCIBLE**

↓

**VALIDATED**

↓

**INTEGRATION_VALIDATED**

↓

**LOCKBOX_EVALUATED**

↓

**PRODUCTION_CANDIDATE**

↓

**PRODUCTION_QUALIFIED**

↓

**PRODUCTION**

↓

**RETIRED**

Promotion requires evidence.

Copying a model into another folder does not promote it.

---

# 49. INDEPENDENT EVALUATION

Critical final evaluation should run through an evaluator that was not controlled by the training loop.

It should read frozen:

- model;
- dataset;
- split;
- evaluation specification

and independently calculate results.

Where practical, critical statistics are independently cross-checked.

---

# 50. RESEARCH ↔ PRODUCTION INFERENCE PARITY

Before live use:

Freeze the candidate.

Take historical samples.

Run them through:

### research inference implementation

and

### exact production inference implementation.

Compare:

- canonical values;
- model inputs;
- masks;
- tensor values;
- predictions;
- postprocessing;
- timestamps.

Differences require explanation.

Unexplained differences:

**BLOCK PRODUCTION.**

---

# 51. SINGLE SOURCE OF SEMANTIC TRUTH

Whenever possible, research and production should reuse the same tested transformation libraries rather than maintaining two independently drifting implementations.

Independent verification still exists.

But duplicated business logic should not be created merely for the sake of duplication.

This reduces unnecessary mismatch risk.

---

# 52. PRODUCTION REPLAY

Before deployment, replay historical periods through the actual production-like pipeline as though time were advancing normally.

At each simulated moment:

only information available at that moment may enter.

This tests:

- scheduling;
- source availability;
- joins;
- transformations;
- state handling;
- model invocation;
- delayed releases;
- missing feeds;
- final prediction generation.

---

# 53. LIVE FAILURE TESTING

Before deployment deliberately simulate:

- missing source;
- delayed source;
- corrupt file;
- wrong schema;
- duplicate delivery;
- stale data;
- API failure;
- partial download;
- unexpected source revision;
- clock/timezone error;
- unavailable GPU/CPU service;
- model-load failure.

The system should fail in the intended way.

Not improvise.

---

# 54. LIVE DATA HEALTH

Each live modality receives monitoring appropriate to its release frequency.

Monitor where meaningful:

- latest availability time;
- expected next release;
- missing updates;
- unexpected extra releases;
- schema drift;
- missingness;
- row counts;
- distribution changes;
- source errors;
- revision behavior;
- ingestion delay.

“Process is running” is not equivalent to “feed is healthy.”

---

# 55. MODEL MONITORING

Production monitoring later includes appropriate measures for:

- inference failures;
- input drift;
- representation/output drift;
- calibration where applicable;
- prediction distribution;
- realized performance;
- model degradation;
- missing modality frequency;
- latency;
- unusual confidence behavior.

Thresholds will be architecture/objective specific and are therefore **not defined yet**.

---

# 56. NO AD-HOC LIVE FALLBACK

If a production modality disappears, the system may only:

- use a missing-modality behavior specifically trained and validated in advance;
- use another formally qualified fallback;
- abstain/disable affected prediction.

It may not suddenly invent a new imputation or substitute source during live operation.

---

# 57. RETRAINING / CHALLENGER POLICY

New data do not automatically modify the live brain.

Retraining creates a **challenger**.

The challenger goes through qualification.

Only after it demonstrably satisfies promotion rules can it replace the incumbent.

Possible cadence categories:

### Routine data refresh / retraining
Most frequent.

### Challenger comparison
Periodic.

### Architecture reconsideration
Less frequent.

No arbitrary retraining schedule should be hard-coded before empirical need is understood.

---

# 58. DATA / MODEL DEGRADATION GUARDS

The project should later establish thresholds for:

- feed degradation;
- distribution changes;
- predictive degradation;
- calibration degradation;
- model staleness.

Triggering a guard starts investigation/challenger evaluation.

It does not automatically retrain and deploy a replacement.

---

# 59. CHANGE CONTROL

Every material change receives:

- change ID;
- reason;
- affected components;
- dependency impact;
- tests required;
- artifacts invalidated;
- results;
- reviewer/decision;
- final status.

Examples:

- source API changes;
- canonical schema change;
- bug fix;
- preprocessing change;
- architecture change;
- new provider;
- library update;
- new normalization;
- timestamp correction.

---

# 60. AUTOMATIC ARTIFACT INVALIDATION

If dependency A changes, downstream artifacts derived from A should become:

**STALE / REQUIRES REVALIDATION**

rather than silently remaining “valid.”

Example:

canonicalization bug fixed

→ canonical dataset stale  
→ model-input datasets stale  
→ training bundles stale  
→ models trained on them stale  
→ evaluations stale.

This is critical.

A local fix must propagate logically through the dependency graph.

---

# 61. SOFTWARE ENVIRONMENT CONTROL

Important environments must be reproducible enough to reconstruct the run.

Pin where relevant:

- Python version;
- neural framework;
- CUDA/runtime;
- libraries;
- system packages;
- container/image identity if used.

Avoid unpinned instructions such as:

**install latest**

for reproducible experiments.

---

# 62. SECRET HANDLING

API keys, passwords and provider credentials must not be:

- committed to repository;
- embedded in datasets;
- bundled into model artifacts;
- printed in logs;
- included in reports.

Secrets are configuration external to scientific artifacts.

---

# 63. REPOSITORY REQUIREMENTS

The repository is the authoritative source for:

- code;
- specifications;
- schemas;
- tests;
- configurations;
- architecture documents;
- protocol documents;
- provider adapters;
- orchestration logic.

Large datasets/models may live elsewhere but their manifests/identities remain referenced by repository-controlled records.

Important runs should originate from known commits rather than unidentified working-directory states.

---

# 64. TEST HIERARCHY

Use the cheapest test capable of detecting a failure first.

Suggested order:

1. Static/schema validation
2. Unit tests
3. Golden known-answer tests
4. Property/invariant tests
5. Contract/interface tests
6. Leakage tests
7. Differential tests
8. Synthetic signal tests
9. Tiny overfit
10. Smoke training
11. Integration tests
12. Statistical robustness
13. Remote-provider qualification
14. End-to-end replay
15. Production parity
16. Live monitoring

Do not launch expensive GPU training to discover an error a 0.2-second unit test could have detected.

---

# 65. RISK-BASED TEST DENSITY

Not every line of code deserves nuclear-level verification.

Testing intensity depends on consequence.

### Highest intensity

- PIT logic;
- timestamps;
- joins;
- splits;
- normalization;
- outcome construction;
- model input;
- financial calculations;
- provenance;
- remote transfers;
- model promotion;
- production parity.

### Normal intensity

Utility code with low ability to corrupt scientific conclusions.

This keeps the protocol strong without scope explosion.

---

# 66. QUALITY CONTROLS MUST THEMSELVES BE TESTED

A guard that has never been observed catching a failure may itself be broken.

For important guards periodically inject controlled violations.

Example:

split checker

→ intentionally create one overlap

→ verify checker fails.

PIT checker

→ inject future record

→ verify checker fails.

Hash checker

→ modify one byte

→ verify mismatch.

This is **testing the tests**.

---

# 67. NO FAKE AGGREGATE QUALITY SCORE

Do not hide integrity behind:

**Quality = 97/100**

A single catastrophic leakage failure cannot be compensated for by 99 successful minor tests.

Use gate status.

Example:

**PIT: PASS**  
**Split integrity: FAIL**  
**Remote bundle identity: PASS**

Overall status:

**BLOCKED**

---

# 68. INCIDENT RECORD

Any meaningful integrity failure creates an incident containing:

- what happened;
- when;
- affected artifacts;
- root cause;
- detection mechanism;
- why earlier guards did/did not catch it;
- repair;
- tests added;
- downstream artifacts invalidated.

The objective is not blame.

The objective is preventing recurrence.

---

# 69. FINAL AUDIT

At important milestones perform an independent final audit.

The audit checks:

### Data
All expected data have known status.

### Rejections
Rejected sources cannot accidentally remain active.

### PIT
All active production-intended sources remain PIT-qualified.

### Manifests
Hashes and inventories complete.

### Splits
No unresolved contamination.

### Experiments
All material attempts recorded.

### Models
Provenance chains complete.

### Compute
No unidentified remote outputs.

### Checkpoints
Required checkpoints verified.

### Repository
Known clean state.

### Temporary artifacts
No ambiguous `.part`, temporary, orphaned or stale artifact being mistaken for canonical output.

### Processes
No unintended background acquisition/training process remains active.

### Production eligibility
Only explicitly qualified artifacts are marked eligible.

Audit ends with:

**PASS**

or

**FAIL + exact blockers**

Never “probably okay.”

---

# 70. MASTER EVIDENCE LEDGER

Maintain one high-level ledger summarizing system status.

Conceptually:

| Object | Version | Status | Evidence | Dependencies | Last verified |
|---|---|---|---|---|---|
| Source A | ... | PIT PASS | ... | ... | ... |
| Canonical A | ... | PASS | ... | Source A | ... |
| Split S1 | ... | PASS | ... | Dataset ... | ... |
| Training bundle | ... | PASS | ... | ... | ... |
| Model M | ... | VALIDATED | ... | ... | ... |

This becomes the central map of what is currently trustworthy.

---

# 71. CLAIM TYPES AND APPROPRIATE EVIDENCE

Not every statement can be proven in the same way.

### Identity claims
“This file is exactly the file we sent.”

Can be strongly proven with cryptographic hashes.

### Deterministic correctness claims
“This input produces this output.”

Can be tested exactly with golden fixtures.

### Invariant claims
“No test observation is earlier than its permitted availability.”

Can be exhaustively checked over a finite dataset.

### Statistical claims
“This information improves future prediction.”

Cannot be absolutely proven.

Requires controlled statistical evidence.

### Future operational claims
“This feed will remain healthy forever.”

Cannot be proven.

Requires monitoring and failure handling.

The protocol must never pretend statistical uncertainty can be eliminated by software testing.

---

# 72. DEFINITION OF “PROVEN ENOUGH”

An object is accepted when:

1. Relevant known failure modes have been identified.
2. Appropriate tests exist.
3. Mandatory tests pass.
4. Required evidence is stored.
5. Residual uncertainty is understood.
6. No unresolved blocker exists.
7. Complexity is justified.
8. Dependencies are valid.
9. Human-readable report agrees with machine status.
10. The object can be reconstructed or its origin demonstrated.

---

# 73. ARCHITECTURE ENTRY GATE

Only after this protocol is operationally specified may a neural architecture component enter serious development.

Every proposed component must later answer:

### Input
What exactly does it consume?

### Timing
What information is legally available?

### Output
What exactly does it produce?

### Contract
What shape/semantics are guaranteed?

### Training
How is it learned?

### Evidence
How do we know it functions?

### Value
How do we know it helps?

### Failure
What happens when its input is absent/broken?

### Reproduction
Can it be reconstructed?

### Production
Can the exact behavior be reproduced live?

Architecture must conform to the quality system.

The quality system is not rewritten merely because a complicated architecture would otherwise be inconvenient.

---

# 74. MINIMUM EVIDENCE CHAIN FOR A PRODUCTION PREDICTION

Ultimately every live prediction should conceptually be traceable backward:

**Prediction**

← production model artifact  
← validated model  
← training run  
← sealed experiment  
← model-input transformation  
← canonical data  
← PIT-qualified sources  
← raw acquisition evidence.

And forward:

**Prediction**

→ decision/output log  
→ realized outcome  
→ monitoring  
→ model health evaluation  
→ future challenger/retraining evidence.

This creates a closed research-to-production lifecycle.

---

# 75. THE MOST IMPORTANT HARD GATES

If the rest of this document becomes enormous, these rules must never get lost:

### GATE 1 — PIT
No affirmative historical PIT proof → reject.

### GATE 2 — LIVE CONTINUITY
No credible recurring future source → reject from production-intended DNN research.

### GATE 3 — RAW INTEGRITY
Unknown/corrupt acquisition → reject/quarantine.

### GATE 4 — CANONICAL CORRECTNESS
Contract/golden tests fail → stop.

### GATE 5 — HISTORICAL/LIVE PARITY
Historical and future source semantics cannot be reconciled → stop/rethink source.

### GATE 6 — SPLIT INTEGRITY
Any forbidden leakage/overlap → stop.

### GATE 7 — MODEL-INPUT CORRECTNESS
Known-answer tensor/transformation tests fail → stop.

### GATE 8 — SYNTHETIC LEARNABILITY
Pipeline cannot learn deliberately recoverable signal → no expensive training.

### GATE 9 — TINY OVERFIT
Expected overfit capability fails → investigate before full training.

### GATE 10 — SEALED COMPUTE IDENTITY
Remote machine does not have exact intended experiment artifacts → no training.

### GATE 11 — TRAINING PROVENANCE
Run cannot be reconstructed/explained → model ineligible.

### GATE 12 — VALUE
Complexity/data/module does not demonstrate sufficient benefit → do not promote.

### GATE 13 — INDEPENDENT VALIDATION
Candidate does not survive valid untouched evaluation → reject.

### GATE 14 — RESEARCH/LIVE PARITY
Production inference differs unexpectedly from research → no deployment.

### GATE 15 — LIVE HEALTH
Required live information is stale/corrupt/incompatible → fail according to qualified failure policy.

### GATE 16 — SYSTEM COHERENCE
A local change leaves downstream/upstream inconsistencies → change rejected until resolved.

---

# 76. WHAT THIS PROTOCOL DELIBERATELY DOES NOT DECIDE YET

To prevent premature complexity, v0.1 does **not** yet decide:

- transformer vs TCN vs SSM vs RNN;
- number of encoders;
- one encoder per data source vs shared encoders;
- fusion architecture;
- latent dimensions;
- specialists;
- gating;
- attention;
- prediction heads;
- exact self-supervised objectives;
- exact future-return objectives;
- exact sequence lengths;
- exact train/validation dates;
- exact retraining cadence;
- exact drift thresholds.

Those are architectural/research decisions.

They will be designed **inside this framework**.

---

# 77. MASTER RULE

The project operates according to one final rule:

> **Nothing important earns trust merely because it exists or appears plausible. It earns trust by surviving the appropriate independent checks and leaving reproducible evidence behind.**

And simultaneously:

> **Do not construct unnecessary machinery simply to feel safer. Every piece of complexity must defend against a real failure mode, enable a required capability, or demonstrate empirical value.**

That combination—

**extreme integrity + Occam + system-wide logical coherence**

—is the governing philosophy of the Trading Neural System.