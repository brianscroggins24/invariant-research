---
page_id: SOURCE-SUMMARY-0044
title: "Quick Start: Market Data"
page_type: source-summary
status: review-required
created_at: 2026-09-02
updated_at: 2026-09-02
source_id: SRC-0045
sources:
  - SRC-0045
related_pages:
  - PLATFORM-0002
  - CONCEPT-0002
tags:
  - kalshi
  - official-documentation
  - market-data
  - orderbook
  - authentication
  - public-api
---

# Source Summary

## Citation

Kalshi documentation. "Quick Start: Market Data." Source ID: `SRC-0045`. Canonical URL: `https://docs.kalshi.com/getting_started/quick_start_market_data`. Captured 2026-09-02. No explicit publication or page-update date appears. HTTP `Last-Modified` was retained only as transport metadata.

## Source Type and Playbook

Official documentation / primary platform, analyzed under the `official-documentation` playbook. The page is a quick-start tutorial: its explicit authentication prose is direct evidence, while code samples are illustrative rather than a complete API contract.

## Direct Findings

- The guide characterizes its series, event, market, and order-book workflow as public and unauthenticated (`SRC-0045`, lines 7-21).
- Its order-book examples send GET requests to `/trade-api/v2/markets/{market_ticker}/orderbook` without authentication headers (`SRC-0045`, lines 123-168).
- The examples consume `orderbook_fp.yes_dollars` and `no_dollars`, but do not establish a normative response schema (`SRC-0045`, lines 140-165).
- The guide separately says WebSocket live updates require authentication and directs authenticated trading and portfolio work to the API Keys guide (`SRC-0045`, lines 178-187).

## Direct Conflict With Active Authority

`SRC-0045` directly conflicts with active `SRC-0041`. The tutorial says no authentication headers are required and demonstrates the market-orderbook request without them. `SRC-0041` declares all three Kalshi authentication schemes on the same operation and documents a 401 authentication-required response (`SRC-0041`, lines 92-101 and 163-197).

Neither page supplies an explicit publication or update date. Capture order does not prove documentation or deployment precedence. Tutorial presentation is less formal than operation-level OpenAPI, but that evidence-strength difference does not erase the explicit contradiction.

## Important Claims

- [CLM-0198] The guide directly calls its covered market-data endpoints unauthenticated.
- [CLM-0199] The examples omit authentication headers for the order-book GET.

## Downstream Boundary

Do not assert that the Kalshi order-book endpoint is universally public, authenticated, or optionally authenticated. Do not resolve the conflict through a production probe or by assuming stale documentation, rollout behavior, or fallback. Work depending on the authentication policy must stop until reviewed evidence or an explicit governance decision resolves it.

This source does not authorize credential access, writes, orders, execution, or trading.

## Limitations

No live request was made. The source does not define response statuses, authentication-failure behavior, freshness, latency, atomicity, rate limits, retry rules, server equivalence, fixed-point precision, exact ordering, completeness, or runtime success of its examples.

## Review Notes

The complete canonical artifact was read. Direct prose, example-level evidence, conflict, interpretation, and uncertainty remain separated. No credential was accessed.
