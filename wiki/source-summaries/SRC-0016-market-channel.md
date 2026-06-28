---
page_id: SOURCE-SUMMARY-0015
title: Market Channel
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0016
sources:
  - SRC-0016
related_pages: []
tags:
  - polymarket
  - official-documentation
  - websocket
  - orderbook
  - streaming
---

# Source Summary

## Citation

Polymarket documentation. "Market Channel." Source ID: `SRC-0016`. Canonical URL: `https://docs.polymarket.com/api-reference/wss/market.md`.

## Source Type

Official documentation / primary platform. This page is the detailed market-channel reference for WebSocket snapshots and incremental updates.

## Purpose or Scope

The page defines the subscription controls, the full-book snapshot event, and the incremental market-update events for the market channel.

## Key Facts

- Market subscriptions use asset IDs and can request an initial dump, a depth level, and custom-feature events.
- `initial_dump` defaults to true, and `level` defaults to 2 with documented values 1, 2, and 3.
- The `book` event is a full orderbook snapshot sent on subscribe or after a trade, with asset_id, market, bids, asks, timestamp, and hash.
- The `price_change` event carries price-level deltas when orders are placed or cancelled.
- The page also documents last_trade_price, tick_size_change, best_bid_ask, new_market, and market_resolved event payloads.
- The channel uses PING/PONG heartbeats and supports dynamic subscribe/unsubscribe without reconnecting.

## Important Claims

- [CLM-0072] The market channel supports `initial_dump`, `level`, and `custom_feature_enabled` subscription controls.
- [CLM-0073] The `book` and `price_change` events provide full-snapshot and incremental price-level updates for the market channel.
- [CLM-0074] The market channel documents last_trade_price and tick_size_change payloads for trade execution and tick-size updates.
- [CLM-0075] The market channel documents best_bid_ask, new_market, and market_resolved events when the custom feature is enabled.

## Limitations

The page does not document sequence numbers, ordering guarantees, gap detection, or recovery after missed messages.

## Relevance to Invariant

This is the primary source for WebSocket book reconstruction and lifecycle event propagation.

## Comparison to SRC-0004

- Supports the existence of snapshot plus incremental order-book updates.
- Does not support any undocumented replay or recovery algorithm.
- Does not support claims about same-block execution or direct mempool submission.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
