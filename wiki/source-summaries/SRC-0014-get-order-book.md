---
page_id: SOURCE-SUMMARY-0013
title: Get order book
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0014
sources:
  - SRC-0014
related_pages: []
tags:
  - polymarket
  - official-documentation
  - orderbook
  - api
  - market-data
---

# Source Summary

## Citation

Polymarket documentation. "Get order book." Source ID: `SRC-0014`. Canonical URL: `https://docs.polymarket.com/api-reference/market-data/get-order-book.md`.

## Source Type

Official documentation / primary platform. This page is the OpenAPI reference for fetching an order-book snapshot for a token.

## Purpose or Scope

The page describes the request identifier, snapshot fields, field types, sorting order, and error cases for the /book endpoint.

## Key Facts

- GET /book requires a token_id query parameter.
- The response includes market, asset_id, timestamp, hash, bids, asks, min_order_size, tick_size, neg_risk, and last_trade_price.
- Bids are sorted by price descending and asks by price ascending.
- Price and size are strings in the order summary objects.
- The endpoint is public and returns 404 when no orderbook exists for the requested token.

## Important Claims

- [CLM-0067] GET /book requires token_id and returns a snapshot with market, asset_id, timestamp, hash, bids, asks, min_order_size, tick_size, neg_risk, and last_trade_price.
- [CLM-0068] The returned bids are sorted descending, asks ascending, and the response uses string-typed price and size fields on a public endpoint.

## Limitations

The page does not document WebSocket sequencing, incremental recovery, or bulk snapshot variants.

## Relevance to Invariant

This is the primary source for deterministic snapshot ingestion of order-book state.

## Comparison to SRC-0004

- Supports the order-book snapshot shape and sorting rules.
- Does not support sequence-number or gap-recovery assumptions.
- Does not support any claim that midpoint is an execution price.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
