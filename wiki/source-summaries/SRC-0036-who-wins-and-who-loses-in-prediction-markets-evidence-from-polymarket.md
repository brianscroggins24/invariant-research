---
page_id: SOURCE-SUMMARY-0035
title: "Who Wins and Who Loses in Prediction Markets? Evidence from Polymarket"
page_type: source-summary
status: review-required
created_at: 2026-07-15
updated_at: 2026-07-15
source_id: SRC-0036
sources:
  - SRC-0036
related_pages: []
tags:
  - polymarket
  - maker-taker
  - liquidity
  - profit-concentration
  - forecast-accuracy
  - execution-costs
  - prediction-markets
---

# Source Summary

## Citation

Akey, Pat, Vincent Grégoire, Nicolas Harvie, and Charles Martineau. "Who Wins and Who Loses in Prediction Markets? Evidence from Polymarket." SSRN working paper / complete PDF artifact, June 12, 2026. Source ID: `SRC-0036`. Canonical record: `https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6443103`.

## Source Type

Research paper. The authors study Polymarket's complete transaction history to understand who profits, whether profits align with forecasting skill or liquidity provision, and how execution costs and trading style relate to performance.

## Purpose or Research Question

The paper asks who wins and who loses on Polymarket, whether profitable traders are better forecasters or better liquidity providers, how much of performance can be attributed to spread costs, whether gains are concentrated, and whether insider trading plausibly explains the strongest winners.

## Methodology

The authors aggregate Polymarket trades at the wallet level, reconstruct mark-to-market PnL from the complete transaction history, compute an excess-hit-rate measure of forecasting accuracy, estimate probit models for positive performance, decompose spread costs, study monthly persistence, and examine the top winners descriptively.

## Data or Evidence Used

The paper analyzes Polymarket trades from November 11, 2022 through March 29, 2026. The sample covers over 2.4 million users, 588.3 million trades, 614,883 markets, 255,427 events, and $67.1 billion in volume.

## Main Findings

- Profits are highly concentrated: the top tail of winners captures most gains while the majority of users lose money.
- Forecasting accuracy and profitability are positively related, but the authors explicitly caution against reading that relation as proof of durable skill.
- Liquidity provision is the strongest cross-sectional predictor of positive performance.
- Spread costs matter for some losers but do not explain the worst losses.
- Month-to-month persistence is modest and appears stronger among limit-order traders.
- The largest winners often look like liquidity providers, and the paper argues that insider trading is not the dominant explanation for their profits.

## Important Claims

- [CLM-0133] The paper analyzes Polymarket trades from November 11, 2022 through March 29, 2026, covering 2.48 million users, 588.3 million trades, 614,883 markets, 255,427 events, and $67.1 billion in volume.
- [CLM-0134] Trading gains are highly concentrated: the top 0.1% of users with positive PnL capture 51.2% of gains, the top 1% capture 76.5%, and roughly 69% of users end the sample with a loss.
- [CLM-0135] The paper's excess-hit-rate measure is strongly negative across the loss tail and rises to about +0.20 for the most profitable users, but the authors caution that this pattern alone does not establish skill.
- [CLM-0136] The paper's finite-mixture model classifies about 29.3% of users as skilled.
- [CLM-0137] A one-standard-deviation increase in maker-volume share is associated with a 9.0 percentage-point higher probability of positive performance.
- [CLM-0138] Among the top 0.1% of earners, 47.3% of volume is supplied as makers versus 17.1% for the bottom 95%.
- [CLM-0139] Removing the minimum-tick spread cost would move 18.5% of losers into non-negative PnL, and the top 0.1% of winners would earn about 3.2% more absent spread costs.
- [CLM-0140] Month-to-month performance is only modestly persistent, and the persistence that does exist is concentrated among users who trade primarily through limit orders.
- [CLM-0141] The 100 most successful users account for 27.7% of aggregate winners' profits, and a meaningful fraction are pure liquidity providers.
- [CLM-0142] The authors argue that insider trading is unlikely to explain the largest winners, and the two prosecuted insider-trading cases discussed in the paper together account for roughly 0.13% of aggregate winners' profits.
- [CLM-0143] The paper aggregates by wallet address, notes that some traders may operate multiple wallets, and observes only Polymarket activity, so cross-platform arbitrage and wallet-to-wallet transfers are not fully captured.

## Limitations

The study is historical and platform-specific. The authors' spread decomposition is a lower-bound adjustment that does not recover the actual spread in every trade, the PnL construction does not observe off-platform trading or wallet-to-wallet transfers, and the wallet-address grouping may undercount users who operate multiple wallets. The paper is descriptive rather than causal and does not establish a deployable trading strategy or a guarantee of future profits.

## Review Checklist Coverage

- Exact sample period: November 11, 2022 through March 29, 2026.
- Trade, user, event, market, and volume counts: reported directly in Table 2.
- Profit concentration: reported directly in Section 4.1 and Figure 3.
- Forecast accuracy: summarized by excess-hit-rate measures in Section 4.2.
- Maker/taker distinction: inferred from transaction-side labels and liquidity-provision classification.
- Liquidity-taking cost: estimated with a minimum-tick lower-bound spread adjustment.
- Spread, fee, timing, and directional accuracy: treated separately in the paper's analysis.
- Concentration of gains: quantified in Section 4.1 and Table 3.
- Wallet clustering: the paper warns that multiple wallets can lead to undercounting activity.
- Partial fills and canceled orders: not separately analyzed as a dedicated execution-history problem.
- Prospective strategy interpretation: unsupported as a live trading guarantee.

## Version Selection Rationale

The local PDF artifact is complete and inspectable, and the title page identifies June 12, 2026. I used the stable SSRN abstract record as the canonical source URL because the captured file is the full paper associated with that record and no alternate complete public version was needed to establish the paper identity in this batch. The PDF itself shows no explicit version suffix, so `version: 1` is used as the repository source-record/capture version for the first inspected artifact.

## Relevance to Invariant

This paper is direct empirical evidence on Polymarket execution quality, maker-versus-taker outcomes, spread capture, and the gap between forecasting skill and realized trading performance. It is especially relevant for later execution, replay, and microstructure modeling.

## Conflicts With Existing Knowledge

- The paper is a historical empirical study, so it should not be read as current Polymarket documentation or a statement about current fees, limits, or channel behavior.
- The concentration and maker/taker findings are descriptive, not proof that copying any specific wallet will work.
- The paper's execution-cost analysis uses a lower-bound spread adjustment and therefore should not be treated as a complete live-trading cost model.

## Wiki Pages Affected

- `wiki/concepts/prediction-market-mechanics.md`
- `wiki/strategies/arbitrage-and-execution-risk.md`
- `wiki/platforms/polymarket.md`

## New Research Questions

- How much of the maker/taker advantage survives under current market structure and fee schedules?
- How much of the observed concentration persists once wallet clustering, off-platform activity, and direct transfers are handled more explicitly?
- Can a deterministic execution model reproduce the paper's spread and liquidity findings without relying on historical conditions that may no longer hold?

## Review Notes

The selected artifact is the complete user-provided PDF for `SRC-0036`. It is a text-readable 158-page document whose content matches the stable SSRN record. The summary separates descriptive findings, explicit cautions, and limitations so that downstream synthesis does not treat the paper as a causal or prescriptive trading manual.
