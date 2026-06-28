---
page_id: SOURCE-SUMMARY-0019
title: Get Event
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0020
sources:
  - SRC-0020
related_pages: []
tags:
  - kalshi
  - official-documentation
  - events
  - event-model

---

# Source Summary

## Citation

Kalshi documentation. "Get Event". Source ID: `SRC-0020`. Canonical URL: `https://docs.kalshi.com/api-reference/events/get-event.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Defines an event, its relation to a series, and how the API optionally nests markets inside the event response.

## Key Facts

- An event is a real-world occurrence that can be traded on, and it contains one or more markets.
- The response exposes `event_ticker`, `series_ticker`, `collateral_return_type`, `mutually_exclusive`, `settlement_sources`, and fee overrides.
- `with_nested_markets=true` embeds the markets inside the event object; older settled markets remain accessible via the endpoint.

## Important Claims

- [CLM-0082] An event is a real-world occurrence that can contain one or more markets, and `with_nested_markets=true` nests those markets in the event response.
- [CLM-0083] The EventData schema exposes `event_ticker`, `series_ticker`, `collateral_return_type`, `mutually_exclusive`, `settlement_sources`, `fee_type_override`, and `fee_multiplier_override`.
- [CLM-0084] When `mutually_exclusive` is true, only one market in the event can resolve to `yes`; when false, multiple markets can resolve to `yes`.
## Limitations

- The page does not define a standalone event lifecycle separate from market lifecycle.
- The `markets` field is marked deprecated in favor of the nested `event.markets` field.

## Relevance to Invariant

- This is the key page for modeling the series→event→market hierarchy.
- The fee override fields matter for fee inheritance and adapter refresh logic.

## Comparison to Polymarket / `SRC-0004`

- Kalshi events are not the same thing as Polymarket conditions or event collections.
- The page does not support any claim that multi-leg strategies execute atomically.

## Open Questions

- Should event-level fee overrides be treated as mutable runtime configuration in downstream systems?
- How should older markets that fell past the historical cutoff be merged with nested event data?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
