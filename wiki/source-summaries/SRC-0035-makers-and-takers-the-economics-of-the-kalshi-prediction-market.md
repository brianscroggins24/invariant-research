---
page_id: SOURCE-SUMMARY-0034
title: "Makers and Takers: The Economics of the Kalshi Prediction Market"
page_type: source-summary
status: review-required
created_at: 2026-07-09
updated_at: 2026-07-09
source_id: SRC-0035
sources:
  - SRC-0035
related_pages: []
tags:
  - kalshi
  - maker-taker
  - favorite-longshot-bias
  - market-microstructure
  - prediction-markets
  - fees
---

# Source Summary

## Citation

Bürgi, Constantin, Wanying Deng, and Karl Whelan. "Makers and Takers: The Economics of the Kalshi Prediction Market." University College Dublin working paper / author-hosted PDF, January 2026. Source ID: `SRC-0035`. Canonical PDF: `https://www.karlwhelan.com/Papers/Kalshi.pdf`.

## Source Type

Research paper. The authors study Kalshi's quote-driven microstructure using transaction-level data, maker/taker identities, and a simple model of belief sorting and probability distortion.

## Purpose or Research Question

The paper asks how Kalshi's quote-driven structure affects prices and returns, whether maker and taker outcomes differ, how fee rules shape realized returns, and whether a model with heterogeneous beliefs and probability weighting can reproduce the observed favorite-longshot pattern.

## Methodology

The authors use Kalshi API data at the transaction level, classify maker and taker sides directly from the platform records, compute pre-fee and post-fee returns by price band, run Mincer-Zarnowitz regressions for forecast accuracy, and calibrate a one-shot structural model with maker/taker sorting and biased beliefs.

## Data or Evidence Used

The paper analyzes transaction-level data from Kalshi's inception in 2021 through April 2025. The sample includes 46,282 contracts across 12,403 events and more than 300,000 price observations when both sides of each traded contract are counted.

## Main Findings

- Kalshi is quote-driven: makers post offers to buy Yes or No, takers accept offers, and the API records maker/taker side directly.
- Prices become more accurate as markets approach closing, but they still exhibit a strong favorite-longshot bias.
- Low-price contracts lose far more often than needed to break even after fees.
- High-price contracts can earn small positive returns.
- The average contract return is about minus 20%.
- Makers earn higher returns than takers, but both sides still display a favorite-longshot pattern.
- During the sample period, taker fees were a material part of the execution-cost story.
- The model with biased beliefs toward 0.5 fits the observed maker/taker pattern better than a model with only unbiased belief heterogeneity.

## Important Claims

- [CLM-0120] The sample spans 2021 through April 2025 and covers 46,282 contracts across 12,403 events.
- [CLM-0127] The main sample applies a $1,000 total-volume-at-close filter and counts over 300,000 price observations when both sides are included.
- [CLM-0121] Kalshi is quote-driven and the API directly identifies maker and taker side.
- [CLM-0122] Prices become more accurate as markets approach closing.
- [CLM-0123] Kalshi prices exhibit a favorite-longshot bias.
- [CLM-0128] Low-price contracts win less often than needed to break even after fees.
- [CLM-0129] High-price contracts earn small positive returns.
- [CLM-0130] The average contract return is about minus 20%.
- [CLM-0124] Makers earn higher average returns than takers after fees.
- [CLM-0125] The sample-period taker fee rule is 0.07P(1-P) per contract.
- [CLM-0131] Kalshi rounds the total taker fee up to the nearest cent.
- [CLM-0132] The paper's worked example gives a 1.77% average fee for a 50c contract in a 100-contract lot.
- [CLM-0126] The calibrated model needs a bias toward overstating low probabilities; unbiased belief heterogeneity alone does not reproduce the observed maker-taker return pattern.

## Limitations

The return estimates are sample-period specific and depend on the fee regime in force during 2021 through April 2025. The paper's structural model is a calibration exercise, not a proof that the strategy is executable or profit-guaranteeing in live trading. The model abstracts from intertemporal dynamics, and the discussion of returns emphasizes realized returns rather than annualized performance.

## Review Checklist Coverage

- Exact sample period: 2021 through April 2025.
- Excluded contracts: contracts below the $1,000 total trading-volume-at-close threshold are excluded from the main sample.
- Minimum volume filter: $1,000 total trading volume at closure.
- Spread filters: no explicit spread filter is reported in the paper.
- Price measure: traded contract prices from Kalshi's API, with returns computed from those prices and the sample-period taker-fee rule.
- Maker/taker distinction: direct transaction-level maker/taker labels from Kalshi's API.
- Historical fee formula and rounding: takers paid `0.07P(1-P)` rounded up to the nearest cent during the sample period.
- Fee changes after the sample: not analyzed as a post-sample policy result.
- Favorite-longshot bias measurement: win-fraction plots, return-by-price plots, and Mincer-Zarnowitz regressions.
- YES/NO book interpretation: the paper describes a quote-driven market with makers posting Yes or No offers and takers accepting them.
- Heterogeneous beliefs model: yes, with sorting into maker/taker decisions.
- Behavioral probability weighting: yes, the calibration uses a shift toward overstating low probabilities.
- Unique identification of the structural model: no; the paper says multiple parameter combinations provide similar fit quality.
- Annualized returns: no; the paper explicitly says the returns are not annualized.
- Capital lockup and non-fill risk: discussed qualitatively as reasons the pattern may persist, but not modeled as a full execution simulator.
- Prospective strategy interpretation: unsupported as a live trading guarantee.

## Version Selection Rationale

The inspection workflow checked the author-hosted PDF at `https://www.karlwhelan.com/Papers/Kalshi.pdf` and did not locate a separate complete public version during the batch. The artifact is complete, inspectable, and internally dated to January 2026 on the title page with PDF metadata creation date `2026-01-29`. The repository records `version: 1` as the first captured source-record version, not as an assertion of an external paper-version suffix. No external version ambiguity remains in the captured artifact itself.

## Relevance to Invariant

This paper is primary empirical evidence on Kalshi market microstructure, maker/taker economics, fee effects, and price distortion. It is relevant to later execution, replay, and microstructure modeling work, but it is not production configuration and it does not establish a timeless trading edge.

## Conflicts With Existing Knowledge

- The paper provides empirical Kalshi evidence, so it should not be used as a proxy for current documentation or current fee policy.
- The sample-period fee and return figures are historically bounded and should not be generalized to all future Kalshi trading.
- The paper's calibration result supports a behavioral interpretation, but it does not by itself establish a deployable strategy or a universal account-level profit pattern.

## Wiki Pages Affected

- None yet. This ingestion step intentionally avoids synthesis, concept, platform, or strategy pages.

## New Research Questions

- How do current Kalshi fees change the maker/taker return split observed in the sample period?
- How much of the measured return gap survives after accounting for current fee schedules, capital lockup, and missed fills?
- Can a deterministic execution model reproduce the paper's maker/taker sorting without the paper's simplifying assumptions?

## Review Notes

The selected artifact is the complete author-hosted PDF at `https://www.karlwhelan.com/Papers/Kalshi.pdf`. No alternate complete public version was located during review, so the captured PDF is treated as the latest inspectable authoritative artifact for this batch. The summary and claims remain review-required until registry, hash, and reference validation complete.
