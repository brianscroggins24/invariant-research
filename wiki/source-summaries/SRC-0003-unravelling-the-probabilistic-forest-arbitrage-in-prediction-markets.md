---
page_id: SOURCE-SUMMARY-0002
title: "Unravelling the Probabilistic Forest: Arbitrage in Prediction Markets"
page_type: source-summary
status: reviewed
created_at: 2026-06-23
updated_at: 2026-06-23
source_id: SRC-0003
sources:
  - SRC-0003
related_pages: []
tags:
  - prediction-markets
  - arbitrage
  - polymarket
  - llm-methodology
---

# Source Summary

## Citation

Saguillo, Oriol, Vahid Ghafouri, Lucianna Kiffer, and Guillermo Suarez-Tangil. "Unravelling the Probabilistic Forest: Arbitrage in Prediction Markets." arXiv, August 5, 2025. Source ID: `SRC-0003`.

## Source Type

Research paper. The authors study arbitrage in Polymarket and use LLM-assisted dependency detection to analyze market conditions.

## Purpose or Research Question

The paper asks what conditions give rise to arbitrage, whether arbitrage occurs on Polymarket, and whether users exploit those opportunities.

## Methodology

The authors combine historical Polymarket order and bid data with heuristic filtering, LLM-based single-market inference, and LLM-based multi-market dependency checks. They reduce large markets before prompting, assign topics with embedding similarity, restrict cross-market checks to shared topic and end date, and validate candidate dependencies with structural checks and manual review.

## Data or Evidence Used

The study uses on-chain historical order-book and bid data from Polymarket, covering markets resolved between April 1, 2024 and April 1, 2025. The strategy section also summarizes 86 million bids.

## Main Findings

- The paper defines Market Rebalancing Arbitrage within a single market or condition and Combinatorial Arbitrage across dependent markets.
- The authors identify many within-condition opportunities and fewer cross-market opportunities.
- In the U.S. election subset, they find dependent market pairs and confirm a small set that satisfies strict combinatorial arbitrage.
- They estimate roughly $39.6M of profit extracted across both arbitrage types, using an epsilon of $1 profit per trade.
- They note that ambiguous market wording, LLM reasoning loops, and non-atomic execution risk create false positives and unresolved cases.

## Important Claims

- Section 3.2.1 defines Market Rebalancing Arbitrage as a long opportunity when the sum of YES prices across the conditions is below 1, or a short opportunity when the sum exceeds 1.
- Section 3.2.2 defines Combinatorial Arbitrage as a portfolio across dependent markets that guarantees at least one winning bet and is profitable because of the market-value inequality in Definition 4.
- Section 5.1-5.2 describes the LLM-based inference pipeline, the topic-assignment step, and the preprocessing used to reduce prompt size for larger markets.
- Section 6.1 reports that 7,051 of 17.2K conditions had at least one arbitrage opportunity under the authors' thresholds.
- Section 7.4 reports total extracted profit of $39,587,585.02 and a top-account total of $2,009,631.76, assuming ε = $1 profit per trade.

## Limitations

The authors report LLM reasoning loops, invalid JSON outputs, false positives from ambiguous market wording, weaker dependency cases that are left for future work, and non-atomic execution risk because the relevant order legs can fail independently. The paper excludes fees from profit calculations because it states Polymarket did not charge a per-executed-trade fee in the analyzed setting.

## Relevance to Invariant

This paper is a useful case study for market-structure inference, arbitrage detection, and LLM-assisted dependency analysis. It is evidence about a concrete prediction-market workflow, not production configuration or a trading authorization.

## Conflicts With Existing Knowledge

- The paper shows that dependency detection is noisy and sensitive to wording, so naive automation would overstate certainty.
- It suggests that cross-market arbitrage requires careful structural checking and manual review.
- The extracted opportunities are not directly equivalent to deployable trading strategy.

## Wiki Pages Affected

- None yet. This ingestion step intentionally avoids synthesis, concept, platform, or strategy pages.

## New Research Questions

- Can similar dependency detection work reliably on thinner-liquidity markets?
- How much of the extracted profit remains after fees, slippage, and execution risk?
- What deterministic rule layer could replace parts of the LLM dependency check?

## Review Notes

This draft keeps the paper's empirical claims separate from Invariant interpretation. The summary and claims remain review-required until capture, hashing, registry, and file-reference validation are complete.
