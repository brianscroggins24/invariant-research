---
page_id: SOURCE-SUMMARY-0008
title: Prices & Orderbook
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0009
sources:
  - SRC-0009
related_pages: []
tags:
  - polymarket
  - official-documentation
  - orderbook
  - pricing
  - clob
---

# Source Summary

## Citation

Polymarket documentation. "Prices & Orderbook." Source ID: `SRC-0009`. Canonical URL: `https://docs.polymarket.com/concepts/prices-orderbook.md`.

## Source Type

Official documentation / primary platform. This page explains how Polymarket prices arise from the CLOB and how the order book is interpreted.

## Purpose or Scope

The page covers probability-style pricing, bid/ask semantics, spread, displayed price rules, and the hybrid offchain/onchain trade path.

## Key Facts

- Polymarket uses a Central Limit Order Book, and prices emerge from supply and demand.
- Prices range from $0.00 to $1.00 and are presented as implied probabilities.
- The displayed price is the midpoint of the bid-ask spread unless the spread is wider than $0.10, in which case last traded price is shown.
- Bids are buy orders at the highest prices traders are willing to pay; asks are sell orders at the lowest prices traders are willing to accept.
- The page says trades use offchain matching with onchain settlement, and it warns that large orders can move price significantly.

## Important Claims

- [CLM-0051] Polymarket prices are CLOB-derived probabilities in the $0.00 to $1.00 range.
- [CLM-0052] The displayed price is the bid-ask midpoint unless the spread is wider than $0.10, in which case last traded price is shown.
- [CLM-0053] The order book consists of bids and asks, with spread and depth matters, and trades use hybrid offchain matching with onchain settlement.

## Limitations

This page does not document WebSocket sequencing, reconciliation after missed updates, or order submission payloads.

## Relevance to Invariant

This is a primary source for price interpretation, spread handling, and order-book reconstruction. It supports market-data ingestion, but not direct claims about executable midpoint pricing.

## Comparison to SRC-0004

- Supports bid/ask, spread, midpoint, and depth terminology.
- Does not support treating the displayed midpoint as an executable trading price.
- The page describes offchain matching plus onchain settlement, but not any same-block execution guarantee.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
