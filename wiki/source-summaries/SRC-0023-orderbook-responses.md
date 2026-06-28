---
page_id: SOURCE-SUMMARY-0022
title: Orderbook Responses
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0023
sources:
  - SRC-0023
related_pages: []
tags:
  - kalshi
  - official-documentation
  - orderbook
  - pricing

---

# Source Summary

## Citation

Kalshi documentation. "Orderbook Responses". Source ID: `SRC-0023`. Canonical URL: `https://docs.kalshi.com/getting_started/orderbook_responses.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Explains how to interpret Kalshi orderbooks, why only bids are returned, and how to derive implied asks and spreads.

## Key Facts

- The orderbook response is wrapped in `orderbook_fp` and contains `yes_dollars` and `no_dollars` bid arrays.
- Each array element is a two-item string array: `[price_dollars, count_fp]`.
- The page explains that a YES bid at X is equivalent to a NO ask at `1 - X`, and vice versa.

## Important Claims

- [CLM-0090] Kalshi orderbook responses return only YES and NO bids because the opposite-side ask can be derived from binary-market reciprocity.
- [CLM-0091] The arrays are sorted in ascending price order, the best bid is the last element, and the bid-ask spread is derived from the best bid on one side and the complementary best bid on the other side.
## Limitations

- The examples are explanatory rather than contractual examples of all possible books.
- The page does not define the transport format for live updates.

## Relevance to Invariant

- This page is the conceptual bridge between the REST snapshot and the derived best-price logic used by consumers.
- It is important for distinguishing raw bids from implied asks in adapter code.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s derived ask logic is venue-specific; do not treat it as a universal rule for all prediction markets.
- Nothing here supports the `SRC-0004` claim that Bregman projection directly yields executable position sizing.

## Open Questions

- Should a downstream engine store implied asks explicitly or compute them on demand?
- How should consumers handle empty arrays on one side of the book?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
