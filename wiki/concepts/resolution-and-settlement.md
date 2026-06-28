---
page_id: CONCEPT-0003
title: Resolution and Settlement
page_type: concept
status: review-required
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0008
  - SRC-0010
  - SRC-0011
  - SRC-0031
  - SRC-0032
related_pages:
  - CONCEPT-0001
  - CONCEPT-0002
  - STRATEGY-0001
  - PLATFORM-0001
  - PLATFORM-0002
tags:
  - settlement
  - resolution
  - payout
  - lifecycle
---

# Resolution and Settlement

## Purpose

Separate outcome determination from settlement, payout, redemption, finalization, and cash availability. This page preserves the venue-specific differences rather than forcing both venues into one mechanism.

## Resolution and Determination

- Polymarket resolves markets through the UMA Optimistic Oracle and defined market rules. [CLM-0058] [CLM-0059]
- Kalshi uses exchange-managed lifecycle terminology, including `determined`, `disputed`, `amended`, and `finalized`. [CLM-0110] [CLM-0111]
- Repository synthesis: resolution is a market-outcome event; it is not the same thing as order matching.

## Settlement

- Polymarket order settlement is scoped to an individual matched trade, not to a whole multi-leg strategy. [CLM-0054]
- Kalshi says settlement begins when a market outcome is determined and positions are automatically resolved with funds transferred. [CLM-0113]
- The two venues use different settlement language, so the same term must not be assumed to mean the same mechanism.

## Payout and Redemption

- Polymarket winning tokens redeem for $1 each through the collateral adapter into pUSD. [CLM-0060]
- Polymarket positions are balances of outcome tokens, so payout is a token-redemption process. [CLM-0048] [CLM-0049] [CLM-0050]
- Kalshi describes payout as automatic position resolution and fund transfer rather than token redemption. [CLM-0114]

## Finalization

- Kalshi distinguishes `determined` from later `finalized` status. [CLM-0110] [CLM-0111]
- Repository synthesis: finalization is a later lifecycle state, not a synonym for determination.

## Cash Availability

- The reviewed Kalshi docs do not guarantee that cash is immediately available at the instant of determination.
- Read together, `SRC-0031` and `SRC-0032` show that determination, settlement, and finalization are distinct steps. [CLM-0113] [CLM-0114]
- For Polymarket, the redemption path is explicit, but the settlement of one matched trade is not the same as the completion of a multi-leg strategy. [CLM-0054] [CLM-0060]

## Order Settlement Versus Market Settlement

- Order settlement concerns how a matched trade is closed out.
- Market settlement concerns how the market’s final outcome turns into payouts or redemptions.
- `SRC-0010` and `SRC-0032` make this distinction explicit in different venue-local ways. [CLM-0054] [CLM-0113]

## Polymarket Model

- Market resolution uses an oracle and market rules.
- Winning tokens redeem through the collateral adapter.
- Atomicity applies to the settlement of one matched trade, not to a strategy with multiple independently submitted legs. [CLM-0054] [CLM-0060]

## Kalshi Model

- The lifecycle is exchange-managed.
- `determined`, `disputed`, `amended`, and `finalized` are distinct lifecycle states. [CLM-0110] [CLM-0111]
- Settlement is described as automatic resolution with funds transferred, but not as blockchain-based or on-chain. [CLM-0113]

## Cross-Platform Differences

- Polymarket’s model is token-and-redemption based.
- Kalshi’s model is exchange lifecycle and payout based.
- Repository synthesis: these are analogous only at a high level; they are not mechanically identical.

## Timing Uncertainty

- Polymarket resolution can involve oracle challenge windows. [CLM-0059]
- Kalshi lifecycle transitions can separate close, determination, dispute, amendment, settlement, and finalization. [CLM-0111] [CLM-0112] [CLM-0113]
- Timing therefore requires venue-specific handling.

## Mutable Platform Facts

- Polymarket oracle/resolution details and fee behavior are venue-specific and date-sensitive. [CLM-0058] [CLM-0059] [CLM-0076] [CLM-0077]
- Kalshi lifecycle, fee, and historical-routing behavior are mutable and date-sensitive. [CLM-0110] [CLM-0111] [CLM-0112] [CLM-0115] [CLM-0116] [CLM-0117] [CLM-0118] [CLM-0119]

## Open Questions

- When should a downstream system treat determination as economically final?
- What additional venue-specific evidence is needed to model cash availability precisely?
- How should scalar settlement fees be represented without conflating them with ordinary payout timing?

## Related Pages

- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0008`, `SRC-0010`, `SRC-0011`: [CLM-0048], [CLM-0049], [CLM-0050], [CLM-0054], [CLM-0058], [CLM-0059], [CLM-0060]
- `SRC-0031`: [CLM-0110], [CLM-0111], [CLM-0112]
- `SRC-0032`: [CLM-0113], [CLM-0114]
