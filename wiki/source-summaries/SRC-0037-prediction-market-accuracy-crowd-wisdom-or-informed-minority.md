---
page_id: SOURCE-SUMMARY-0036
title: "Prediction Market Accuracy: Crowd Wisdom or Informed Minority?"
page_type: source-summary
status: reviewed
created_at: 2026-07-15
updated_at: 2026-07-15
source_id: SRC-0037
sources:
  - SRC-0037
related_pages: []
tags:
  - polymarket
  - skill
  - price-discovery
  - arbitrage
  - public-information
  - insiders
  - prediction-markets
---

# Source Summary

## Citation

Gómez-Cram, Roberto, Yunhan Guo, Theis Ingerslev Jensen, and Howard Kung. "Prediction Market Accuracy: Crowd Wisdom or Informed Minority?" Working paper / complete PDF artifact, June 25, 2026. Source ID: `SRC-0037`. Canonical record: `https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6617059`.

## Source Type

Research paper. The authors study the full Polymarket transaction universe to distinguish skill from luck, test whether a small minority drives price discovery, and separate public-information trading from insider-trading explanations.

## Purpose or Research Question

The paper asks whether prediction market accuracy comes from crowd wisdom, from insiders trading on private information, or from a persistently skilled minority that repeatedly trades on public information.

## Methodology

The authors build a sign-randomization test that flips trade direction at the event level, classify accounts by the significance of realized PnL relative to randomized benchmarks, split events into training and test sets to test persistence, and then regress order imbalance and volume share on future prices, final outcomes, and pricing error.

## Data or Evidence Used

The paper analyzes all Polymarket markets created after January 1, 2023 and resolved by December 31, 2025. The sample covers 98,906 events, 210,322 markets, 1.72 million accounts, and $13.76 billion in trading volume.

## Main Findings

- Only a small minority of accounts are persistently skilled, and those accounts account for the bulk of price discovery.
- Realized PnL is a poor proxy for skill: many large winners are lucky rather than skillful.
- Skilled traders' order flow predicts future prices, final outcomes, and improvements in pricing accuracy, while the crowd generally does not.
- Skilled traders react to public news, enforce the law of one price, and trade against favorite-longshot bias.
- Insider-like accounts are localized and rare; they are not the main explanation for market-wide accuracy.

## Important Claims

- [CLM-0144] The paper analyzes Polymarket markets created after January 1, 2023 and resolved by December 31, 2025, covering 98,906 events, 210,322 markets, 1.72 million accounts, and $13.76 billion in trading volume.
- [CLM-0145] The skill measure is a sign-randomization test that flips buy/sell direction at the event level, uses B = 1,000 simulations per account, and classifies an account as skilled when its p-value is below 0.05.
- [CLM-0146] Under the benchmark specification with at least 10 events and no multiple-testing adjustment, 54,325 accounts are classified as skilled, or 3.16% of all accounts; under the Benjamini-Hochberg adjustment, the skilled share falls to 1.95% of all accounts.
- [CLM-0147] Skill is persistent out of sample: the training/test correlation of p-values is 0.35, 46% of skilled traders remain skilled in the test set, and realized PnL ranks are much less stable than the skill classification.
- [CLM-0148] Skilled traders' order imbalance predicts both next-period price changes and final outcomes, with coefficients of 2.05 and 7.77, while the lucky group has no statistically significant predictive power.
- [CLM-0149] Skilled traders' volume share reduces absolute pricing error, with a full-sample coefficient of -4.95 and stronger negative effects near resolution.
- [CLM-0150] Skilled traders react to public news: in both FOMC and corporate earnings windows, their order imbalance moves in the direction of the surprise, unlike the other groups.
- [CLM-0151] In multi-outcome events, skilled traders enforce the law of one price by buying equal quantities of No tokens across all outcomes, and the paper identifies arbitrage blocks by trade gaps longer than 10 seconds.
- [CLM-0152] Skilled traders bet against the favorite-longshot bias by selling overpriced long shots and buying underpriced favorites.
- [CLM-0153] The insider proxies flag 967 accounts that trade in 6.0% of markets, 1.3% of profits, and 0.2% of volume, and only 1.1% of those accounts are classified as skilled, indicating that insiders are localized and largely distinct from the skilled minority.

## Limitations

The study is historical and platform-specific. It does not prove that any current account maps to a stable human trader, and it does not establish a durable trading strategy that can be copied forward without regard to changing market structure, liquidity, or fees. The paper's skill measure is a statistical classification, not a direct identity label, and its arbitrage findings describe observed execution behavior rather than a generalizable promise of future profits.

## Review Checklist Coverage

- Exact sample period: January 1, 2023 through December 31, 2025.
- Trade, user, event, market, and volume counts: reported directly in Section 2.
- Skill classification: sign-randomization test with event-level randomization and 1,000 simulations.
- Percentage of skilled accounts: benchmark 3.16% of all accounts; 1.95% under Benjamini-Hochberg adjustment.
- Stability of classification: tested via train/test splits and transition matrices.
- Skilled traders and future prices: reported in Section 3.4 and Table 4.
- Skilled traders and price discovery: reported in Section 3.5 and Table 5.
- Public-news reactions: reported in Section 4.3.1 and Table 8.
- Arbitrage correction: reported in Section 4.3.2 and Figure 4.
- Market making versus information skill: market makers are treated as a separate behaviorally identified group in the skill test.
- Multi-wallet and account-identity caveat: the paper works at the account level and does not establish a stable one-wallet-one-human mapping.

## Version Selection Rationale

The local PDF artifact is complete and inspectable. The title page identifies "This version: June 25, 2026." I checked the stable SSRN abstract record as the canonical source URL and used the complete local PDF as the captured artifact because the PDF itself contains the full paper and no alternate complete public version was needed to establish paper identity. The PDF shows no explicit external version suffix, so `version: 1` is used as the repository source-record/capture version for the first inspected artifact.

## Relevance to Invariant

This paper is direct empirical evidence on how skill, public-information trading, arbitrage, and insider-like accounts interact in Polymarket. It helps separate forecasting accuracy from realized profit, and it provides empirical material for later execution and replay modeling without turning the paper into a trading recommendation.

## Conflicts With Existing Knowledge

- The paper's emphasis on skilled public-information trading differs from crowd-wisdom framings that treat forecast accuracy as broadly distributed across all participants.
- The insider proxies are localized and sparse, so they should not be generalized into a claim that insiders explain market-wide accuracy.
- The sign-randomization skill measure should not be collapsed into a durable human-identity label or a prescriptive copy-trading signal.

## Wiki Pages Affected

- `wiki/concepts/prediction-market-mechanics.md`
- `wiki/strategies/arbitrage-and-execution-risk.md`

## New Research Questions

- How much of the skilled minority's advantage survives under future Polymarket fee, liquidity, or market-design changes?
- Can a deterministic execution model reproduce the paper's arbitrage and price-discovery effects without assuming historical conditions that may no longer hold?
- To what extent do account-level statistics understate or overstate human-level skill when multiple wallets or shared infrastructure are present?

## Review Notes

The selected artifact is the complete user-provided PDF for `SRC-0037`. It is a 78-page working paper whose title page says "This version: June 25, 2026." The summary keeps the paper's statistical skill test, its price-discovery regressions, and its insider-proxy analysis separate so that downstream synthesis does not treat realized profit, account identity, or execution behavior as interchangeable concepts.
