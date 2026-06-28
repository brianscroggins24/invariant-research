---
page_id: SOURCE-SUMMARY-0027
title: Get Series Fee Changes
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0028
sources:
  - SRC-0028
related_pages: []
tags:
  - kalshi
  - official-documentation
  - fees

---

# Source Summary

## Citation

Kalshi documentation. "Get Series Fee Changes". Source ID: `SRC-0028`. Canonical URL: `https://docs.kalshi.com/api-reference/exchange/get-series-fee-changes.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Documents the series-level fee-change history endpoint and the fee-type enum used by Kalshi.

## Key Facts

- The endpoint returns `series_fee_change_arr` and accepts optional `series_ticker` and `show_historical` query parameters.
- Each fee-change entry includes an id, the series ticker, fee type, fee multiplier, and scheduled effective timestamp.
- The fee-type enum includes `quadratic`, `quadratic_with_maker_fees`, and `flat`.

## Important Claims

- [CLM-0104] The series fee-changes endpoint returns `series_fee_change_arr` plus optional `series_ticker` and `show_historical` filters, and each record includes id, series ticker, fee type, fee multiplier, and scheduled timestamp.
- [CLM-0105] The fee-type enum for series fee changes includes `quadratic`, `quadratic_with_maker_fees`, and `flat`.
## Limitations

- This endpoint documents change history, not a full immutable fee policy.
- The result set is mutable over time as future fee changes are scheduled.

## Relevance to Invariant

- Useful for fee-hierarchy modeling and refresh logic.
- The scheduled timestamp matters for time-sensitive fee interpretation.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s fee model is venue-specific and does not map cleanly to Polymarket fee discussions.
- This page does not support any execution-latency claim from `SRC-0004`.

## Open Questions

- Should downstream systems cache fee schedules or always re-query before pricing?
- How should a consumer interpret future-scheduled fee changes that have not yet taken effect?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
