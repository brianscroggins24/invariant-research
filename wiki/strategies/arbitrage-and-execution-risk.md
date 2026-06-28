---
page_id: STRATEGY-0001
title: Arbitrage and Execution Risk
page_type: strategy
status: reviewed
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0003
  - SRC-0004
  - SRC-0005
  - SRC-0009
  - SRC-0010
  - SRC-0014
  - SRC-0016
  - SRC-0031
  - SRC-0032
related_pages:
  - CONCEPT-0001
  - CONCEPT-0002
  - CONCEPT-0003
  - THEORY-0001
  - PLATFORM-0001
  - PLATFORM-0002
tags:
  - arbitrage
  - execution-risk
  - slippage
  - multi-leg
---

# Arbitrage and Execution Risk

## Purpose

Connect logical and mathematical arbitrage conditions to the operational requirements for executable, fee-adjusted profit.

## Theoretical Arbitrage

- `SRC-0003` defines Market Rebalancing Arbitrage and Combinatorial Arbitrage as logical-price inconsistencies. [CLM-0005] [CLM-0006]
- `SRC-0005` provides the coherent-price and projection framework that explains why those inconsistencies matter. [CLM-0024] [CLM-0026] [CLM-0027]

## Logical Arbitrage

- Logical arbitrage is a statement about the payoff structure, not about whether a real order can fill.
- `SRC-0003` shows that logical structure alone still leaves room for non-atomic execution risk. [CLM-0013]

## Market-Rebalancing Arbitrage

- Within a single market or condition, `SRC-0003` identifies long opportunities when summed YES prices are below one and short opportunities when they are above one. [CLM-0005]
- This is a structured relationship result, not a claim that a specific venue quote is immediately executable.

## Combinatorial Arbitrage

- Across dependent markets, `SRC-0003` defines combinatorial arbitrage as a portfolio that guarantees at least one winning payoff and satisfies the market-value inequality. [CLM-0006]
- `SRC-0005` gives the coherent-price geometry behind that notion. [CLM-0024] [CLM-0026]

## Guaranteed Payoff Versus Executable Opportunity

- A guaranteed payoff in the abstract can still be unexecutable at a profitable size once depth, fees, and slippage are applied.
- `SRC-0004` treats this as the central operational issue, but that article’s sizing advice is practitioner interpretation rather than primary theory. [CLM-0015] [CLM-0019] [CLM-0023]

## Position Sizing

- `SRC-0004` argues that Bregman projection identifies trading direction and sizing information. That is a roadmap claim, not a theorem stated by `SRC-0005`. [CLM-0015] [CLM-0026]
- Execution-aware sizing must remain separate from mathematical feasibility.

## Order-Book Depth

- Depth limits how much of an apparent edge can actually be traded.
- Polymarket and Kalshi both expose level-wise order-book structure that can be consumed only up to available size. [CLM-0053] [CLM-0067] [CLM-0068] [CLM-0088] [CLM-0089]

## Slippage

- Slippage turns a quoted edge into a smaller realized edge.
- `SRC-0004` uses VWAP language to approximate that effect, but the reviewed sources do not establish a universal formula. [CLM-0023]

## Fees

- Fee treatment matters even when the logical edge is real.
- `SRC-0003` reports extracted profit under a no-per-executed-trade-fee assumption in the analyzed setting. [CLM-0010]
- `SRC-0004` and `SRC-0032` show venue-specific fee logic that must be applied separately. [CLM-0020] [CLM-0114]

## Partial Fills

- Partial fills can leave a strategy exposed even when part of it executed successfully.
- Polymarket and Kalshi both expose order-response fields that can reveal partial execution: Polymarket exposes state that can indicate partial execution, while Kalshi exposes `fill_count` and `remaining_count`. [CLM-0057] [CLM-0096]
- Dedicated Kalshi fill-history payload semantics were outside the approved Phase 2 documentation set.

## Multi-Leg Execution

- Multi-leg execution is the core operational difficulty in combinatorial and cross-market arbitrage.
- `SRC-0003` explicitly warns that different legs can succeed or fail independently. [CLM-0013]
- `SRC-0004` turns that warning into a trading roadmap, but the roadmap is not itself operational proof.

## Failed-Leg Risk

- If one leg fails, the trader may be left with directional exposure instead of a neutral arbitrage.
- This risk is visible in both the primary paper and the practitioner article. [CLM-0013] [CLM-0023]

## Atomic Settlement Versus Atomic Strategy Execution

- Polymarket documents atomic settlement of an individual matched trade. [CLM-0054]
- That does not imply atomic execution across multiple independently submitted orders or arbitrage legs. [CLM-0054]
- Kalshi’s settlement and lifecycle docs likewise do not establish multi-leg atomicity. [CLM-0113] [CLM-0111]

## Empirical Findings

- `SRC-0003` reports total extracted profit of $39,587,585.02 and a top-account total of $2,009,631.76. [CLM-0010]
- `SRC-0004` reports total extracted profit of $39,688,585 and a rounded top-single-extractor profit of $2,009,632. [CLM-0020]
- The discrepancy must remain visible; the two sources are not identical.

## Practitioner Recommendations

- `SRC-0004` recommends a modified Kelly-style sizing rule, a cap at 50% of order-book depth, and monitoring alerts for drawdown, solver timeouts, and fill failures. [CLM-0019]
- These are recommendations, not validated production architecture.

## Unsupported Practitioner Assertions

- Same-block execution.
- Direct-RPC or mempool-latency advantages.
- Specific execution-success rates.
- Specific capital requirements.
- Specific latency windows.
- Exact number of Frank-Wolfe iterations as a guaranteed operational property.
- These claims remain unsupported unless corroborated by other reviewed evidence. [CLM-0021] [CLM-0022] [CLM-0033] [CLM-0034]

## Risk Controls Suggested by the Evidence

- Respect executable depth rather than quoted spread alone.
- Apply fees before deciding a trade is profitable.
- Separate signal generation from execution authorization.
- Monitor partial fills and failed legs explicitly.
- Treat the logical-arbitrage signal as a candidate, not as a completed trade.

## Open Questions

- What fill-probability model is appropriate for venue-local depth?
- How should fee-adjusted profit be computed for partially filled multi-leg trades?
- What deterministic rules can safely replace the heuristic parts of the dependency pipeline?

## Related Pages

- [Market Relationship Taxonomy](../concepts/market-relationship-taxonomy.md)
- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Combinatorial Market Making](../theory/combinatorial-market-making.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0003`: [CLM-0005], [CLM-0006], [CLM-0009], [CLM-0010], [CLM-0011], [CLM-0012], [CLM-0013]
- `SRC-0004` practitioner interpretation only: [CLM-0014], [CLM-0015], [CLM-0016], [CLM-0017], [CLM-0018], [CLM-0019], [CLM-0020], [CLM-0021], [CLM-0022], [CLM-0023]
- `SRC-0005`: [CLM-0024], [CLM-0026], [CLM-0027], [CLM-0031], [CLM-0033], [CLM-0034]
- `SRC-0008`, `SRC-0009`, `SRC-0010`, `SRC-0031`, `SRC-0032`: [CLM-0053], [CLM-0054], [CLM-0057], [CLM-0111], [CLM-0113], [CLM-0114]
