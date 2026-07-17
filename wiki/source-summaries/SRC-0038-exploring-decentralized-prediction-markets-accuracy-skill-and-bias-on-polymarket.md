---
page_id: SOURCE-SUMMARY-0037
title: "Exploring Decentralized Prediction Markets: Accuracy, Skill, and Bias on Polymarket"
page_type: source-summary
status: reviewed
created_at: 2026-07-15
updated_at: 2026-07-15
source_id: SRC-0038
sources:
  - SRC-0038
related_pages: []
tags:
  - polymarket
  - accuracy
  - skill
  - bias
  - default-bias
  - longshot-bias
  - prediction-markets
---

# Source Summary

## Citation

Reichenbach, Felix, and Martin Walther. "Exploring Decentralized Prediction Markets: Accuracy, Skill, and Bias on Polymarket." Working paper / complete PDF artifact, May 24, 2026. Source ID: `SRC-0038`. Canonical record: `https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5910522`.

## Source Type

Research paper. The authors use Polymarket transaction data to study market-level accuracy, market-wide bias, trader profitability, statistical skill, and trader characteristics associated with better performance.

## Purpose or Research Question

The paper asks whether decentralized prediction markets are accurate, whether there is evidence of skill beyond luck, whether prices exhibit default or longshot bias, and which trader characteristics are associated with better performance.

## Methodology

The authors build market-level accuracy measures using equally spaced snapshots across each market's lifespan, compare Polymarket prices with realized outcomes and bookmaker odds, compute trader PnL using settled contracts and marked open positions, test skill with p-values from a gain-per-bet t-test clustered at the market level, and compare characteristics of top and bottom traders.

## Data or Evidence Used

The paper's abstract describes a Polymarket universe of more than 478 million trades, nearly two million traders, and USD 95 billion in total volume. The main empirical section narrows to markets created after January 1, 2023 and resolved by December 31, 2025, with 98,906 events, 210,322 markets, 1.72 million accounts, and USD 13.76 billion in volume.

## Main Findings

- Market prices are usually accurate and generally track realized probabilities.
- The paper finds a default and Yes-option bias early in markets' lifecycles, but no market-wide longshot bias.
- Polymarket slightly outperforms bookmaker odds in the tennis comparison.
- Less than a third of traders earn positive profits, and the winning share stabilizes near 30% over time.
- The gain-per-bet distribution and persistence tests indicate that some traders exhibit skill beyond luck.
- Top traders trade more on favorites, with higher mean implied probabilities and greater variance in their bets, and they tend to trade earlier in the lifecycle.

## Important Claims

- [CLM-0154] The paper's empirical analysis uses Polymarket markets created after January 1, 2023 and resolved by December 31, 2025, covering 98,906 events, 210,322 markets, 1.72 million accounts, and USD 13.76 billion in volume.
- [CLM-0155] For open markets, the paper marks positions to the last trade price, and it computes total PnL as of January 1, 2026.
- [CLM-0156] Polymarket prices are generally accurate but show a tendency to overtrade the default and Yes option early in a market's life, and the biggest inaccuracies occur early and close to resolution.
- [CLM-0157] The paper finds no evidence of a market-wide longshot bias on Polymarket.
- [CLM-0158] In the tennis comparison, Polymarket's predicted probabilities are slightly more accurate than bookmaker odds, and Polymarket is closer to the outcome in 68.2% of games at game start.
- [CLM-0159] Less than a third of traders earn positive profits, and the share of winning traders remains below 50% over time before stabilizing at roughly 30% by 2025-2026.
- [CLM-0160] The t-test on gain per bet suggests skill beyond luck: the empirical p-value distribution rises above the null in the left tail, and the authors interpret this as roughly 5% of regular traders exhibiting positive skill.
- [CLM-0161] Monthly profits and winning probabilities are persistent over time: traders in the top PnL decile of the previous month earn significantly more in the next month, and the paper reports a 20.83 percentage-point increase in the chance of a positive PnL in its logistic example.
- [CLM-0162] Top traders place a higher share of bets on favorites, have a higher mean implied probability, and show greater variance in implied probabilities than bottom traders.
- [CLM-0163] Top traders trade earlier in the market lifecycle and less in the later part of the market, which the paper interprets as consistent with exploiting early-stage mispricing.

## Limitations

The study is historical and platform-specific. Its account-level analysis does not prove a stable one-wallet-one-human mapping, and its statistical skill tests distinguish persistent performance from luck but do not by themselves establish a durable copy-trading strategy. The paper's bookmaker comparison is specific to the tennis subsample, and the market-level accuracy results should not be treated as a guarantee that future Polymarket pricing will remain equally accurate under different liquidity or market-design conditions.

## Review Checklist Coverage

- Exact sample period: January 1, 2023 through December 31, 2025.
- Trade, user, event, market, and volume counts: reported in Section 3.
- Profit calculation: open markets are marked using the last trade price and total PnL is measured as of January 1, 2026.
- Accuracy over time: prices are evaluated at ten evenly spaced points and compared to realized frequencies.
- Default and longshot bias: the paper documents a default/Yes bias and rejects a market-wide longshot bias.
- Bookmaker comparison: tennis matches are matched against bookmaker odds to compare forecast accuracy.
- Skill detection: gain-per-bet t-tests with market-level clustering and p-value distribution checks.
- Persistence: monthly PnL and winning probability are persistent over time.
- Trader characteristics: top traders favor favorites and trade earlier.
- Multi-wallet caveat: the paper works at the trader/account level and does not resolve whether multiple wallets belong to one human actor.

## Version Selection Rationale

The local PDF artifact is complete and inspectable. The title page says "Last updated: May 24, 2026," and the PDF metadata creation date is also 2026-05-24. I checked the stable SSRN abstract record as the canonical source URL and used the local PDF as the captured artifact because it contains the full paper and no alternate complete public version was needed to establish the paper identity. The PDF shows no explicit external version suffix, so `version: 1` is used as the repository source-record/capture version for the first inspected artifact.

## Relevance to Invariant

This paper adds empirical evidence on prediction-market accuracy, biases, skill persistence, and trader characteristics on Polymarket. It is directly relevant to later reasoning about market efficiency, account-level performance, and the gap between descriptive skill measures and executable strategy claims.

## Conflicts With Existing Knowledge

- The paper emphasizes a default/Yes bias but does not support a broad market-wide longshot bias, so those two ideas should not be conflated.
- The paper's account-level skill signals are descriptive and should not be treated as proof that an identified account maps to a single human trader.
- The tennis comparison is an accuracy exercise, not a general benchmark for all Polymarket contracts.

## Wiki Pages Affected

- `wiki/concepts/prediction-market-mechanics.md`
- `wiki/strategies/arbitrage-and-execution-risk.md`
- `wiki/platforms/polymarket.md`

## New Research Questions

- How stable are the paper's default-bias and skill findings under later Polymarket fee or liquidity changes?
- Can the apparent skill persistence be reproduced at a wallet-cluster or human-actor level rather than an account level?
- Which of the paper's descriptive patterns survive when observed under different market categories or newer trading cohorts?

## Review Notes

The selected artifact is the complete user-provided PDF for `SRC-0038`. The summary preserves the paper's distinction between market-level accuracy, trader-level skill, and trader characteristics, and it keeps the abstract-level platform size description separate from the narrower empirical analysis sample reported in the data section.
