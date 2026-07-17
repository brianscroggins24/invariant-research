---
page_id: SOURCE-SUMMARY-0038
title: "From Iran to Taylor Swift: Informed Trading in Prediction Markets"
page_type: source-summary
status: reviewed
created_at: 2026-07-15
updated_at: 2026-07-15
source_id: SRC-0039
sources:
  - SRC-0039
related_pages: []
tags:
  - informed-trading
  - prediction-markets
  - polymarket
  - kalshi
  - surveillance
  - insider-trading
  - legal-analysis
---

# Source Summary

## Citation

Mitts, Joshua, and Moran Ofir. "From Iran to Taylor Swift: Informed Trading in Prediction Markets." SSRN working paper / complete PDF artifact, March 16, 2026. Source ID: `SRC-0039`. Canonical record: `https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6426778`.

## Source Type

Research paper. The authors combine case studies, a composite screening method, permutation testing, and legal analysis to study informed trading on prediction markets.

## Purpose or Research Question

The paper asks whether informed trading in prediction markets is systematic rather than isolated, what informational advantages appear in the trading record, and how existing insider-trading doctrine does or does not map onto prediction-market contracts.

## Methodology

The authors review highly publicized case studies, build a composite score that combines bet-size anomalies, profitability, pre-event timing, and directional concentration, and then validate the screen with permutation tests and monotonic win-rate patterns. They also analyze the legal framework governing prediction-market informed trading.

## Data or Evidence Used

The main statistical screen covers Polymarket markets from February 2024 through February 2026 and evaluates more than 210,000 suspicious wallet-market pairs. The paper also discusses case studies spanning geopolitical, institutional, corporate, and personal-information settings, and it validates the screen on 138,281 profitable wallet-market pairs.

## Main Findings

- The paper argues that informed trading in prediction markets is systematic rather than limited to a few isolated incidents.
- The composite screen flags more than 210,000 suspicious wallet-market pairs, and the flagged group posts a 69.9% win rate with roughly $143 million in aggregate anomalous profit.
- The empirical case studies span the Maduro trade, the IDF case, the Nobel Peace Prize case, the AlphaRaccoon case, the OpenAI browser case, and the Taylor Swift / romanticpaul case.
- The legal analysis concludes that classical and misappropriation theories do not map cleanly onto prediction-market event contracts and that the CFTC's Rule 180.1 is narrower than SEC Rule 10b-5 in important respects.
- The article proposes platform-level registration and surveillance, contract-level rules for high-risk information channels, and an extended misappropriation theory for decentralized platforms.

## Important Claims

- [CLM-0164] The paper presents a systematic empirical and legal study of informed trading on prediction markets, analyzes over 210,000 suspicious wallet-market pairs from Polymarket markets between February 2024 and February 2026, and reports a 69.9% win rate and approximately $143 million in aggregate anomalous profit.
- [CLM-0165] The composite screening score combines bet size anomalies, profitability, pre-event timing, and directional concentration.
- [CLM-0166] The paper's case studies include the Maduro trade, the IDF case, the Nobel Peace Prize case, the AlphaRaccoon case, the OpenAI browser case, and the Taylor Swift / romanticpaul case.
- [CLM-0167] The paper's stated limitations are that it cannot observe an entire portfolio position for a given individual or entity, may miss multiple blockchain identifiers, may be looking at a profitable trade that was only one leg of a larger strategy or hedge, and cannot rule out coincidental patterns rather than material nonpublic information.
- [CLM-0168] The paper's statistical validation reports monotonically increasing win rates, significant permutation test results, and an aggregate profit of $143.0 million across 138,281 profitable (wallet, market) pairs.
- [CLM-0169] The paper concludes that the classical and misappropriation theories of securities fraud do not map cleanly onto prediction-market event contracts, and that Rule 180.1 is narrower than SEC Rule 10b-5 in critical respects.
- [CLM-0170] The paper argues for mandatory platform-level registration and surveillance obligations, contract-level rules targeting high-risk information channels, and an extended misappropriation theory for decentralized platforms.

## Limitations

The study is historical and lower-bound in nature. The screen cannot observe complete portfolio positions, multiple blockchain identifiers may fragment a trader's activity, and profitable trades may be only one leg of a larger strategy or hedge. The paper also cannot rule out coincidental patterns in place of material nonpublic information, so the screening output should be treated as anomalous behavior rather than definitive proof of liability or identity. The legal analysis is doctrinal and policy-oriented; it does not itself settle how prediction markets will be treated under current enforcement law.

## Review Checklist Coverage

- Exact sample period: February 2024 through February 2026.
- Case studies: the Maduro trade, the IDF case, the Nobel Peace Prize case, the AlphaRaccoon case, the OpenAI browser case, and the Taylor Swift / romanticpaul case.
- Composite score components: bet size anomalies, profitability, pre-event timing, and directional concentration.
- Statistical validation: monotonic win-rate patterns, permutation tests, and 138,281 profitable wallet-market pairs.
- Lower-bound framing: buy-side only, missing wallets and strategies may exist, and the screen cannot distinguish every hedge from informed trading.
- Legal analysis: classical and misappropriation theories, Rule 180.1, and the prediction-market regulatory gap.
- Policy proposals: platform registration, surveillance, contract-level rules, and an extended misappropriation theory for decentralized platforms.

## Version Selection Rationale

The local PDF artifact is complete and inspectable. The title page says "March 16, 2026" and "FIRST DRAFT – COMMENTS WELCOME," and the PDF shows no explicit external version suffix. I used the stable SSRN abstract record as the canonical source URL because the captured file is the complete paper associated with that record. The repository records `version: 1` as the first captured source-record version rather than as an external paper-version assertion.

## Relevance to Invariant

This paper is direct empirical and legal evidence on informed trading, surveillance, and prediction-market integrity. It is relevant to future execution, replay, and venue-risk modeling, but it does not establish a copy-trading strategy or a settled regulatory conclusion.

## Conflicts With Existing Knowledge

- The paper's anomaly screen is historical and lower-bound, so it should not be treated as a guarantee that all suspicious wallets are unique humans or current edge cases.
- The legal analysis is a policy argument, not a definitive statement that current enforcement doctrine has already resolved prediction markets.
- The paper's case-study evidence should not be collapsed into a general claim that every prediction-market profit reflects insider trading.

## Wiki Pages Affected

- `wiki/concepts/prediction-market-mechanics.md`
- `wiki/strategies/arbitrage-and-execution-risk.md`
- `wiki/platforms/polymarket.md`
- `wiki/platforms/kalshi.md`

## New Research Questions

- How do current fee schedules, liquidity conditions, and wallet-clustering assumptions change the anomaly screen's apparent reach?
- Which of the highlighted trading patterns survive when accounting for multi-wallet actors and off-platform activity?
- Can a deterministic surveillance pipeline reproduce the article's screening output from public market data alone?

## Review Notes

The selected artifact is the complete user-provided PDF for `SRC-0039`. It is a 97-page document whose title page and abstract support the paper identity and March 16, 2026 date. The summary separates empirical screening, case-study evidence, limitations, and legal analysis so that downstream synthesis does not turn a surveillance proposal into a trading recommendation.
