---
page_id: SOURCE-SUMMARY-0004
title: Arbitrage-Free Combinatorial Market Making via Integer Programming
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0005
sources:
  - SRC-0005
related_pages:
  - SOURCE-SUMMARY-0003
tags:
  - combinatorial-market-making
  - marginal-polytope
  - frank-wolfe
  - integer-programming
  - prediction-markets
  - ncaa
---

# Source Summary

## Citation

Kroer, Christian, Miroslav Dudík, Sébastien Lahaie, and Sivaraman Balakrishnan. "Arbitrage-Free Combinatorial Market Making via Integer Programming." arXiv, June 10, 2016. Source ID: `SRC-0005`. Canonical PDF: `https://arxiv.org/pdf/1606.02825.pdf`.

## Source Type

Research paper. The authors present a combinatorial market maker that removes arbitrage by projecting prices onto a marginal polytope, and they evaluate the method on an NCAA tournament replay.

## Purpose or Research Question

The paper asks how to build an arbitrage-free combinatorial market maker for outcome spaces defined by integer programs, and whether Bregman projection plus Frank-Wolfe-style optimization can make that projection computationally tractable.

## Methodology

The paper develops the market-maker theory, proves the profit/projection correspondence, then turns Bregman projection into a sequence of linear optimization problems over the valid payoff vertices. For the empirical section, it replays trades from Predictalot on an NCAA tournament market and compares independent pricing, linearly constrained pricing, and the Frank-Wolfe market maker.

## Data or Evidence Used

The evidence is primarily mathematical: convex conjugacy, Bregman divergence, Frank-Wolfe convergence arguments, and an integer-program representation of valid outcomes. The empirical evidence comes from a counterfactual replay of NCAA tournament trades using a Java implementation with Gurobi 5.53.

## Main Findings

- The marginal polytope is the convex hull of valid payoff vectors, and coherent prices are exactly the prices that lie in that polytope.
- The Bregman projection of a market state onto the marginal polytope identifies the best guaranteed arbitrage profit under the paper's assumptions.
- Frank-Wolfe reduces the projection problem to repeated linear optimization over valid payoff vertices, which the implementation solves with an IP oracle.
- Controlled-growth assumptions and contraction near the boundary are required because the gradient can become unbounded as the boundary is approached.
- In the NCAA replay, FWMM improves forecast accuracy over LCMM once enough games are settled for projection to finish within the time budget.

## Important Claims

- [CLM-0024] The marginal polytope is the convex hull of valid payoff vectors, and coherent prices are exactly the expectation vectors over outcome distributions.
- [CLM-0025] The paper represents valid payoff vectors with compact integer-program constraints instead of explicit outcome enumeration.
- [CLM-0026] Proposition 2.4 ties guaranteed arbitrage profit to the Bregman divergence from the current state to the projected point.
- [CLM-0027] Frank-Wolfe turns Bregman projection into repeated linear optimization over Z.
- [CLM-0028] The linear-optimization oracle is an IP solver, and the experiments use Gurobi Optimizer 5.53.
- [CLM-0029] The paper requires a differentiable extension with controlled growth; LMSR satisfies the condition with L_ε = O(1/ε).
- [CLM-0030] The paper uses a contracted polytope and an interior point to handle the boundary issue.
- [CLM-0031] The adaptive Frank-Wolfe analysis shows convergence of the duality gap to zero.
- [CLM-0032] The NCAA tournament evaluation uses a combinatorial market with an outcome space of size 2^63.
- [CLM-0033] The paper reports first feasible projection only after 45 games are settled, with about 5 hours to replay trades under a 30-minute per-projection cap.
- [CLM-0034] FWMM improves accuracy over LCMM, with a 38% median improvement for variables once projections succeed.

## Limitations

The IPs are NP-hard in general, and the paper explicitly warns that projection can stall on brute-force search. The method depends on a differentiable extension with controlled growth and on a contraction heuristic near the boundary. The empirical evaluation is a counterfactual replay on one tournament dataset, not a live production market.

## Relevance to Invariant

This paper is a primary theoretical source for arbitrage-free combinatorial market-making logic, the marginal-polytope formulation, and the use of IP-backed oracles inside a convex projection loop. It is relevant to deterministic reasoning about coherent price vectors and no-arbitrage constraints, but it is not production configuration for `invariant-engine`.

## Conflicts With Existing Knowledge

- `SRC-0004`'s presentation that Bregman projection directly yields executable sizing is stronger than this paper. The paper proves a profit bound and shows that a trade moving to the projection point achieves it, but it does not provide a standalone sizing rule.
- `SRC-0004`'s `38%` figure is only supported here as a median improvement in variable accuracy after projections succeed, not as a general deployment metric.
- `SRC-0004`'s `50-150` iteration claim is not confirmed here; this paper instead reports a 30-minute projection limit and the first successful projection after 45 games settle.
- `SRC-0004`'s production-system framing and 2024-2025 Polymarket references are not evaluated by this paper.
- `SRC-0004`'s `2^63` shorthand is directly supported by this paper's NCAA tournament evaluation description.

## Wiki Pages Affected

- [The Math Needed for Trading on Polymarket (Complete Roadmap)](wiki/source-summaries/SRC-0004-the-math-needed-for-trading-on-polymarket.md) should keep its theory attributions qualified against this primary paper.

## New Research Questions

- Can the IP oracle be replaced with a faster exact or approximate oracle without losing the no-arbitrage guarantee?
- How much of the contraction heuristic is an algorithmic necessity versus an artifact of the chosen proof technique?
- Does the projection-based market maker remain practical under modern live-market latency constraints?
- Which parts of the workflow could be expressed deterministically inside `invariant-engine`?

## Review Notes

This summary keeps the theoretical results, the empirical NCAA replay, and the limitations separate. Where `SRC-0004` goes beyond the paper, the discrepancy is called out explicitly rather than silently reconciled.
