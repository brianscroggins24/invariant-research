---
page_id: SOURCE-SUMMARY-0043
title: Get API Keys
page_type: source-summary
status: reviewed
created_at: 2026-09-02
updated_at: 2026-09-02
source_id: SRC-0044
sources:
  - SRC-0044
related_pages:
  - PLATFORM-0002
tags:
  - kalshi
  - official-documentation
  - api-keys
  - authentication
  - scopes
---

# Source Summary

## Citation

Kalshi documentation. "Get API Keys." Source ID: `SRC-0044`. Canonical URL: `https://docs.kalshi.com/api-reference/api-keys/get-api-keys`. Captured 2026-09-02. Capture metadata records canonical-HTML JSON-LD `dateModified` as `2026-09-02T22:09:39.980Z`; that timestamp is absent from the raw Markdown. No publication date is provided.

## Source Type and Playbook

Official documentation / primary platform, analyzed under the `official-documentation` playbook. It is authority only for the documented Kalshi-local response schema at capture time. Scope labels, server URLs, authentication, and restrictions are mutable.

## Direct Findings

- `GET /api_keys` is described as retrieving API keys associated with the authenticated user (`SRC-0044`, lines 5-7 and 63-69).
- A successful response requires an `api_keys` array; each returned item requires `api_key_id`, `name`, and `scopes` (`SRC-0044`, lines 97-132).
- The required `scopes` array therefore exposes the documented scope labels granted to each returned key (`SRC-0044`, lines 115-132).
- The response schema defines seven parent-and-child scope values and their descriptions (`SRC-0044`, lines 151-175).

## Verification and Security Boundary

The static schema supports verification that Kalshi documents response-side scope visibility. It does not prove the actual scopes or effective permissions of a live key. No authenticated request was made and no credential was inspected. Key IDs, names, scopes, bindings, signatures, and other account metadata must remain outside research artifacts, fixtures, stable identities, logs, exceptions, and reports.

## Important Claims

- [CLM-0197] Each returned key requires a scopes array.

## Limitations

The page does not establish live response contents, runtime enforcement, account eligibility, pagination, ordering, freshness, unknown-scope behavior, key status, expiration, rotation, revocation, or stable error and retry behavior. Endpoint documentation does not authorize credential enumeration or use.

## Review Notes

The complete canonical artifact was read. Direct findings, runtime-verification limits, and security boundaries remain separated. No secret or credential-derived value was accessed.
