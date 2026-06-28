---
page_id: SOURCE-SUMMARY-0023
title: Fixed-Point Migration
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0024
sources:
  - SRC-0024
related_pages: []
tags:
  - kalshi
  - official-documentation
  - fixed-point
  - migration

---

# Source Summary

## Citation

Kalshi documentation. "Fixed-Point Migration". Source ID: `SRC-0024`. Canonical URL: `https://docs.kalshi.com/getting_started/fixed_point_migration.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Explains Kalshi’s fixed-point price and quantity migration, including subpenny pricing and fractional contracts.

## Key Facts

- Prices are represented as fixed-point dollar strings with the `_dollars` suffix and up to 4 decimal places.
- `price_level_structure` and `price_ranges` define the allowed price intervals and tick sizes for a market.
- Contract counts use `_fp` fixed-point strings; responses always emit two decimals and request values must match when both legacy and fixed-point fields are supplied.

## Important Claims

- [CLM-0092] The migration introduces fixed-point `_dollars` price strings with up to 4 decimals and uses `price_level_structure` plus `price_ranges` to define valid tick intervals.
- [CLM-0093] Contract-count `_fp` fields are strings with 0-2 decimal places on input, always emit 2 decimals in responses, have 0.01 minimum granularity, and must match legacy integer fields when both are provided.
## Limitations

- The page is a migration guide, so its guidance is version-sensitive.
- The page does not by itself define the semantics of every endpoint field that migrated to fixed-point strings.

## Relevance to Invariant

- Important for adapter parsing and type normalization.
- This page gives the canonical explanation for the fixed-point value formats used by the orderbook and order APIs.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s fixed-point field conventions are platform-specific and should not be conflated with Polymarket’s field naming or precision rules.
- The page supports parsing guidance, not execution claims.

## Open Questions

- Should downstream code canonicalize all fixed-point strings to integers, decimals, or a custom value object?
- How should the engine handle future removals of legacy integer fields?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. The capture includes a page-level “Last Updated: April 17, 2026” line.
