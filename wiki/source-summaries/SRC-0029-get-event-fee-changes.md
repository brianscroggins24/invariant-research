---
page_id: SOURCE-SUMMARY-0028
title: Get Event Fee Changes
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0029
sources:
  - SRC-0029
related_pages: []
tags:
  - kalshi
  - official-documentation
  - fees

---

# Source Summary

## Citation

Kalshi documentation. "Get Event Fee Changes". Source ID: `SRC-0029`. Canonical URL: `https://docs.kalshi.com/api-reference/events/get-event-fee-changes.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Documents event-level fee overrides and how they layer on top of the series fee structure.

## Key Facts

- Event fees are overrides layered on top of the parent series fee structure.
- If `fee_type_override` and `fee_multiplier_override` are null, the override is cleared and the series fee applies again.
- The response is paginated with `event_fee_changes` and `cursor`.

## Important Claims

- [CLM-0106] Event fee changes are overrides layered on series fees, and null override fields clear the event override so the series defaults apply again.
- [CLM-0107] The event fee-changes response is paginated with `event_fee_changes` and `cursor`, and each record includes event ticker, series ticker, override fields, and scheduled effective time.
## Limitations

- This page describes change history and override semantics, not a complete fee-policy derivation engine.
- The endpoint is mutable because future overrides can be scheduled.

## Relevance to Invariant

- Critical for modeling inheritance from series to event.
- Important for adapter logic that needs to distinguish default fees from event overrides.

## Comparison to Polymarket / `SRC-0004`

- Kalshi explicitly models fee inheritance and override clearing; do not assume the same pattern from Polymarket docs.
- This page does not establish anything about multi-leg execution or arbitrage settlement.

## Open Questions

- Should downstream code store effective fees separately from scheduled overrides?
- How should a null override be represented internally so that inheritance remains explicit?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
