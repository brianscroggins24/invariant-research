---
page_id: SOURCE-SUMMARY-0042
title: Generate API Key
page_type: source-summary
status: reviewed
created_at: 2026-09-02
updated_at: 2026-09-02
source_id: SRC-0043
sources:
  - SRC-0043
related_pages:
  - PLATFORM-0002
tags:
  - kalshi
  - official-documentation
  - api-keys
  - authentication
  - scopes
  - security
---

# Source Summary

## Citation

Kalshi documentation. "Generate API Key." Source ID: `SRC-0043`. Canonical URL: `https://docs.kalshi.com/api-reference/api-keys/generate-api-key`. Captured 2026-09-02. No explicit publication or page-update date appears.

## Source Type and Playbook

Official documentation / primary platform, analyzed under the `official-documentation` playbook. Scope names, defaults, restrictions, and schemas are mutable and Kalshi-local. The embedded OpenAPI marker `3.29.0` is not a publication date or deployment guarantee.

## Scope Findings

- The scope enum contains broad `read` and `write` values plus five narrower child scopes (`SRC-0043`, lines 161-185).
- Broad `read` and `write` are described as granting all read and write endpoints; child scopes grant their specific endpoint groups (`SRC-0043`, lines 179-185).
- Broad `write` requires broad `read`, while child scopes may be granted without a broad parent (`SRC-0043`, lines 109-117).
- Omitting `scopes` is documented to default to broad `read` plus `write` access (`SRC-0043`, lines 109-117).

## Response and Security Boundary

The endpoint generates an RSA key pair, stores the public key, and returns required `api_key_id` and PEM private-key fields. The private key cannot be retrieved again (`SRC-0043`, lines 5-7 and 139-152). This mutating credential endpoint is evidence about available scope configuration, not authorization for Invariant to invoke it.

## Important Claims

- [CLM-0194] Broad read/write and narrower child scopes are documented.
- [CLM-0195] Scope dependencies and the omitted-scope full-access default are documented.
- [CLM-0196] The successful response returns one-time private-key material.

## Invariant Interpretation

A downstream operator should select scopes explicitly and fail closed rather than omit the field. Milestone code must not create keys, assume every account can obtain every scope, or treat a scope label as proof of runtime enforcement. Real secrets remain outside research, fixtures, serialization, logs, and reports.

## Limitations

The source does not establish actual scopes on an existing key, runtime enforcement, endpoint membership for each child group, empty or duplicate-scope behavior, key size, encryption, expiration, rotation, revocation, recovery, safe retry, or authorization equivalence across REST, FIX, and WebSocket.

## Review Notes

The complete canonical artifact was read. No credential was inspected and no key-generation request was sent. Direct findings, interpretation, mutability, and authorization boundaries remain separate.
