---
page_id: SOURCE-SUMMARY-0003
title: The Math Needed for Trading on Polymarket (Complete Roadmap)
page_type: source-summary
status: reviewed
created_at: 2026-06-25
updated_at: 2026-06-25
source_id: SRC-0004
sources:
  - SRC-0004
related_pages:
  - SOURCE-SUMMARY-0002
tags:
  - prediction-markets
  - arbitrage
  - polymarket
  - practitioner-commentary
---

# Source Summary

## Citation

Roan (@RohOnChain). "The Math Needed for Trading on Polymarket (Complete Roadmap)." X Article, January 30, 2026. Source ID: `SRC-0004`. Canonical URL: `https://x.com/RohOnChain/article/2017314080395296995`.

## Source Type

Secondary practitioner commentary. The author presents the article as a roadmap for trading on Polymarket and uses the primary research paper as the main evidentiary base, but the piece also adds the author's own engineering interpretation and recommendations.

## Source Purpose and Scope

The article asks what mathematics, optimization methods, and execution controls are needed to trade Polymarket profitably. It is framed as a practical roadmap rather than a primary empirical study.

## Relationship to `SRC-0003`

This article is a practitioner-facing explanation built around `SRC-0003`. It reuses empirical Polymarket findings from that paper, separately cites `Arbitrage-Free Combinatorial Market Making via Integer Programming` for the marginal-polytope, Bregman-projection, and Frank-Wolfe theory, and then adds the author's own roadmap and recommendations. Candidate-reduction methods such as topic embeddings and same-topic/end-date filtering belong to `SRC-0003` and are not stated in this article.

## Theoretical Attribution

The article's marginal-polytope, Bregman-projection, and Frank-Wolfe discussion should be treated as theory attributed to the separately cited combinatorial-market-making paper. It is not corroborated here by `SRC-0003` and should remain unverified against that cited theoretical paper until checked directly.

## Marginal Polytopes and Logical Consistency

The article explains that arbitrage detection over dependent markets is a logical-consistency problem: valid prices must live inside the marginal polytope, and naive pairwise checks explode exponentially as condition spaces grow. It uses the 17,218-condition search space and the 1,576 dependent pairs figure to motivate that scaling problem.

## Integer-Programming Representation

The article says the valid set can be expressed with linear constraints and uses the Duke/Cornell example to show how integer programming compresses a large outcome space into a few constraints. It treats this representation as the core computational trick for dependency detection.

## Bregman Projection

The article argues that the Bregman projection of the current state onto the marginal polytope yields the optimal arbitrage trade. It also says the projection identifies the trading direction, the maximum guaranteed profit, and the relevant position sizing information.

## Frank-Wolfe and Integer-Programming Oracles

The article presents Frank-Wolfe with an integer-programming oracle as the tractable way to compute projections and reports Gurobi solve times that depend on how much of the tournament has settled. It also reports convergence in roughly 50 to 150 iterations and claims a 38% security-pricing improvement. Those performance figures are article-reported, not independently verified here.

## Non-Atomic Execution

The article says Polymarket CLOB execution is sequential rather than atomic, so one leg can fill while another fails and leave the trader exposed. It uses the $0.05 profit threshold to justify filtering out edges that are too small to survive execution risk.

## VWAP, Liquidity, and Slippage

The article says expected fill prices should be estimated with VWAP rather than quoted prices and that liquidity depth caps the profit available from any opportunity. It uses order-book examples to argue that slippage can erase the apparent edge even when a spread looks favorable on paper.

## Proposed System Architecture

The article proposes a three-layer workflow: pairwise dependency analysis with DeepSeek-R1-Distill-Qwen-32B, integer-programming projection for candidate trades, and execution validation against the live order book. It also describes the data pipeline as WebSocket feeds plus historical Polygon/Alchemy analysis.

## Proposed Risk and Monitoring Controls

The article proposes a modified Kelly-style sizing rule, a cap of 50% of order-book depth, and dashboard alerts for drawdown, solver timeouts, and fill failures. These are presented as operational controls rather than measured findings.

## Corroborated Statements

- The article's discussion of non-atomic execution, VWAP, liquidity, and a minimum-profit threshold is broadly consistent with the execution framing recorded in `SRC-0003`.
- The article's fee treatment matches the primary paper's statement that Polymarket did not charge a per-executed-trade fee in the analyzed setting.
- The article's candidate-count figures are article-reported outputs from its own workflow, not additional `SRC-0003` evidence.

## Discrepancies With Primary Sources

- The article reports total extracted profit of $39,688,585, while `SRC-0003` records $39,587,585.02; the difference is approximately $101,000 and cannot be explained by rounding.
- The article rounds the top single extractor's profit to $2,009,632, while `SRC-0003` records $2,009,631.76.
- Several performance and execution claims in the article are stronger than the primary evidence in `SRC-0003`.
- The article's monitoring and sizing recommendations are not independently verified platform facts.

## Unsupported or Weakly Sourced Assertions

- Scanning `2^63` outcomes in milliseconds.
- Specific Gurobi solve times.
- Specific Frank-Wolfe iteration counts.
- 38% pricing improvement.
- 87% execution success.
- 45% combinatorial execution success.
- Percentages assigned to execution-failure causes.
- Retail and sophisticated-system latency figures.
- Same-block execution eliminating sequential risk.
- `$500K+` capital attributed to the top trader.
- The modified Kelly sizing formula.
- The 50% order-book-depth cap.
- The monitoring thresholds.
- The average profit-per-trade conclusion.
- The exact aggregate figure of `$39,688,585`.
- The claim that Bregman projection directly determines executable position sizing, expected profit, and trading direction.

## Potential Relevance to `invariant-engine`

The article suggests a candidate workflow for dependency detection, deterministic sizing, and execution validation that could inform future `invariant-engine` work. It is useful as a roadmap, but not as production configuration.

## Open Verification Questions

- Which of the operational numbers can be corroborated directly from the primary paper or raw on-chain data?
- Can the dependency pipeline be reproduced without the embedding-based prefilter?
- How much profit remains after conservative assumptions for fill, slippage, and fees?
- Which parts of the proposed workflow are portable to `invariant-engine`?

## Review Notes

This page keeps the article's direct statements separate from Invariant interpretation. Claims that rest on engineering recommendations remain `review-required` until corroborated against the primary source or other captured evidence.
