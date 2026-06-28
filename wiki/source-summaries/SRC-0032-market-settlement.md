---
page_id: SOURCE-SUMMARY-0031
title: Market Settlement
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0032
sources:
  - SRC-0032
related_pages: []
tags:
  - kalshi
  - official-documentation
  - settlement

---

# Source Summary

## Citation

Kalshi documentation. "Market Settlement". Source ID: `SRC-0032`. Canonical URL: `https://docs.kalshi.com/getting_started/market_settlement.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Explains how market outcomes are determined and how positions are resolved into payouts.

## Key Facts

- Settlement occurs when a market outcome is determined; positions are automatically resolved and funds transferred.
- The page says a yes outcome pays yes holders $1 per contract and a no outcome pays no holders $1 per contract, with only net positions settled.
- Settlement timing can vary, and simple yes/no determinations have zero settlement fees while scalar settlement may incur fees and whole-cent rounding.

## Important Claims

- [CLM-0113] Settlement occurs when a market outcome is determined, and positions are automatically resolved with funds transferred.
- [CLM-0114] Yes outcomes pay yes holders $1 per contract, no outcomes pay no holders $1 per contract, only net positions are settled, and scalar settlement may incur fees with whole-cent rounding.
## Limitations

- The page is short and does not define every exceptional resolution path.
- It does not collapse determination, settlement, and cash availability into one step.
- Read together with `SRC-0031`, determination and finalization are distinct lifecycle states, so this page should not be read as guaranteeing immediate final cash availability at the instant of determination.

## Relevance to Invariant

- Important for cash-settlement and payout modeling.
- Useful for distinguishing determination from settlement timing, finalization, and eventual cash movement.

## Comparison to Polymarket / `SRC-0004`

- This page supports Kalshi-specific settlement semantics and does not corroborate Polymarket execution or arbitrage claims.
- It also does not imply any same-block or multi-leg atomicity guarantee.

## Open Questions

- Should scalar-settlement fees be modeled separately from ordinary yes/no settlement?
- How should downstream code represent netting before payout?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
