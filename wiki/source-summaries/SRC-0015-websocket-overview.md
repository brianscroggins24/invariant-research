---
page_id: SOURCE-SUMMARY-0014
title: WebSocket Overview
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0015
sources:
  - SRC-0015
related_pages: []
tags:
  - polymarket
  - official-documentation
  - websocket
  - market-data
  - streaming
---

# Source Summary

## Citation

Polymarket documentation. "WebSocket Overview." Source ID: `SRC-0015`. Canonical URL: `https://docs.polymarket.com/market-data/websocket/overview.md`.

## Source Type

Official documentation / primary platform. This page summarizes the available WebSocket channels and their basic subscription model.

## Purpose or Scope

The page provides the channel map, top-level event taxonomy, subscription payload structure, and heartbeat expectations.

## Key Facts

- The platform exposes four channels: market, user, sports, and RTDS.
- The market channel is unauthenticated, the user channel requires auth, and the sports channel is unauthenticated.
- Market subscriptions use asset IDs; user subscriptions use condition IDs plus auth.
- The market channel exposes book, price_change, tick_size_change, last_trade_price, best_bid_ask, new_market, and market_resolved events.
- Heartbeats are documented as PING/PONG every 10 seconds for market and user channels, and ping/pong every 5/10 seconds for sports.
- Dynamic subscribe and unsubscribe operations are supported without reconnecting.

## Important Claims

- [CLM-0069] The official WebSocket surface includes market, user, sports, and RTDS channels with the documented auth requirements.
- [CLM-0070] Market subscriptions use asset IDs, user subscriptions use condition IDs, and dynamic subscribe/unsubscribe is supported without reconnecting.
- [CLM-0071] The overview documents the main market-channel event taxonomy and the heartbeat rules for the channels.

## Limitations

This page does not define event payload schemas in detail and does not document sequence numbers, gap detection, or recovery after missed updates.

## Relevance to Invariant

This page is the top-level entry point for streaming market-data ingestion. It supports channel selection and auth routing, but not replay or reconciliation logic.

## Comparison to SRC-0004

- Supports the existence of real-time market-data streaming.
- Does not support undocumented recovery or sequencing assumptions.
- Does not support claims about direct execution latency or block timing.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
