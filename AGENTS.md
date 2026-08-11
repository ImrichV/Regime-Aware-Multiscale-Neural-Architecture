# Trading Neural System - Mandatory Project Instructions

These instructions govern the entire project tree. They exist so project integrity does not depend on chat memory, agent memory, or an agent merely remembering to be careful.

## Governing sources

1. `MASTER_QUALITY_PROTOCOL.md` is the authoritative quality, verification, and research-integrity constitution.
2. `SYSTEM_STATE.md` is the authoritative record of current project reality, blockers, validated objects, stale objects, and the next permitted work.
3. Machine-produced evidence and passing tests override an agent's unsupported claim that something is correct.

If these sources conflict, stop. Do not silently choose an interpretation. Resolve the conflict explicitly and update all affected sources coherently.

## Mandatory start-of-work procedure

Before modifying data, code, architecture, models, training, infrastructure, evaluation, orchestration, or production behavior:

1. Read `SYSTEM_STATE.md`.
2. Read the MQVRIP sections applicable to the task. Do not reread unrelated sections merely for ceremony.
3. Run `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\quality\gates\G00_governance_preflight.ps1` before substantive project changes.
4. State the intended change, affected components, relevant failure modes, applicable hard gates, and evidence required for acceptance.
5. Check whether an active blocker, rejected dependency, stale artifact, or unresolved semantic question prohibits the work.

If a required gate does not yet exist, build the smallest reliable gate when the corresponding component is introduced. Do not perform the dangerous downstream action first and promise to add protection later.

## Non-negotiable operating rules

- Use the simplest mechanism that provides the required protection. Complexity must defend against a concrete failure mode, enable a required capability, or demonstrate empirical value.
- Never accept "the code ran," "training completed," or an agent's assurance as proof of correctness.
- Never bypass, weaken, relabel, or silently ignore a failed hard gate.
- Critical uncertainty is a blocker. Unknown semantics, PIT status, time meaning, source compatibility, provenance, or artifact identity require stop, quarantine, or human escalation.
- Do not silently repair or reinterpret suspicious data, timestamps, schemas, missingness, revisions, or source semantics.
- Preserve raw evidence and provenance. Never silently replace an accepted raw artifact.
- Treat time as first-class data. Do not collapse event, publication, availability, ingestion, revision, and effective times into an ambiguous timestamp.
- Protect secrets. Never place credentials in code, data, logs, reports, bundles, or model artifacts.
- Apply the highest verification intensity to PIT logic, timestamps, joins, splits, normalization, outcomes, model inputs, financial calculations, provenance, remote transfers, model promotion, and research/production parity.
- Record negative and failed research attempts when they can affect later interpretation. Do not report only winners.
- Prefer one tested semantic implementation shared by research and production; add independent verification without duplicating drifting business logic.

## Mandatory change-impact and System Coherence Gate

After every material change, do not test only the edited component. Determine and record:

1. What changed and why?
2. Which upstream assumptions may now be invalid?
3. Which downstream artifacts depend on the changed object?
4. Which interfaces, schemas, configurations, tests, reports, and documentation are affected?
5. Which derived artifacts must become `STALE`, `INVALID`, or `REVALIDATION REQUIRED`?
6. Which tests and gates must be repeated?
7. Are obsolete rules, files, fallbacks, or assumptions still present?
8. Does the whole affected system remain logically coherent?
9. Did the change add unnecessary complexity?

A locally correct change that leaves the wider system inconsistent fails the System Coherence Gate.

## Evidence and completion requirements

Work is not complete until all of the following that apply are true:

- Required tests and gates passed.
- Important guards were tested with a known failure or injected violation where practical.
- Evidence was saved in the location defined by the applicable protocol or component contract.
- Residual uncertainty and limitations were stated honestly.
- Affected downstream artifacts were invalidated or revalidated.
- `SYSTEM_STATE.md` was updated when project truth changed.
- The governance preflight still passes.
- The human-readable report agrees with the machine evidence.

Every completion report must distinguish:

- what was changed;
- what was actually verified;
- evidence produced;
- what remains unverified or blocked;
- what was invalidated;
- the next permitted action.

## Public GitHub synchronization

The connected public repository is `ImrichV/Regime-Aware-Multiscale-Neural-Architecture`.

Because every branch in a public repository is public, no file may be uploaded before local publication checks pass.

At the end of every completed logical task that changes project truth, after a critical fix, and before expensive training or remote compute:

1. Decide whether the current work forms a coherent public checkpoint.
2. Update `SYSTEM_STATE.md` if project truth changed.
3. Run G00 governance preflight.
4. Run `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\quality\gates\G01_publication_preflight.ps1`.
5. Publish only paths in `quality/publication/approved_paths.txt` plus `PUBLICATION_MANIFEST.json`.
6. Use a GitHub branch and pull request; do not treat a branch as private.
7. Verify every remote Git blob identity against the generated publication manifest before accepting synchronization.
8. Merge into `main` only after required gates pass and remote identity is proven.
9. Save a local synchronization receipt. Report `CURRENT`, `PENDING`, or `FAILED`; never imply synchronization without evidence.

Never upload credentials, `.env` files, private or licensed data, sensitive logs, model weights, checkpoints, large training outputs, caches, temporary files, proprietary execution details, or exploitable production trading information.

Do not require publication for every keystroke or unfinished experiment. Publish after coherent tasks and stable milestones so GitHub `main` remains the latest approved public snapshot rather than a stream of partial work.

## Protocol change control

`MASTER_QUALITY_PROTOCOL.md` must not be edited merely to make a proposed implementation easier.

A material protocol change requires:

1. explicit rationale;
2. impact analysis;
3. a new protocol version;
4. updated approved SHA-256 in `SYSTEM_STATE.md`;
5. updated affected instructions, contracts, tests, and state;
6. successful governance preflight;
7. explicit human approval for weakened or removed protection.

No important protection may disappear through an unrelated local edit.

## Current phase boundary

The governance foundation does not make any data source, dataset, model, architecture, training run, or production component valid. Eligibility must be earned later through the applicable MQVRIP gates and saved evidence.
