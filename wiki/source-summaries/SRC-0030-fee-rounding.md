---
page_id: SOURCE-SUMMARY-0029
title: Fee Rounding
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0030
sources:
  - SRC-0030
related_pages: []
tags:
  - kalshi
  - official-documentation
  - fees
  - rounding

---

# Source Summary

## Citation

Kalshi documentation. "Fee Rounding". Source ID: `SRC-0030`. Canonical URL: `https://docs.kalshi.com/getting_started/fee_rounding.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Explains how Kalshi rounds fees and how the fee accumulator and rebates work across fills.

## Key Facts

- Direct member balances are rounded to the nearest $0.0001, while non-direct member balances are rounded to the nearest $0.01.
- Each fill produces trade fee, rounding fee, and rebate components, and the net fee is defined as trade fee plus rounding fee minus rebate.
- The fee accumulator aggregates rounding overpayment across fills and issues a rebate once the accumulation exceeds $0.01.

## Important Claims

- [CLM-0108] Direct member balances round to nearest $0.0001 and non-direct balances round to nearest $0.01; each fill produces trade fee, rounding fee, and rebate components.
- [CLM-0109] The fee accumulator carries rounding overpayment across all fills of an order, including maker/taker mixes, and issues rebates once accumulated rounding exceeds $0.01.
## Limitations

- The worked examples are illustrative and use specific fill patterns.
- The rounding behavior is fee- and balance-precision specific, so it should be refreshed if Kalshi changes the fee policy.

## Relevance to Invariant

- Important for net PnL and fill-accounting logic.
- Needed to avoid over- or under-counting fees across partial fills.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s fee rounding and rebate logic is platform-specific and should not be generalized from Polymarket docs.
- This page does not support any claim about production-trading latency or atomic strategy execution.

## Open Questions

- Should rounding fees and rebates be tracked per order or per account in downstream accounting?
- How should the engine aggregate net fees when fills alternate between taker and maker states?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
