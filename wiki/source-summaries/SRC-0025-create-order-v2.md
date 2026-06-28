---
page_id: SOURCE-SUMMARY-0024
title: Create Order (V2)
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0025
sources:
  - SRC-0025
related_pages: []
tags:
  - kalshi
  - official-documentation
  - orders
  - execution

---

# Source Summary

## Citation

Kalshi documentation. "Create Order (V2)". Source ID: `SRC-0025`. Canonical URL: `https://docs.kalshi.com/api-reference/orders/create-order-v2.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Documents the authenticated order-creation endpoint, including request validation, time-in-force behavior, and response fields.

## Key Facts

- The endpoint requires API key, signature, and timestamp headers during the request.
- Requests require `ticker`, `side`, `count`, `price`, `time_in_force`, and `self_trade_prevention_type`, and use fixed-point price/count strings.
- The response returns order identifiers, immediate fill information, and matching-engine timestamp data.

## Important Claims

- [CLM-0094] Create Order V2 requires the Kalshi access-key, signature, and timestamp headers and accepts `ticker`, `side`, `count`, `price`, `time_in_force`, and `self_trade_prevention_type`.
- [CLM-0095] The endpoint quotes event markets from the YES side: `bid` means buy YES and `ask` means sell YES; `good_till_canceled` is the expiring-order pattern with `expiration_time`, `GTT` is not a valid API value, and `immediate_or_cancel` cannot be combined with `expiration_time`.
- [CLM-0096] The response returns `order_id`, `client_order_id`, `fill_count`, `remaining_count`, `average_fill_price`, `average_fee_paid`, and `ts_ms`, with `remaining_count` reflecting the final unfilled quantity after IOC cancellation.
- [CLM-0097] Self-trade prevention `taker_at_cross` cancels the taker order when it crosses against the same user, while `maker` cancels the resting maker order and continues matching.
## Limitations

- The page documents order placement, not full trade/fill history.
- The `exchange_index` field is described, but the page notes that only shard 0 is currently supported.

## Relevance to Invariant

- This is the core execution entry point for order submission.
- The response fields are useful for order-state tracking and fill accounting.

## Comparison to Polymarket / `SRC-0004`

- The page supports authenticated order submission but not any claim that multiple orders or arbitrage legs execute atomically.
- Nothing here supports same-block execution or direct-mempool shortcuts from `SRC-0004`.

## Open Questions

- Should `post_only` and `cancel_order_on_pause` be treated as mandatory controls in higher-level adapters?
- How should downstream code model `remaining_count` for partially filled IOC orders?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
