# Quality Evidence

This directory contains machine-readable evidence produced by MQVRIP gates.

`governance_preflight.latest.json` is generated atomically by G00 and records whether the persistent governance foundation is internally consistent at the time of the check.

`governance_preflight.protocol_tamper_test.json` records a controlled fault injection in an isolated temporary copy. Its expected `FAIL` proves that G00 rejects an altered protocol whose hash no longer matches the approved identity.

`governance_preflight.agents_tamper_test.json` records a separate controlled fault injection. Its expected `FAIL` proves that G00 rejects altered mandatory project instructions whose hash no longer matches the approved identity.

Evidence files demonstrate only the claims made by their specific gate. A passing governance preflight does not validate data, architecture, training, models, or production behavior.

`publication_preflight.latest.json` is local-only evidence from G01. It may contain local paths and must not be uploaded to the public repository.

`publication_preflight.secret_test.json` records a controlled fake-credential injection in an isolated temporary copy. Its expected `FAIL` proves that G01 rejects credential-like content before publication. It is local-only and must not be uploaded.

`github_sync.latest.json` is the local-only receipt produced after remote Git blob identities are compared with `PUBLICATION_MANIFEST.json`. It must not be uploaded to the public repository.
