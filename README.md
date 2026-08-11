# Regime-Aware Multiscale Neural Architecture

This public repository records the controlled, reproducible development of a modular neural trading research system.

## Current status

The project is currently establishing its quality, verification, and research-integrity foundation. The detailed neural architecture has **not** been selected or approved.

Ideas such as multitimeframe representation, price-path learning, cross-sectional context, market-regime representation, historical-analogue retrieval, multimodal learning, specialist routing, uncertainty estimation, and self-supervised objectives are candidate research directions. They must be compared and qualified inside the project's quality protocol before entering an approved architecture.

## Governing principle

The project is governed by the Master Quality, Verification & Research Integrity Protocol (MQVRIP):

> Nothing important earns trust merely because it exists, appears plausible, or ran without an error. It earns trust through appropriate independent checks and reproducible evidence.

The project simultaneously follows Occam's razor: complexity must protect against a concrete failure mode, enable a required capability, or demonstrate empirical value.

## Public project truth

- `MASTER_QUALITY_PROTOCOL.md` contains the governing constitution.
- `AGENTS.md` contains mandatory working rules for Codex.
- `SYSTEM_STATE.md` records the current phase, blockers, eligibility states, and permitted next work.
- `architecture/CANONICAL_SYSTEM_LIFECYCLE.md` maps every material task and artifact to mandatory stages, boundaries, evidence, and invalidation rules.
- `PUBLIC_REPOSITORY_POLICY.md` defines what may and may not be published here.
- `quality/gates/` contains executable safety gates as they become necessary.

Every material architecture, data, code, interface, training, evaluation, compute, and production task must identify its lifecycle stages and boundaries. G02 rejects silent lifecycle drift, and the repository quality workflow runs the foundation gates automatically on pull requests and changes to `main`.

GitHub `main` is intended to represent the latest approved public snapshot. Work in progress is published only through a controlled branch after the public-publication gate passes.

## Public scope

This repository may contain specifications, source code, schemas, small tests and fixtures, safe configuration templates, manifests, and public reports.

It must not contain credentials, `.env` files, private or licensed datasets, raw research data, sensitive logs, trained model weights, checkpoints, large training outputs, proprietary execution details, or exploitable production trading information.
