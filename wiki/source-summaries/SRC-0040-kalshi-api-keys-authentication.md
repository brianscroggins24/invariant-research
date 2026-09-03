---
page_id: SOURCE-SUMMARY-0039
title: API Keys
page_type: source-summary
status: reviewed
created_at: 2026-08-31
updated_at: 2026-08-31
source_id: SRC-0040
sources:
  - SRC-0040
related_pages:
  - PLATFORM-0002
tags:
  - kalshi
  - official-documentation
  - authentication
  - api-keys
  - read-only
---

# Source Summary

## Citation

Kalshi documentation. "API Keys." Source ID: `SRC-0040`. Canonical URL: `https://docs.kalshi.com/getting_started/api_keys`. Captured 2026-08-31. The artifact has no explicit publication or page-update date.

## Source Type

Official documentation / primary platform. It is authority only for Kalshi-local API-key generation and request-authentication behavior documented at capture time. It does not establish cross-platform equivalence or a complete production security architecture.

## Selected Playbook

Primary playbook: `official-documentation`. No secondary playbook was required. Authentication fields and signing behavior are capture-date scoped. Code examples are illustrative rather than normative conformance tests.

## Purpose or Scope

The page explains how a Kalshi user generates an API key, receives a private key and Key ID, and constructs authentication headers for signed API requests (`SRC-0040`, lines 13-49). It documents authentication mechanics but does not itself authorize credential use, production access, orders, or trading.

## Evidence

- Procedural key-generation and one-time private-key availability guidance (`SRC-0040`, lines 13-29).
- Prose defining three authentication headers and the signed-message components (`SRC-0040`, lines 31-47).
- Python RSA-PSS, timestamp, header, and demo `GET` examples (`SRC-0040`, lines 51-124).
- JavaScript examples of analogous behavior (`SRC-0040`, lines 126-193).

## Main Findings

- The page says the described process is the same for demo and production, but it does not say a credential is portable between them (`SRC-0040`, lines 9-11).
- The profile workflow presents a private key in an RSA format and an associated unique Key ID (`SRC-0040`, lines 19-27).
- Kalshi says it does not retain the private key for later retrieval and instructs the user to save it securely (`SRC-0040`, lines 23-29).
- Each request to the Kalshi trading API is described as requiring signing with the generated private key; the page does not enumerate endpoint-specific exceptions (`SRC-0040`, lines 31-34).
- The three headers carry the Key ID, millisecond timestamp, and signature (`SRC-0040`, lines 35-41).
- The signing input is the direct concatenation of timestamp, HTTP method, and path. Query parameters are excluded from that signed path (`SRC-0040`, lines 43-47).
- Both language examples use RSA-PSS with SHA-256, digest-length salt, and Base64 output (`SRC-0040`, lines 69-90 and 141-158). This is example-level evidence.
- The request examples use uppercase `GET`, a demo host, the balance path, and the three authentication headers (`SRC-0040`, lines 93-123 and 161-189).

## Important Claims

- [CLM-0171] The API-key process is described as the same for demo and production, without establishing environment interchangeability.
- [CLM-0172] Key generation presents distinct private-key and Key-ID values.
- [CLM-0173] Kalshi says it does not retain the private key for later retrieval.
- [CLM-0174] Requests to the trading API are described as signed.
- [CLM-0175] Three authentication headers carry Key ID, millisecond timestamp, and signature.
- [CLM-0176] The signed message concatenates timestamp, method, and query-free path.
- [CLM-0177] The examples use Base64-encoded RSA-PSS/SHA-256 signatures with digest-length salt.
- [CLM-0178] The examples demonstrate signed `GET` requests in the demo environment.

## Response and Lifecycle Boundaries

The page does not document response schemas, server authentication errors, retry behavior, timestamp rejection, rate limits, key expiration, scopes, rotation, revocation, compromise recovery, or audit behavior. It covers initial generation and request signing only.

## Invariant Interpretation

A downstream engine may define a signer whose inputs are timestamp, uppercase HTTP method, and query-free request path, and whose output populates the three documented headers. Endpoint-specific authority must separately establish the selected operation, its authentication requirement, side-effect boundary, and response schema. This is an implementation interpretation, not authority to expose secrets or enable write methods.

## Security Boundaries

- Do not place real key IDs, private keys, signatures, or credential-derived values in repository files, fixtures, identities, serialization, logs, exceptions, or reports.
- Do not treat the documentation's credential-like example value as usable.
- Do not infer that the examples' unencrypted local-file pattern is an approved secret-storage design.
- Do not infer POST, PUT, PATCH, DELETE, order, cancellation, wallet, or trading authority from authentication mechanics.
- The research repository cannot serve as production secret storage or configuration.

## Uncertainty and Unsupported Assertions

The source does not define accepted clock skew, replay policy, timestamp expiry, method-case normalization, URL/path canonicalization, key size, complete key-container rules, normative signing vectors, server error semantics, environment credential portability, least-privilege scopes, or storage and rotation policy. It does not support claims that all `GET` endpoints are public or authenticated, that credentials are read-only, that failed authentication is retryable, or that possession of credentials authorizes trading.

## Relevance to Invariant

This source supplies a reviewed basis for planning signed-header construction for a bounded authenticated Kalshi `GET`. It must be combined with reviewed endpoint evidence. Real credentials must remain process-local and outside stable serialization and test fixtures; rate behavior must not be invented or hardcoded from stale evidence.

## Open Questions

- Are read-only API-key scopes available and verifiable?
- What clock-skew and timestamp-freshness rules apply?
- What are the normative method/path canonicalization rules and signing test vectors?
- What rotation, revocation, expiration, and compromise-recovery behavior is documented?
- Which secret-loading boundary can be authorized without serializing or logging key material?

## Review Notes

All direct findings, interpretation, uncertainty, and security boundaries are separated. The source was read completely. No credential was inspected. Independent ingestion review found no blocking issues; status is `reviewed`.
