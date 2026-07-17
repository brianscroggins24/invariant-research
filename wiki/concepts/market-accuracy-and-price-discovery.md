---
page_id: CONCEPT-0004
title: Market Accuracy and Price Discovery
page_type: concept
status: reviewed
created_at: 2026-07-17
updated_at: 2026-07-17
sources:
  - SRC-0035
  - SRC-0036
  - SRC-0037
  - SRC-0038
related_pages:
  - CONCEPT-0002
  - CONCEPT-0003
  - CONCEPT-0005
  - STRATEGY-0001
  - STRATEGY-0002
  - PLATFORM-0001
  - PLATFORM-0002
tags:
  - accuracy
  - price-discovery
  - skill
  - calibration
  - prediction-markets
---

# Market Accuracy and Price Discovery

## Purpose

Compare how the reviewed prediction-market papers measure accuracy and price discovery, and preserve the distinction between market-level calibration, trader-level skill, and realized profitability. This page is synthesis, so it combines multiple reviewed sources rather than restating any single paper.

## Scope and Terminology

- Accuracy means closeness of quoted or traded prices to realized outcomes under a paper-specific estimator.
- Price discovery means order flow or trader behavior that moves prices toward later beliefs or final outcomes.
- Profitability means realized PnL or return; it is not the same thing as accuracy or skill.
- The reviewed papers do not share a common estimator, sample window, or account model, so their results are only comparable when those differences are preserved.

## How the Papers Measure Accuracy

- `SRC-0035` uses a Kalshi transaction-level sample and reports that prices become more accurate as markets approach closing. [CLM-0120] [CLM-0122]
- `SRC-0036` reconstructs wallet-level mark-to-market PnL and compares forecast accuracy to profitability using excess-hit-rate measures and spread-cost adjustments. [CLM-0135] [CLM-0139] [CLM-0143]
- `SRC-0037` uses a sign-randomization skill test and then asks whether skilled traders' order flow predicts future prices, final outcomes, and pricing error. [CLM-0145] [CLM-0148] [CLM-0149]
- `SRC-0038` uses market-level snapshots, a gain-per-bet t-test, and a tennis benchmark against bookmaker odds to study accuracy and bias. [CLM-0154] [CLM-0156] [CLM-0158] [CLM-0160]

## Accuracy Is Not Profit

- `SRC-0036` explicitly warns that positive forecast signals do not by themselves prove durable skill, even when forecast accuracy and profitability are positively related. [CLM-0135] [CLM-0140] [CLM-0141]
- `SRC-0037` separates realized PnL from the skill classification and notes that some large winners are lucky rather than skillful. [CLM-0146] [CLM-0147] [CLM-0153]
- `SRC-0038` likewise treats winning traders, statistical skill, and market accuracy as different objects rather than as interchangeable labels. [CLM-0159] [CLM-0160] [CLM-0161]
- Repository synthesis: a market can be reasonably accurate even when profits are concentrated and execution costs materially affect trader returns.

## Price Discovery

- `SRC-0037` provides the strongest price-discovery result in the batch: skilled traders' order imbalance predicts next-period price changes and final outcomes, and their volume share reduces absolute pricing error. [CLM-0148] [CLM-0149]
- `SRC-0037` also finds that skilled traders react to public news and trade against favorite-longshot bias, which supports a price-discovery interpretation rather than a pure luck story. [CLM-0150] [CLM-0152]
- `SRC-0038` finds that Polymarket prices are generally accurate, but it still reports a default and Yes-option bias early in a market's life and no market-wide longshot bias. [CLM-0156] [CLM-0157]
- Repository synthesis: price discovery is about how order flow changes prices, not about whether the same traders end up with the highest PnL.

## Venue and Sample Differences Matter

- `SRC-0035` is a Kalshi study covering 2021 through April 2025. [CLM-0120]
- `SRC-0036` covers Polymarket from November 11, 2022 through March 29, 2026 and aggregates by wallet address. [CLM-0133] [CLM-0143]
- `SRC-0037` and `SRC-0038` both focus on Polymarket markets created after January 1, 2023 and resolved by December 31, 2025, but they use different accuracy and skill metrics. [CLM-0144] [CLM-0145] [CLM-0154] [CLM-0160]
- Repository synthesis: comparisons across these papers must preserve the paper-specific time window, price measure, and identity unit.

## What This Synthesis Establishes

- Forecast accuracy, price discovery, and realized profitability are related but not identical concepts.
- The same venue can support both a market-level accuracy story and a trader-level concentration story.
- Statistical skill measures can be informative without being direct identity labels or copy-trading signals. [CLM-0147] [CLM-0153] [CLM-0160]

## What This Synthesis Does Not Establish

- It does not establish a universal market-efficiency law across venues.
- It does not establish that profitable traders are always better forecasters.
- It does not establish that a stable skilled cohort will persist forever.
- It does not collapse wallet, account, and human identity into a single unit. [CLM-0143] [CLM-0153]

## Related Pages

- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0035`: [CLM-0120], [CLM-0122], [CLM-0124], [CLM-0125]
- `SRC-0036`: [CLM-0133], [CLM-0135], [CLM-0139], [CLM-0140], [CLM-0141], [CLM-0143]
- `SRC-0037`: [CLM-0145], [CLM-0146], [CLM-0147], [CLM-0148], [CLM-0149], [CLM-0150], [CLM-0152], [CLM-0153]
- `SRC-0038`: [CLM-0154], [CLM-0155], [CLM-0156], [CLM-0157], [CLM-0158], [CLM-0159], [CLM-0160], [CLM-0161], [CLM-0162], [CLM-0163]
