---
page_id: SOURCE-SUMMARY-0025
title: WebSocket Connection
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0026
sources:
  - SRC-0026
related_pages: []
tags:
  - kalshi
  - official-documentation
  - websocket
  - authentication

---

# Source Summary

## Citation

Kalshi documentation. "WebSocket Connection". Source ID: `SRC-0026`. Canonical URL: `https://docs.kalshi.com/websockets/websocket-connection.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Documents the single Kalshi WebSocket connection, handshake authentication, and the command taxonomy used over that connection.

## Key Facts

- The connection is `wss://external-api-ws.kalshi.com/` and requires authentication during the handshake.
- Public market-data channels still require authenticated WebSocket connections.
- Client commands include subscribe, unsubscribe, list_subscriptions, and update_subscription, with market selectors by ticker or UUID.

## Important Claims

- [CLM-0098] Kalshi’s WebSocket connection uses `wss://external-api-ws.kalshi.com/` and requires authentication during the handshake even for public data channels.
- [CLM-0099] Subscribe, unsubscribe, list_subscriptions, and update_subscription commands use client-generated ids and sid(s), and subscriptions can target `market_ticker(s)` or `market_id(s)`.
- [CLM-0100] `send_initial_snapshot` can seed the ticker channel, and `use_yes_price` is an orderbook-channel migration flag that defaults to false in this capture.
## Limitations

- This page defines the connection and command surface, not the payload schema for every market-data channel.
- The `use_yes_price` note is explicitly migration-sensitive and should be refreshed if the docs change.

## Relevance to Invariant

- This page is the entry point for all real-time data ingestion over WebSocket.
- The auth requirement matters for adapter design and credential handling.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s WebSocket requires authentication even for public market data, which is a venue-specific constraint that should not be assumed from Polymarket docs.
- The connection page does not support the `SRC-0004` claims about unthrottled parallel execution or same-block fill certainty.

## Open Questions

- Will `use_yes_price` be flipped to true and then removed on the announced migration timeline?
- Should downstream code treat `send_initial_snapshot` as a bootstrapping helper only for ticker data?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
