---
page_id: SOURCE-SUMMARY-0030
title: Market Lifecycle
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0031
sources:
  - SRC-0031
related_pages: []
tags:
  - kalshi
  - official-documentation
  - market-lifecycle

---

# Source Summary

## Citation

Kalshi documentation. "Market Lifecycle". Source ID: `SRC-0031`. Canonical URL: `https://docs.kalshi.com/getting_started/market_lifecycle.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Defines the documented market lifecycle states, transitions, and order behavior after close.

## Key Facts

- REST market statuses include `initialized`, `active`, `inactive`, `closed`, `determined`, `disputed`, `amended`, and `finalized`.
- The page distinguishes implicit time-based transitions from explicit WebSocket events such as `deactivated`, `activated`, `close_date_updated`, `determined`, and `settled`.
- After `close_time` passes, order operations including cancellations are rejected with `MARKET_INACTIVE`, and resting orders are cancelled shortly after close.

## Important Claims

- [CLM-0110] REST market statuses include `initialized`, `active`, `inactive`, `closed`, `determined`, `disputed`, `amended`, and `finalized`.
- [CLM-0111] The documented transitions include initialized→active at open time without a WebSocket event, active/inactive→closed at close time, inactive→active via deactivated/activated events, closed→determined, and determined/amended→finalized via `settled`.
- [CLM-0112] Once `close_time` passes, order operations including cancellations are rejected with `MARKET_INACTIVE`, and resting orders are cancelled shortly after close.
## Limitations

- The page explains the documented lifecycle, but it does not specify every possible internal exchange state.
- The FAQ notes that an event-level status is not the same thing as market status.

## Relevance to Invariant

- Needed for market-state handling, order rejection logic, and lifecycle synchronization.
- The explicit distinction between close, determination, and finalization is important for settlement accounting.

## Comparison to Polymarket / `SRC-0004`

- Kalshi documents the lifecycle explicitly; do not import Polymarket-specific assumptions about atomic multi-leg execution.
- The page documents exchange-managed lifecycle transitions and settlement-state changes. It does not establish a blockchain settlement mechanism, and it does not imply strategy-level atomicity.

## Open Questions

- How should open orders be reconciled when a market reopens after a close-time update?
- Should downstream state machines treat `determined` and `finalized` as separate terminal states?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
