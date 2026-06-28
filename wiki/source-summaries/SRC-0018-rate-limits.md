---
page_id: SOURCE-SUMMARY-0017
title: Rate Limits
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0018
sources:
  - SRC-0018
related_pages: []
tags:
  - polymarket
  - official-documentation
  - rate-limits
  - api
  - infrastructure
---

# Source Summary

## Citation

Polymarket documentation. "Rate Limits." Source ID: `SRC-0018`. Canonical URL: `https://docs.polymarket.com/api-reference/rate-limits.md`.

## Source Type

Official documentation / primary platform. This page records the documented API rate limits and the throttling behavior used to enforce them.

## Purpose or Scope

The page enumerates general, endpoint-specific, and trading limits across the Gamma API, Data API, CLOB API, Bridge API, and related endpoints.

## Key Facts

- Rate limits are enforced via Cloudflare throttling.
- When a limit is exceeded, requests are delayed or queued rather than immediately rejected.
- Limits reset on sliding time windows.
- The page documents general limits plus endpoint-specific limits for market data, auth, ledger, trading, bridge, and other APIs.
- Trading endpoints have both burst and sustained limits.

## Important Claims

- [CLM-0078] Polymarket rate limiting is enforced by Cloudflare throttling with delayed or queued requests and sliding reset windows.
- [CLM-0079] The page documents public, authenticated, and trading-specific limits, including burst and sustained trading caps.

## Limitations

The page does not define client-side retry algorithms or guarantee specific latency under throttling.

## Relevance to Invariant

This is the primary source for request pacing and backoff policy. It should be treated as time-sensitive operational metadata.

## Comparison to SRC-0004

- Supports the need to treat rate limits as mutable operational constraints.
- Does not support any fixed latency or fill-time claim.
- Does not define a production execution path.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
