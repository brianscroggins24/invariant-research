# Phase 3 Architecture-Impact Assessment

## Purpose

Translate the reviewed Phase 2 research base into implementation constraints for `invariant-engine` Phase 3. This is not an implementation plan, code spec, or production configuration. It is a synthesis of what the reviewed evidence permits and what it does not.

## Source Basis

Reviewed source-layer evidence:

- `SRC-0035` through `SRC-0039`

Reviewed synthesis pages:

- `CONCEPT-0001` `Market Relationship Taxonomy`
- `CONCEPT-0002` `Prediction Market Mechanics`
- `CONCEPT-0003` `Resolution and Settlement`
- `CONCEPT-0004` `Market Accuracy and Price Discovery`
- `CONCEPT-0005` `Informed Trading and Surveillance`
- `THEORY-0001` `Combinatorial Market Making`
- `STRATEGY-0001` `Arbitrage and Execution Risk`
- `STRATEGY-0002` `Liquidity Provision and Execution Quality`
- `PLATFORM-0001` `Polymarket`
- `PLATFORM-0002` `Kalshi`

## Executive Summary

Phase 3 should treat prediction-market opportunities as venue-local, depth-limited, fee-sensitive, and identity-uncertain. The reviewed evidence does not support a single universal execution rule, a venue-neutral settlement model, or a direct mapping from account-level statistics to stable human traders. The engine therefore keeps candidate generation and read-only diagnostics separate from any future execution architecture, which is out of scope for Phase 3.

The biggest architectural implications are:

- logical relationships are only candidates until deterministic validation passes;
- quoted prices are not executable prices;
- partial fills and failed legs must be first-class states;
- Polymarket and Kalshi require different wire models;
- market accuracy, trading skill, and profitability must remain separate signals;
- anomalous trading signals are surveillance inputs, not legal findings.

## Recommendation: Candidate Generation Must Remain Separate From Execution Authorization

**Classification:** Phase 3 required

**Reasoning:** The reviewed papers and synthesis pages distinguish logical relationships, arbitrage candidates, and executable opportunities. `SRC-0035`, `SRC-0036`, `SRC-0037`, `SRC-0038`, `CONCEPT-0001`, `STRATEGY-0001`, and `THEORY-0001` all show that a mathematically or statistically interesting signal is not yet an order plan.

**Supporting research:** `SRC-0035` through `SRC-0039`; `CONCEPT-0001`; `STRATEGY-0001`; `THEORY-0001`.

**Implementation implication:** Phase 3 should keep candidate generation, validation, sizing, and order authorization as distinct stages with explicit handoffs and provenance.

**Boundary / non-goal:** This does not authorize a universal arbitrage executor or a one-step projection-to-order-size shortcut.

## Recommendation: Venue-Specific Adapters And Wire Models Are Required

**Classification:** Phase 3 required

**Reasoning:** Polymarket and Kalshi expose different entity models, book representations, lifecycle semantics, and authentication / transport details. `CONCEPT-0002`, `PLATFORM-0001`, and `PLATFORM-0002` make clear that venue-local semantics are not interchangeable.

**Supporting research:** `CONCEPT-0002`; `PLATFORM-0001`; `PLATFORM-0002`; `STRATEGY-0002`.

**Implementation implication:** Phase 3 should implement venue-specific adapters and preserve venue-local fields rather than collapsing both venues into a single normalized wire model.

**Boundary / non-goal:** This does not justify a venue-neutral ontology that erases Polymarket condition-token semantics or Kalshi series/event/market semantics.

## Recommendation: Executable Price, Depth, Fees, And Partial Fills Must Be First-Class

**Classification:** Phase 3 required

**Reasoning:** The reviewed evidence repeatedly shows that quoted prices, midpoint values, and theoretical profit do not equal executable performance. `CONCEPT-0002`, `STRATEGY-0001`, `STRATEGY-0002`, `PLATFORM-0001`, and `PLATFORM-0002` all require the engine to reason about depth, fees, fill fragmentation, and residual exposure.

**Supporting research:** `CONCEPT-0002`; `STRATEGY-0001`; `STRATEGY-0002`; `PLATFORM-0001`; `PLATFORM-0002`.

**Implementation implication:** Phase 3 should model executable price separately from quoted price, preserve partial-fill and cancellation state, and carry residual inventory or exposure forward after incomplete execution.

**Boundary / non-goal:** This does not claim that midpoint is executable, that a favorable quote guarantees full size, or that a theoretical arbitrage survives fees and slippage.

## Recommendation: Market Accuracy And PnL Must Stay Separate In Reporting

**Classification:** Phase 3 required

**Reasoning:** `CONCEPT-0004`, `SRC-0035`, `SRC-0036`, `SRC-0037`, and `SRC-0038` show that market calibration, price discovery, trader skill, and realized profitability are distinct outputs. A replay or analytics layer that merges them would misstate the evidence.

**Supporting research:** `CONCEPT-0004`; `SRC-0035` through `SRC-0038`.

**Implementation implication:** Phase 3 reporting should maintain separate metrics for forecast quality, execution quality, realized PnL, and price-discovery contribution.

**Boundary / non-goal:** This does not imply that statistically skilled accounts are durable profitable accounts, or that profitability alone proves information skill.

## Recommendation: Surveillance Should Remain Lower-Bound And Review-Oriented

**Classification:** Phase 3 extension point

**Reasoning:** `CONCEPT-0005` and `SRC-0039` support anomaly screening and lower-bound surveillance, but they do not justify a legal conclusion or a compliance verdict. The evidence is compatible with public-information skill, portfolio fragmentation, and false positives.

**Supporting research:** `CONCEPT-0005`; `SRC-0039`.

**Implementation implication:** If Phase 3 includes surveillance, it should emit review queues and score explanations rather than determinations of insider trading, illegality, or possession of material nonpublic information.

**Boundary / non-goal:** This does not make legal analysis part of execution logic, and it does not convert a screening score into a compliance decision.

## Recommendation: Identity Resolution Should Remain Conservative

**Classification:** Phase 3 extension point

**Reasoning:** The reviewed sources do not support treating a wallet or account as a stable human trader identity. `CONCEPT-0004`, `CONCEPT-0005`, `SRC-0036`, `SRC-0037`, and `SRC-0039` all preserve uncertainty around clustering, multiple wallets, and incomplete portfolio visibility.

**Supporting research:** `CONCEPT-0004`; `CONCEPT-0005`; `SRC-0036`; `SRC-0037`; `SRC-0039`.

**Implementation implication:** Any identity graph or clustering capability should be explicitly bounded, provenance-rich, and optional in Phase 3.

**Boundary / non-goal:** This does not justify hard-linking account activity to a single human, firm, or legal actor without additional evidence.

## Recommendation: Cross-Venue Normalization And Legal Compliance Verdicts Should Be Deferred

**Classification:** Defer to Phase 4

**Reasoning:** The reviewed evidence supports comparison and careful contrast, but not a production-grade universal ontology or a compliance adjudication layer. The phase-3 evidence base is sufficient to prevent category errors, but not to settle every abstraction or regulatory workflow.

**Supporting research:** `PLATFORM-0001`; `PLATFORM-0002`; `CONCEPT-0005`; `SRC-0039`.

**Implementation implication:** Phase 3 should preserve venue-local models and leave deeper cross-venue normalization and compliance workflow design for a later phase.

**Boundary / non-goal:** This is not a license to ignore venue differences; it is a boundary against over-normalization and premature compliance automation.

## Recommendation: Automated Compliance Verdicts Should Be Deferred

**Classification:** Defer to Phase 5

**Reasoning:** The reviewed evidence supports anomaly screening, legal caution, and policy analysis, but not engine-issued legal conclusions. `CONCEPT-0005` and `SRC-0039` keep empirical screening separate from legal determination.

**Supporting research:** `CONCEPT-0005`; `SRC-0039`.

**Implementation implication:** If compliance automation is ever introduced, it should live in a separate review workflow with explicit legal policy inputs and human oversight, not inside core execution.

**Boundary / non-goal:** This does not authorize automated findings of insider trading, illegality, or material nonpublic information possession in Phase 3.

## Recommendation: Unsupported Low-Latency Assumptions Are Out Of Scope

**Classification:** Out of scope

**Reasoning:** The reviewed sources do not establish same-block execution, direct-RPC advantage, or other latency-sensitive guarantees as default or reproducible architecture constraints. Those claims appear as unsupported practitioner assertions, not as general design evidence.

**Supporting research:** `STRATEGY-0001`; `SRC-0035`; `SRC-0036`.

**Implementation implication:** Phase 3 should not hard-code same-block or direct-RPC behavior as a baseline requirement for routing or replay.

**Boundary / non-goal:** This does not deny that low-latency behavior can matter; it only excludes unsupported latency assumptions from the architecture baseline.

## Core Constraints

### 1. Candidate generation is not execution

`CONCEPT-0001` and `STRATEGY-0001` preserve the distinction between logical relationships, arbitrage candidates, and executable opportunities. `SRC-0003` and `SRC-0005` show that coherent structure can create a profit bound or an arbitrage candidate, but the reviewed evidence does not justify treating that candidate as an executable order plan.

Implications:

- keep candidate generation separate from order authorization;
- represent dependency checks as evidence filters, not trade commands;
- require a deterministic validation step before any sizing or routing decision;
- preserve the possibility that a logically valid opportunity is unexecutable after fees, depth, or fills are considered.

### 2. Execution quality is venue-local

`CONCEPT-0002`, `STRATEGY-0002`, `PLATFORM-0001`, and `PLATFORM-0002` show that execution quality depends on venue-specific order-book shape, fee regime, and response schema.

Implications:

- do not normalize Polymarket and Kalshi into one wire model without preserving venue-specific fields;
- store and reason about executable price separately from quoted price;
- make depth, fees, spread capture, and partial fill handling explicit in the execution pipeline;
- treat maker/taker economics as historically bounded, not timeless;
- preserve the historical fee regime used by a paper or doc sample when replaying a result.

### 3. Account and wallet identity are uncertain

`CONCEPT-0004` and `CONCEPT-0005` show that the same market can be accurate even when profits are concentrated, and that suspicious or skilled accounts are not the same thing as unique humans. `SRC-0036` and `SRC-0037` both warn that wallet/account groupings can fragment a single actor's activity, and `SRC-0039` explicitly states that it cannot observe complete portfolios or all blockchain identifiers.

Implications:

- use account, wallet, and human identity as related but distinct entities;
- do not assume one wallet equals one trader or one human;
- make surveillance outputs lower-bound and review-oriented;
- avoid hard-linking anomaly scores to legal conclusions;
- preserve multi-wallet and off-platform transfer caveats in any replay or reporting layer.

### 4. Market accuracy, price discovery, and profitability are distinct signals

`CONCEPT-0004` preserves the distinction between market-level calibration, price discovery, and realized profitability. `SRC-0035` through `SRC-0038` show that a market can be accurate while trader profits remain highly concentrated, and that statistical skill does not collapse into PnL.

Implications:

- separate market accuracy metrics from trader PnL metrics;
- do not infer an executable edge from calibration alone;
- do not infer trader skill from profitability alone;
- preserve venue and sample differences when comparing Kalshi and Polymarket evidence.

### 5. Informed trading is not a legal conclusion

`CONCEPT-0005` keeps empirical screening, doctrinal analysis, and policy recommendations separate. `SRC-0039` explicitly treats anomalous trading as a lower-bound screen and states that suspicious behavior does not prove insider trading or material nonpublic information possession.

Implications:

- treat surveillance as a scoring and triage layer;
- keep evidence classes separate: empirical anomaly, legal doctrine, policy proposal;
- do not encode legal guilt as an engine-side output;
- do not turn a screening score into a compliance verdict.

## Design Implications for `invariant-engine`

### Phase 3 Read-Only Boundary

Phase 3 is read-only. Opportunities are diagnostic only. Candidates do not authorize orders. No order submission exists in Phase 3, no order cancellation exists in Phase 3, and no Phase 3 component may assume secrets, wallets, signing, authenticated trading APIs, live positions, or capital allocation. No LLM may authorize trades.

Implications:

- keep Phase 3 outputs limited to reviewed diagnostics, candidate explanations, and provenance-rich annotations;
- do not attach execution authority, wallet custody, or capital allocation to Phase 3 outputs;
- preserve an explicit boundary between read-only research outputs and any later execution system;
- treat every trade-facing behavior as out of scope for Phase 3.

### Market Model

- Model propositions, outcomes, conditions, events, markets, tokens, and contracts as venue-local entities rather than as a universal schema.
- Preserve the explicit difference between Polymarket and Kalshi object models.
- Represent complement, implication, exclusivity, and subset relations as structured constraints with provenance.

### Future Execution Architecture (Phase 7+; Not Part of Phase 3)

- Stage 1: candidate generation from logical relationships or anomaly screens.
- Stage 2: deterministic validation against venue rules, depth, fees, and available state.
- Stage 3: sizing and routing using executable price rather than quoted price.
- Stage 4: order submission with explicit maker/taker, TIF, and cancellation semantics.
- Stage 5: reconciliation of fills, partial fills, cancellations, and residual exposure.

These stages are intentionally deferred. They describe future execution architecture, not Phase 3 implementation guidance.

### Risk Controls

- Maintain separate controls for price risk, fill risk, fee risk, and multi-leg failure risk.
- Require explicit handling of partial execution and residual inventory.
- Make kill-switches and exposure caps independent of model output.
- Treat current venue API behavior as mutable and refreshable.

### Surveillance and Reporting

- Produce anomaly scores and review queues, not legal determinations.
- Include lower-bound caveats and identity uncertainty in every surveillance output.
- Separate public-information skill from suspicious-trading flags.

## Venue-Specific Implementation Constraints

### Polymarket

- The engine must preserve offchain matching and onchain settlement as venue-specific semantics.
- Order-book snapshot and websocket behavior should be modeled with explicit snapshot/delta handling and acknowledged ambiguity around recovery semantics where the docs are incomplete.
- Individual matched-trade atomicity must not be generalized to multi-leg strategy atomicity.
- Fee and rate-limit behavior are mutable and must be captured with dates.

### Kalshi

- The engine must preserve series/event/market hierarchy and fixed-point fields.
- YES/NO bid-book semantics require complementary ask derivation.
- Lifecycle states such as determined, disputed, amended, finalized, and settlement-related states must remain distinct.
- Settlement is exchange-managed and must not be modeled as on-chain.
- Fixed-point migration, fees, historical routing, and rate limits are mutable and must be time-scoped.

## What the Research Does Not Justify

- A universal cross-venue ontology that erases platform differences.
- A one-step projection-to-order-size mapping that ignores fill risk or fees.
- A deterministic guarantee that profitable accounts are durable humans.
- A compliance verdict based on anomaly scores.
- Same-block or direct-RPC execution assumptions as default behavior.
- Any Phase 3 order submission, cancellation, or capital-allocation capability.
- Any Phase 3 wallet custody, signing, or authenticated trading interface.

## Phase 3 Milestone 3.1 Implications

Milestone 3.1 should be a read-only diagnostic milestone, not an execution milestone.

## Milestone 3.1 Required

- `RawEnvelope`
- typed IDs
- `Venue`
- venue-native market / contract references
- `OrderBookSnapshot`
- `PriceLevel`
- `BookSide`
- `MarketRelationship`
- `OpportunityCandidate`
- `raw_ref` linkage
- warning fields
- `Decimal` policy
- replay-oriented serialization

## Milestone 3.1 Extension Points

- `AccountRef`
- `WalletRef`
- `ObservedActorRef`
- `TradeObservation`
- `FeeSchedule`
- `LifecycleFeatures`
- `AnomalySignal`

These may be defined as shapes, stubs, or deferred interfaces, not fully populated analytics.

## Explicitly Deferred

- execution-quality PnL decomposition;
- calibration analytics;
- mature surveillance scoring;
- paper trading;
- authenticated trading;
- live execution;
- portfolio/risk engine;
- legal/compliance determinations.

## Required `raw_ref` Traceability

List fields/objects that must retain raw provenance:

- raw venue payload;
- normalized market objects;
- order book snapshots;
- price levels;
- detected relationships;
- opportunity candidates;
- fee schedule observations if available;
- lifecycle observations if available;
- trade observations if available.

## Required Warning Fields

List warnings that should be represented in the domain model:

- venue semantics not normalized;
- quoted price is not executable price;
- fee omitted or estimated;
- depth incomplete;
- public API field unavailable;
- account identity uncertain;
- maker/taker role unavailable or inferred;
- lifecycle state ambiguous;
- derived ask / complement calculation;
- detector assumption;
- stale snapshot;
- missing raw reference.

## AGENTS.md / Architecture Assumptions To Document

Add explicit assumptions future agents must preserve:

- Phase 3 is read-only;
- candidates are diagnostic only;
- no order authorization;
- no secrets, wallets, signing, or authenticated trading APIs;
- no LLM-authorized trades;
- Decimal for money/prices/probabilities where precision matters;
- venue-native semantics before normalization;
- missing fields must be explicit, not fabricated.

## Open Questions for Phase 3

- What minimum deterministic validation should gate any candidate trade before routing?
- How should the engine represent venue-specific depth and partial fill state in a way that remains replayable?
- What is the cleanest abstraction for separating candidate generation from execution authorization?
- How should surveillance outputs be retained so that they are reviewable without becoming legal conclusions?

## Recommended Phase 3 Boundaries

- Keep research synthesis in `context/`.
- Keep executable trading logic in `invariant-engine`.
- Keep mutable venue behavior behind refreshable adapters or configuration, not hard-coded assumptions.
- Keep legal analysis and surveillance scoring separate from order authorization.
- Keep any future architecture-impact revisions additive until a concrete engine design exists.
