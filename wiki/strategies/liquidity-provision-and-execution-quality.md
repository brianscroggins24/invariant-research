---
page_id: STRATEGY-0002
title: Liquidity Provision and Execution Quality
page_type: strategy
status: review-required
created_at: 2026-07-17
updated_at: 2026-07-17
sources:
  - SRC-0035
  - SRC-0036
  - SRC-0037
  - SRC-0038
related_pages:
  - CONCEPT-0002
  - CONCEPT-0004
  - CONCEPT-0003
  - PLATFORM-0001
  - PLATFORM-0002
tags:
  - liquidity-provision
  - execution-quality
  - maker-taker
  - spread-cost
  - prediction-markets
---

# Liquidity Provision and Execution Quality

## Purpose

Synthesize the reviewed evidence on how liquidity provision, maker/taker behavior, spread capture, and fee treatment affect realized performance. This page is about execution quality, not about market accuracy alone and not about a durable trading signal by itself.

## Scope and Terminology

- Liquidity provision means supplying quotes or resting orders that can be consumed by later traders.
- Execution quality means the realized performance of a trading style after spread, fees, depth, and fill effects are taken into account.
- Maker/taker labels are venue-local and should not be treated as equivalent across platforms.
- The reviewed papers measure execution quality differently, so the page preserves those differences rather than collapsing them into one universal return metric.

## Maker/Taker Economics

- `SRC-0035` finds that Kalshi is quote-driven and that makers earn higher average returns than takers after fees in the sample period. [CLM-0121] [CLM-0124]
- The same paper also shows that the historical fee rule mattered materially and that the sample-period returns are not a timeless Kalshi policy statement. [CLM-0125] [CLM-0131] [CLM-0132]
- `SRC-0036` finds that on Polymarket, maker volume share is positively associated with performance and that the top winners often look like liquidity providers. [CLM-0137] [CLM-0138] [CLM-0141]

## Execution Quality Versus Forecast Accuracy

- `SRC-0035` and `SRC-0036` both show that execution quality and forecasting quality are not the same object.
- `SRC-0037` and `SRC-0038` strengthen that distinction by separating statistical skill, price discovery, and realized PnL from one another. [CLM-0147] [CLM-0153] [CLM-0160] [CLM-0161]
- Repository synthesis: a trader can improve execution quality without proving superior forecast skill, and a good forecaster can still realize poor execution outcomes.

## Fees, Spread, and Depth

- `SRC-0036`'s lower-bound spread adjustment shows that removing minimum-tick spread cost would change a meaningful fraction of losers and materially affect top winners as well. [CLM-0139]
- `SRC-0035` shows that fee treatment materially changes the maker/taker comparison, including the historical rounding rule. [CLM-0125] [CLM-0131] [CLM-0132]
- `SRC-0004` treats depth, fees, and VWAP as operational constraints, but that is practitioner guidance rather than primary empirical evidence. [CLM-0019] [CLM-0023]
- Repository synthesis: an apparent edge is only execution-quality evidence once fees and depth are incorporated.

## Partial Fills and Exposure

- `SRC-0036` notes that its execution-cost analysis is not a complete fill-history model and therefore does not fully recover the actual spread in every trade. [CLM-0139] [CLM-0143]
- `SRC-0035` and `SRC-0036` both imply that non-fill and fill quality can matter for whether a profitable-looking style remains attractive after execution. [CLM-0126] [CLM-0140]
- Partial fills matter because they can leave the trader partly exposed even when the first leg or first side succeeds.

## Venue Differences

- Kalshi's sample-period maker/taker returns are historically bounded and fee-sensitive. [CLM-0124] [CLM-0125]
- Polymarket's execution-quality evidence is concentrated in wallet-level data, so wallet clustering and off-platform transfers remain caveats. [CLM-0143]
- The papers do not establish that the same execution style transfers unchanged across venues.

## What This Synthesis Establishes

- Liquidity provision can be a major component of realized performance.
- Spread costs, fee rules, and depth materially affect whether an apparent opportunity is worth trading.
- Execution quality can be observed empirically without implying a durable copy-trading rule.

## What This Synthesis Does Not Establish

- It does not establish that maker returns are risk-free.
- It does not establish that always providing liquidity beats taking liquidity in every venue or sample.
- It does not establish that current fee schedules match the historical samples.
- It does not establish that a profitable execution style is a complete market-making engine.

## Related Pages

- [Market Accuracy and Price Discovery](../concepts/market-accuracy-and-price-discovery.md)
- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0035`: [CLM-0121], [CLM-0124], [CLM-0125], [CLM-0126], [CLM-0127], [CLM-0128], [CLM-0129], [CLM-0130], [CLM-0131], [CLM-0132]
- `SRC-0036`: [CLM-0137], [CLM-0138], [CLM-0139], [CLM-0140], [CLM-0141], [CLM-0143]
- `SRC-0037`: [CLM-0147], [CLM-0153]
- `SRC-0038`: [CLM-0155], [CLM-0159], [CLM-0160], [CLM-0161]
