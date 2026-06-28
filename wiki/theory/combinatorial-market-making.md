---
page_id: THEORY-0001
title: Combinatorial Market Making
page_type: theory
status: reviewed
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0004
  - SRC-0005
related_pages:
  - CONCEPT-0001
  - STRATEGY-0001
tags:
  - combinatorial-market-making
  - marginal-polytope
  - frank-wolfe
  - integer-programming
---

# Combinatorial Market Making

## Purpose

Explain the reviewed theory concerning arbitrage-free combinatorial market making and its limits as guidance for live trading.

## Problem Setting

- `SRC-0005` studies markets whose valid outcomes are defined by integer programs rather than by explicit enumeration. [CLM-0025] [CLM-0028]
- The paper asks how to build an arbitrage-free market maker and whether projection-based optimization can make that feasible. [CLM-0024] [CLM-0027] [CLM-0031]

## Securities and Feasible Payoff Vectors

- Feasible payoff vectors are the valid payoff assignments the market can represent.
- `SRC-0005` formalizes them with a compact integer-program representation instead of enumerating every outcome. [CLM-0025]

## Marginal Polytope

- The marginal polytope is the convex hull of valid payoff vectors, and coherent prices are exactly the expectation vectors over outcome distributions. [CLM-0024]
- Repository synthesis: this is the market-maker coherence region, not a venue-specific order-book shape.

## No-Arbitrage Condition

- Prices outside the marginal polytope admit arbitrage in the theory’s model. [CLM-0024] [CLM-0026]
- The no-arbitrage condition is therefore a feasibility constraint on prices, not a claim about live execution quality.

## Integer-Program Representation

- `SRC-0005` shows how valid payoff vectors can be represented by compact integer-program constraints. [CLM-0025]
- This is the structural reason the theory can avoid explicit outcome enumeration.

## Separation and Optimization Oracles

- The Frank-Wolfe reduction needs repeated linear optimization over the valid payoff set.
- In the paper, that optimization is implemented with an IP solver. [CLM-0027] [CLM-0028]

## Bregman Projection

- Proposition 2.4 ties guaranteed arbitrage profit to the Bregman divergence between the current state and the projected point. [CLM-0026]
- Repository synthesis: this is a theoretical profit-bound result under the paper’s assumptions, not a standalone trade-sizing algorithm.

## Profit-Bound Interpretation

- The paper shows that moving to the projected point achieves the profit bound in its model. [CLM-0026]
- It does not thereby prove that every projection in a live venue is instantly executable at that size.

## Frank-Wolfe Optimization

- Fully corrective Frank-Wolfe turns the projection problem into repeated linear optimization over the valid set. [CLM-0027]
- The paper reports convergence of the duality gap to zero under the controlled-growth framework. [CLM-0031]

## Boundary Differentiability Issue

- LMSR has a boundary issue because the relevant divergence can become badly behaved near the feasible-region boundary. [CLM-0029]
- This is a theoretical issue, not a venue-specific implementation quirk.

## Controlled-Growth Condition

- `SRC-0005` requires a differentiable extension with controlled growth so the projection proof goes through. [CLM-0029] [CLM-0031]

## Contracted-Polytope Method

- The paper handles the boundary issue by contracting the feasible region around an interior coherent point. [CLM-0030]
- This treatment is part of the proof/algorithmic framework, not an undocumented heuristic.

## Experimental Setting

- The empirical evaluation replays NCAA tournament trades with Gurobi 5.53. [CLM-0028] [CLM-0033] [CLM-0034]
- The replay is a counterfactual experiment, not a live market deployment.

## What the Theory Establishes

- Coherent prices lie in the marginal polytope. [CLM-0024]
- Projection can be reduced to optimization over the valid set. [CLM-0027]
- Controlled-growth and contraction let the proof handle the boundary region. [CLM-0029] [CLM-0030] [CLM-0031]

## What the Theory Does Not Establish

- It does not establish production latency.
- It does not establish fee-adjusted execution quality.
- It does not establish live fill probability.
- It does not establish that the projection output is a complete executable order-sizing rule in a venue.

## Practitioner Interpretation

- `SRC-0004` reads this theory as an executable roadmap for Polymarket. That is a practitioner interpretation, not the theorem itself. [CLM-0015] [CLM-0016]
- The article’s iteration-count and pricing-improvement claims are reported by the article, not guaranteed by `SRC-0005`. [CLM-0021] [CLM-0022]

## Production Feasibility Gaps

- Live trading still has to contend with depth, fees, slippage, and multi-leg execution risk.
- `SRC-0005` does not model those operational constraints as production guarantees.

## Open Questions

- Can the IP oracle be replaced without losing the no-arbitrage guarantee?
- How much of the contraction step is algorithmic necessity versus proof convenience?
- What would it take to translate this projection framework into a live venue without overstating executability?

## Related Pages

- [Market Relationship Taxonomy](../concepts/market-relationship-taxonomy.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)

## Sources and Claims

- `SRC-0005`: [CLM-0024], [CLM-0025], [CLM-0026], [CLM-0027], [CLM-0028], [CLM-0029], [CLM-0030], [CLM-0031], [CLM-0032], [CLM-0033], [CLM-0034]
- `SRC-0004` practitioner interpretation only: [CLM-0015], [CLM-0016], [CLM-0021], [CLM-0022], [CLM-0023]
