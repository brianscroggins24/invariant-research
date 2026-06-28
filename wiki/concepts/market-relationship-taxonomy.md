---
page_id: CONCEPT-0001
title: Market Relationship Taxonomy
page_type: concept
status: reviewed
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0003
  - SRC-0004
  - SRC-0005
  - SRC-0007
  - SRC-0008
  - SRC-0019
  - SRC-0020
  - SRC-0021
related_pages:
  - CONCEPT-0002
  - CONCEPT-0003
  - THEORY-0001
  - STRATEGY-0001
  - PLATFORM-0001
  - PLATFORM-0002
tags:
  - prediction-markets
  - taxonomy
  - arbitrage
  - relationship-model
---

# Market Relationship Taxonomy

## Purpose

Define the logical relationships that may exist among prediction-market propositions, outcomes, markets, conditions, and contracts. This is a synthesis page: it combines reviewed evidence, but it does not introduce a venue-neutral ontology that erases platform differences.

## Scope and Terminology

- `SRC-0003` frames arbitrage discovery as a dependency problem over conditions and related markets, not as a simple single-market price check. [CLM-0005] [CLM-0006] [CLM-0011] [CLM-0012]
- `SRC-0005` formalizes feasible payoff vectors and the marginal polytope for outcome spaces defined by integer programs. [CLM-0024] [CLM-0025]
- `SRC-0007` through `SRC-0021` show that Polymarket and Kalshi do not use the same entity vocabulary. Polymarket speaks in terms of markets, conditions, and outcome tokens; Kalshi uses series, events, and markets. [CLM-0045] [CLM-0046] [CLM-0048] [CLM-0049] [CLM-0080] [CLM-0082] [CLM-0085]
- `SRC-0004` reuses these ideas as practitioner interpretation. It is useful context, but it is not primary evidence for the underlying theory. [CLM-0014] [CLM-0015] [CLM-0016] [CLM-0021] [CLM-0022] [CLM-0023]

## Propositions, Outcomes, Markets, and Contracts

- A proposition is the truth-bearing statement under analysis.
- An outcome is a realized truth assignment or payout-relevant state.
- A market is the venue-local tradable wrapper around one or more propositions.
- A contract is the venue-local instrument or token representation used to carry exposure.
- Repository synthesis: the same logical proposition can map to different venue-specific objects, so the taxonomy must be relationship-first rather than identifier-first.

## Implication

- `A implies B` means `A` being true requires `B` to be true.
- Implication creates price constraints, but it does not imply a profit opportunity by itself. `SRC-0003` shows that dependency checks become useful because implication-like structure can create arbitrage candidates. [CLM-0005] [CLM-0006] [CLM-0011] [CLM-0013]
- A one-way implication is weaker than equivalence.

## Equivalence

- Two propositions are equivalent only when each implies the other.
- Equivalence is stronger than implication and should be treated as a tighter logical constraint on price and payout relationships.
- `SRC-0005` supports this framing indirectly by showing that coherent prices must lie in the marginal polytope of feasible payoff vectors. [CLM-0024] [CLM-0026]

## Mutual Exclusivity

- Mutual exclusivity means at most one proposition in a set can be true.
- It differs from independence: exclusive propositions are linked by structure, while independent propositions are not.
- Mutual exclusivity must be established from the underlying propositions and resolution rules. Markets appearing under the same event or grouping are not automatically mutually exclusive.

## Complement Relationships

- A complement relationship means one side becoming true forces the other side to be false, typically with payoff symmetry.
- Complementarity is stronger than mere exclusivity because it pins down the full binary outcome pair.
- Polymarket’s YES/NO outcome tokens and Kalshi’s YES/NO contracts are venue-local expressions of this relationship, but they are not the same object model. [CLM-0048] [CLM-0049] [CLM-0050] [CLM-0085] [CLM-0086]

## Subset and Superset Relationships

- If one proposition is a subset of another, then the smaller proposition can only be true when the larger proposition is true.
- Subset relationships create price constraints because they restrict the feasible payoff region.
- `SRC-0005` provides the theoretical language for these constraints through valid payoff vectors and the marginal polytope. [CLM-0024] [CLM-0025]

## Conditional Relationships

- Conditional relationships depend on another proposition, event state, or market grouping.
- `SRC-0003` uses topic and end-date filtering as a heuristic prefilter before testing cross-market dependencies. [CLM-0012]
- Repository synthesis: conditional relationships are useful candidate generators, but they need deterministic validation before they are treated as live constraints.

## Candidate-Pair Generation

- `SRC-0003` reduces dependency search by topic embedding, shared topic, and shared end date. [CLM-0012]
- `SRC-0004` repeats that dependency-search framing as practitioner guidance, but the article’s roadmap language should not be promoted to primary evidence. [CLM-0014] [CLM-0016]
- Candidate generation is therefore a heuristic stage, not a conclusion stage.

## Deterministic Validation

- `SRC-0003` pairs heuristic screening with structural checks and manual review. [CLM-0012] [CLM-0013]
- `SRC-0005` shows why deterministic validation matters: feasible payoff vectors are constrained by a compact integer-program representation rather than by ad hoc reasoning. [CLM-0025] [CLM-0027]
- Repository synthesis: final acceptance should be evidence-based and deterministic, not purely LLM-driven.

## Relationship Confidence and Uncertainty

- High confidence: supported by primary paper theory or explicit official documentation.
- Medium confidence: supported by practitioner interpretation that is consistent with the primary sources, but not itself primary evidence.
- Low confidence: heuristic candidate relationships that need deterministic validation.
- Open: any relationship that depends on mutable venue behavior, undocumented fill rules, or untested platform assumptions.

## Relationship Versus Arbitrage

- A logical relationship does not establish executable profit.
- `SRC-0003` shows that arbitrage candidates can arise from relationship structure, but execution risk, depth, and fees still matter. [CLM-0005] [CLM-0006] [CLM-0013]
- `SRC-0005` shows that coherent prices are a feasibility property of the market-maker model, not a guarantee that a trading plan is executable in a live venue. [CLM-0024] [CLM-0026] [CLM-0031]

## Platform Terminology Caveats

- Polymarket terms: market, condition, outcome token, YES/NO, CLOB. [CLM-0045] [CLM-0046] [CLM-0048] [CLM-0051]
- Kalshi terms: series, event, market, YES/NO contract, fixed-point fields, fee and rate-limit metadata. [CLM-0080] [CLM-0082] [CLM-0085] [CLM-0086]
- Kalshi's event schema includes an explicit `mutually_exclusive` flag, so exclusivity can be stated directly by the venue. [CLM-0084]
- Do not collapse these into a single universal vocabulary.

## Open Questions

- How should scalar Kalshi markets be represented in a taxonomy that also needs binary-only examples? [CLM-0085]
- Can candidate generation be made deterministic enough to reduce manual review without overfitting venue-specific terminology?
- What relation classes are stable enough to move from synthesis into deterministic engine rules?

## Related Pages

- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Combinatorial Market Making](../theory/combinatorial-market-making.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0003`: [CLM-0005], [CLM-0006], [CLM-0011], [CLM-0012], [CLM-0013]
- `SRC-0004` practitioner interpretation only: [CLM-0014], [CLM-0015], [CLM-0016], [CLM-0021], [CLM-0022], [CLM-0023]
- `SRC-0005`: [CLM-0024], [CLM-0025], [CLM-0026], [CLM-0027], [CLM-0031]
- `SRC-0007` through `SRC-0021`: [CLM-0045], [CLM-0046], [CLM-0048], [CLM-0049], [CLM-0050], [CLM-0051], [CLM-0080], [CLM-0082], [CLM-0084], [CLM-0085], [CLM-0086]
