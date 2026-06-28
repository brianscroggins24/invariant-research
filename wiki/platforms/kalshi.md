---
page_id: PLATFORM-0002
title: Kalshi
page_type: platform
status: review-required
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0019
  - SRC-0020
  - SRC-0021
  - SRC-0022
  - SRC-0023
  - SRC-0024
  - SRC-0025
  - SRC-0026
  - SRC-0027
  - SRC-0028
  - SRC-0029
  - SRC-0030
  - SRC-0031
  - SRC-0032
  - SRC-0033
  - SRC-0034
related_pages:
  - CONCEPT-0001
  - CONCEPT-0002
  - CONCEPT-0003
  - STRATEGY-0001
tags:
  - kalshi
  - platform
  - fixed-point
  - rate-limits
---

# Kalshi

## Scope and Freshness

- Documentation capture date: 2026-06-27.
- Source-ID range: `SRC-0019` through `SRC-0034`.
- Schemas, migration timelines, fees, historical cutoffs, lifecycle fields, and limits are mutable and must be refreshed before implementation.

## Series, Events, and Markets

- A series is the top-level template for recurring events. [CLM-0080] [CLM-0081]
- Events sit under series and can contain one or more markets. [CLM-0082] [CLM-0083]
- Kalshi’s venue-local hierarchy is series → event → market.

## Identifiers and Tickers

- The reviewed event and market schemas expose series ticker, event ticker, and market ticker fields. [CLM-0081] [CLM-0083]
- These identifiers are venue-local and should not be collapsed into Polymarket’s condition/outcome-token vocabulary.

## Binary Prose and Scalar Schema Nuance

- The prose description emphasizes binary YES/NO markets. [CLM-0085]
- The Market schema separately permits `market_type` values of both `binary` and `scalar`. [CLM-0085]
- Downstream modeling should preserve that distinction rather than assuming every Kalshi market is binary.

## YES and NO Contracts

- Kalshi markets expose YES/NO quote fields and settlement-relevant metadata. [CLM-0086]
- The reviewed docs describe the payout meaning of those contracts at settlement. [CLM-0114]

## Price and Payout Representation

- Prices are exposed in fixed-point form. [CLM-0092] [CLM-0093]
- `Get Market` exposes YES and NO bid/ask prices, last price, volume, open interest, settlement timer, and status. [CLM-0086] [CLM-0087]
- The payout side remains a $1-per-contract binary interpretation for YES/NO outcomes, while scalar settlement has separate fee rules. [CLM-0114]

## Fixed-Point Fields

- Fixed-point price strings support the migration away from legacy representations. [CLM-0092]
- Contract-count `_fp` fields use string encoding with 0-2 decimal places on input and emit 2 decimals in responses. [CLM-0093]
- This migration is date-sensitive and should be refreshed.

## REST Order-Book Snapshot

- `Get Market Orderbook` returns a snapshot for a specific market and uses an optional depth parameter. [CLM-0088]
- The response is `orderbook_fp` with `yes_dollars` and `no_dollars` arrays of `[price_dollars, contract_count_fp]` values. [CLM-0089]

## YES Bids and NO Bids

- Kalshi returns YES bids and NO bids directly in the order-book snapshot. [CLM-0089]
- The opposite-side ask can be derived from the complementary side. [CLM-0090] [CLM-0091]

## Derived Asks

- A YES bid implies a NO ask, and a NO bid implies a YES ask, via complementary pricing. [CLM-0090] [CLM-0091]
- This is a derived relation, not a separately published ask ladder.

## WebSocket Authentication

- The websocket connection requires authentication during the handshake. [CLM-0098]
- Subscription commands support client-generated IDs and subscription IDs. [CLM-0099] [CLM-0100]

## Snapshot and Delta Updates

- The market-data websocket documents an initial `orderbook_snapshot` followed by incremental `orderbook_delta` updates. [CLM-0101] [CLM-0102]
- The docs expose sequence metadata, but they do not fully specify missed-update recovery. [CLM-0103]

## Sequence Metadata

- Both snapshot and delta messages carry `sid` and `seq`. [CLM-0102] [CLM-0103]
- Sequence metadata is useful for ordering and gap detection, but the reviewed docs stop short of a full recovery algorithm.

## Recovery Ambiguity

- The reviewed docs do not specify exactly how a client should resynchronize after a missed websocket update.
- That ambiguity should be preserved rather than filled in with a guessed algorithm. [CLM-0103]

## Order Creation

- Create Order V2 requires the Kalshi access-key, signature, and timestamp headers. [CLM-0094]
- The request accepts ticker, side, count, price, time_in_force, and self_trade_prevention_type. [CLM-0094] [CLM-0095]
- The response returns order_id, client_order_id, fill_count, remaining_count, average_fill_price, average_fee_paid, and ts_ms. [CLM-0096]

## Order Types and Time in Force

- `good_till_canceled`, `immediate_or_cancel`, and related execution modes are documented. [CLM-0095]
- The endpoint also documents post-only and self-trade-prevention behavior. [CLM-0095] [CLM-0097]

## Market Lifecycle

- REST market statuses include `initialized`, `active`, `inactive`, `closed`, `determined`, `disputed`, `amended`, and `finalized`. [CLM-0110]
- The lifecycle transitions include open-time activation, close-time closure, and transitions through determination and finalization. [CLM-0111]

## Determination

- The documentation distinguishes `determined` from later `finalized` status. [CLM-0110] [CLM-0111]
- Determination is therefore not identical to finality.

## Dispute and Amendment

- The lifecycle includes `disputed` and `amended` states. [CLM-0110] [CLM-0111]
- Those states show that Kalshi’s market lifecycle can remain mutable after an initial outcome-related change.

## Finalization

- `settled` transitions a market to `finalized`. [CLM-0111]
- Finalization is a later lifecycle state, not a synonym for determination.

## Settlement and Payout

- Settlement begins when an outcome is determined and positions are automatically resolved with funds transferred. [CLM-0113]
- The review layer does not describe Kalshi settlement as on-chain. [CLM-0113]
- Determination should not be equated with immediate final cash availability. [CLM-0113]

## Fees and Fee Changes

- Series and event fee-change endpoints expose fee schedules and overrides. [CLM-0104] [CLM-0105] [CLM-0106] [CLM-0107]
- Fee behavior is mutable and must be refreshed before implementation.

## Fee Rounding

- Kalshi’s fee rounding rules are separately documented and are time-sensitive. [CLM-0108] [CLM-0109]
- Rounding behavior should be modeled separately from payout timing.

## Historical Data Routing

- Historical data is routed through a cutoff-based split between live and historical endpoints. [CLM-0115] [CLM-0116]
- The reviewed docs distinguish historical cutoff routing from the live endpoints that still serve current state.

## Rate Limits

- Kalshi documents token-based limits, burst capacity, and tier-specific budgets. [CLM-0117] [CLM-0118] [CLM-0119]
- Rate limits are mutable and tier-dependent.

## Mutable Facts and Refresh Requirements

- Fixed-point migration details are mutable. [CLM-0092] [CLM-0093]
- Fee schedules and fee-change behavior are mutable. [CLM-0104] [CLM-0105] [CLM-0106] [CLM-0107] [CLM-0108] [CLM-0109]
- Historical routing is mutable. [CLM-0115] [CLM-0116]
- Rate limits are mutable. [CLM-0117] [CLM-0118] [CLM-0119]
- Refresh all of these before implementation.

## Documented Ambiguities

- Missed-update recovery is not fully specified.
- The approved docs do not include a dedicated trade/fill payload page, so exact fill semantics remain deferred.
- Settlement should not be described as on-chain.

## Related Pages

- [Market Relationship Taxonomy](../concepts/market-relationship-taxonomy.md)
- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)

## Sources and Claims

- `SRC-0019`: [CLM-0080], [CLM-0081]
- `SRC-0020`: [CLM-0082], [CLM-0083], [CLM-0084]
- `SRC-0021`: [CLM-0085], [CLM-0086], [CLM-0087]
- `SRC-0022`: [CLM-0088], [CLM-0089]
- `SRC-0023`: [CLM-0090], [CLM-0091]
- `SRC-0024`: [CLM-0092], [CLM-0093]
- `SRC-0025`: [CLM-0094], [CLM-0095], [CLM-0096], [CLM-0097]
- `SRC-0026`: [CLM-0098], [CLM-0099], [CLM-0100]
- `SRC-0027`: [CLM-0101], [CLM-0102], [CLM-0103]
- `SRC-0028`: [CLM-0104], [CLM-0105]
- `SRC-0029`: [CLM-0106], [CLM-0107]
- `SRC-0030`: [CLM-0108], [CLM-0109]
- `SRC-0031`: [CLM-0110], [CLM-0111], [CLM-0112]
- `SRC-0032`: [CLM-0113], [CLM-0114]
- `SRC-0033`: [CLM-0115], [CLM-0116]
- `SRC-0034`: [CLM-0117], [CLM-0118], [CLM-0119]
