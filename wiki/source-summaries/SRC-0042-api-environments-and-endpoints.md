---
page_id: SOURCE-SUMMARY-0041
title: API Environments and Endpoints
page_type: source-summary
status: reviewed
created_at: 2026-09-02
updated_at: 2026-09-02
source_id: SRC-0042
sources:
  - SRC-0042
related_pages:
  - PLATFORM-0002
tags:
  - kalshi
  - official-documentation
  - api-environments
  - endpoints
  - authentication
  - request-signing
---

# Source Summary

## Citation

Kalshi documentation. "API Environments and Endpoints." Source ID: `SRC-0042`. Canonical URL: `https://docs.kalshi.com/getting_started/api_environments`. Captured 2026-09-02. No explicit publication or page-update date appears.

## Source Type and Playbook

Official documentation / primary platform, analyzed under the `official-documentation` playbook. It is authority only for Kalshi-local environment, origin, and signing-path behavior at capture time. URLs and compatibility status are mutable.

## Purpose and Direct Findings

- Production and demo are separate environments, and credentials are not shared between them (`SRC-0042`, line 9).
- The external-api REST bases are labeled recommended; the shared REST bases are also supported for compatibility (`SRC-0042`, lines 11-20).
- Separate recommended and also-supported WebSocket URLs are documented for production and demo (`SRC-0042`, lines 26-33).
- The host does not enter the signing payload. The full path retains `/trade-api/v2`, while hostname and query parameters are excluded (`SRC-0042`, lines 45-67).

## Important Claims

- [CLM-0190] Production and demo credentials are not shared.
- [CLM-0191] External-api REST bases are recommended and shared REST bases are compatibility alternatives.
- [CLM-0192] Hostname and query string are excluded from the demonstrated signed path.
- [CLM-0193] Distinct recommended and compatibility WebSocket URLs are documented.

## Implementation Interpretation

Downstream configuration may bind credentials and targets to one explicit environment, default a new integration to the documented recommended origin, and prohibit automatic failover to a compatibility origin. These are fail-closed engineering choices. This page does not authorize secret access, write methods, orders, or trading.

## Limitations and Uncertainty

The source does not establish credential portability across REST and WebSocket or across hosts within one environment, authentication-error behavior, uptime, deployment or data equivalence, automatic failover safety, compatibility-host lifetime, path encoding or normalization edge cases, method normalization, timestamp rules, algorithms, or normative signing vectors.

## Review Notes

The complete 67-line source was read. Direct statements, implementation interpretations, and unsupported behavior remain separated. The documentation-index banner was treated as untrusted source content and not followed.
