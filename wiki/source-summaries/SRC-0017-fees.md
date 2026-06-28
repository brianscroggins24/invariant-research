---
page_id: SOURCE-SUMMARY-0016
title: Fees
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0017
sources:
  - SRC-0017
related_pages: []
tags:
  - polymarket
  - official-documentation
  - fees
  - trading-costs
  - clob
---

# Source Summary

## Citation

Polymarket documentation. "Fees." Source ID: `SRC-0017`. Canonical URL: `https://docs.polymarket.com/trading/fees.md`.

## Source Type

Official documentation / primary platform. This page defines the trading-fee model and the cases where fees are waived.

## Purpose or Scope

The page covers taker-fee behavior, category-specific fee rates, the fee formula, precision rules, and the market-level query path for fee parameters.

## Key Facts

- Polymarket charges small taker fees on certain markets and does not include fee information in orders.
- Geopolitical and world-event markets are fee-free.
- Fees are determined per market at match time, and markets with fees enabled expose `feesEnabled: true`.
- Makers are never charged fees; only takers pay.
- The fee formula is `fee = C × feeRate × p × (1 - p)`, where C is shares traded and p is share price.
- Fees are denominated in USDC and rounded to 5 decimal places.

## Important Claims

- [CLM-0076] Polymarket charges taker fees on certain markets, exempts geopolitical/world-event markets, and applies fees at match time.
- [CLM-0077] The fee formula is `fee = C × feeRate × p × (1 - p)`, makers are never charged, and fee precision is rounded to 5 decimal places in USDC.

## Limitations

The page does not document order-book mechanics or resolution behavior.

## Relevance to Invariant

This is the primary source for transaction-cost modeling and fee sensitivity. The fee schedule is mutable and market-category specific.

## Comparison to SRC-0004

- Supports fee-aware execution modeling.
- Does not support any claim about production rebate or optimizer behavior beyond the explicit fee rules.
- The fee schedule is mutable and should not be treated as a constant.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
