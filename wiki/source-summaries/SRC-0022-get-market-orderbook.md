---
page_id: SOURCE-SUMMARY-0021
title: Get Market Orderbook
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0022
sources:
  - SRC-0022
related_pages: []
tags:
  - kalshi
  - official-documentation
  - orderbook
  - market-data

---

# Source Summary

## Citation

Kalshi documentation. "Get Market Orderbook". Source ID: `SRC-0022`. Canonical URL: `https://docs.kalshi.com/api-reference/market/get-market-orderbook.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Documents the REST snapshot for a single market order book and the depth parameter used to limit levels.

## Key Facts

- The endpoint returns the current order book for a specific market and accepts a `depth` query parameter.
- The response is `orderbook_fp`, which contains `yes_dollars` and `no_dollars` arrays of `[price_dollars, contract_count_fp]` pairs.
- The page explicitly says asks are not returned directly; the response is a snapshot of active bids only.

## Important Claims

- [CLM-0088] Get Market Orderbook returns the current order-book snapshot for a specific market and uses an optional `depth` parameter to limit levels.
- [CLM-0089] The response is `orderbook_fp` with `yes_dollars` and `no_dollars` arrays of `[price_dollars, contract_count_fp]` values, and asks are not returned directly.
## Limitations

- The page documents a snapshot API, not a streaming update channel.
- It does not define recovery behavior for missed updates.

## Relevance to Invariant

- This is the canonical REST input for order-book reconstruction.
- The `depth` knob matters for backfills and partial-book ingestion.

## Comparison to Polymarket / `SRC-0004`

- The book is described in Kalshi YES/NO terms, not in Polymarket condition/outcome-token terms.
- The API returns bids only and relies on complementary-side inference for asks.

## Open Questions

- How should clients interpret a depth-limited book when reconstructing a full book over time?
- Should downstream storage keep the response as-is or normalize to a unified price-level model?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
