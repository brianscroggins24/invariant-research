---
page_id: SOURCE-SUMMARY-0032
title: Historical Data
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0033
sources:
  - SRC-0033
related_pages: []
tags:
  - kalshi
  - official-documentation
  - historical-data

---

# Source Summary

## Citation

Kalshi documentation. "Historical Data". Source ID: `SRC-0033`. Canonical URL: `https://docs.kalshi.com/getting_started/historical_data.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Explains the split between live and historical data and how cutoff timestamps route requests to historical endpoints.

## Key Facts

- Kalshi partitions live and historical data for markets, market candlesticks, trades, and orders, while old events and series remain on the original endpoints.
- The cutoffs come from `GET /historical/cutoff`, and older records must use the corresponding historical endpoints.
- Resting live orders remain visible on `GET /portfolio/orders` even if older completed orders have moved to the historical path.

## Important Claims

- [CLM-0115] Kalshi partitions live and historical data for markets, market candlesticks, trades, and orders, while older events and series remain available through their original endpoints.
- [CLM-0116] GET /historical/cutoff provides the cutoff timestamps, and records older than market_settled_ts, trades_created_ts, or orders_updated_ts must be fetched via the corresponding historical endpoints while resting live orders remain on GET /portfolio/orders.
## Limitations

- The page describes routing and cutoff behavior, not detailed payload shapes for every historical endpoint.
- Historical fills and trades are mentioned as routed entities, but their detailed schemas are out of scope here.

## Relevance to Invariant

- Important for backfill and archival ingestion design.
- Needed to decide whether a query belongs on a live or historical endpoint.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s historical cutoff routing is platform-specific and should not be inferred from Polymarket docs.
- The page does not support any execution-latency claim from `SRC-0004`.

## Open Questions

- Should backfill jobs always query the cutoff first or cache it with a refresh policy?
- How should live and historical results be merged for a complete timeline?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
