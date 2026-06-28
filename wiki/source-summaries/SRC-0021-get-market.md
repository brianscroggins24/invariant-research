---
page_id: SOURCE-SUMMARY-0020
title: Get Market
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0021
sources:
  - SRC-0021
related_pages: []
tags:
  - kalshi
  - official-documentation
  - market-data
  - market-model

---

# Source Summary

## Citation

Kalshi documentation. "Get Market". Source ID: `SRC-0021`. Canonical URL: `https://docs.kalshi.com/api-reference/market/get-market.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Defines the market object, its YES/NO quote fields, lifecycle status, and price-range metadata.

## Key Facts

- The page prose describes a market as a tradable YES/NO outcome within an event.
- The Market schema separately permits `market_type` values of `binary` and `scalar`.
- The Market schema exposes YES and NO bid/ask prices, last trade price, volume, open interest, settlement timer, and status.
- `price_level_structure` and `price_ranges` describe the market’s valid price intervals and tick sizes.

## Important Claims

- [CLM-0085] The page describes a market as a tradable outcome within an event with YES/NO positions, while the Market schema permits `market_type` values of both `binary` and `scalar`.
- [CLM-0086] Market responses expose YES/NO bid and ask prices and sizes, last price, volume, open interest, settlement timer, status, and price-range metadata.
- [CLM-0087] The market status enum includes `initialized`, `inactive`, `active`, `closed`, `determined`, `disputed`, `amended`, and `finalized`.
## Limitations

- The page is a snapshot of market metadata and does not document order creation or settlement mechanics.
- The deprecated `fractional_trading_enabled` field is legacy and should not be used as the primary capability signal.

## Relevance to Invariant

- This page is the core market model for order-book ingestion and execution mapping.
- The status and price-range fields matter for lifecycle handling and price validation.

## Comparison to Polymarket / `SRC-0004`

- Kalshi exposes both bid and ask fields on the market object, which is different from the bid-only orderbook snapshot semantics described elsewhere in this doc set.
- Do not map the market object directly to Polymarket’s condition/outcome-token model.

## Open Questions

- Should downstream validation use `price_level_structure`/`price_ranges` rather than the deprecated `response_price_units` and `fractional_trading_enabled` fields?
- How should scalar markets be represented alongside binary markets in a binary-only adapter?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
