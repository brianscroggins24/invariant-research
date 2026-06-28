---
page_id: PLATFORM-0001
title: Polymarket
page_type: platform
status: reviewed
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0007
  - SRC-0008
  - SRC-0009
  - SRC-0010
  - SRC-0011
  - SRC-0012
  - SRC-0013
  - SRC-0014
  - SRC-0015
  - SRC-0016
  - SRC-0017
  - SRC-0018
related_pages:
  - CONCEPT-0001
  - CONCEPT-0002
  - CONCEPT-0003
  - STRATEGY-0001
tags:
  - polymarket
  - platform
  - cLOB
  - prediction-markets
---

# Polymarket

## Scope and Freshness

- Documentation capture date: 2026-06-27.
- Source-ID range: `SRC-0007` through `SRC-0018`.
- API fields, channels, fees, and limits are mutable and must be refreshed before implementation.

## Entity Model

- Polymarket’s tradable unit is the market. [CLM-0045]
- Markets are organized within events. [CLM-0046]
- Positions are balances of outcome tokens. [CLM-0048]

## Events and Markets

- Polymarket uses markets as the basic tradable question and events as groupings that can contain one or more markets. [CLM-0045] [CLM-0046]
- `enableOrderBook: true` is required for CLOB trading on the relevant surfaces. [CLM-0047]

## Conditions, Outcomes, and Outcome Tokens

- Outcome tokens represent YES/NO exposure for each market. [CLM-0048] [CLM-0049]
- The page explicitly describes split, merge, trade, and redeem flows through the Conditional Token Framework. [CLM-0050]
- Repository synthesis: the venue-local token model is the basis for pricing, position accounting, and redemption.

## Positions

- A position is the token balance for a market. [CLM-0048]
- A balanced yes/no pair is backed by collateral and can be split, traded, merged, and redeemed. [CLM-0050]

## Prices and Order Books

- Prices are displayed as probability-style values from supply and demand, not as venue-set values. [CLM-0051]
- The displayed price is usually the midpoint of the spread, unless the spread is wide enough that the last traded price is shown. [CLM-0052]
- Spread and depth both matter because large orders can move the market materially. [CLM-0053]

## REST Order-Book Snapshot

- `GET /book` requires a token identifier and returns a snapshot with market, asset ID, timestamp, hash, bids, asks, min order size, tick size, neg_risk, and last_trade_price. [CLM-0067]
- Returned bids are sorted descending and asks ascending. [CLM-0068]

## WebSocket Market Channel

- The official websocket surface includes the market channel and related channels. [CLM-0069]
- Market subscriptions use asset IDs and support subscription updates without reconnecting. [CLM-0070]
- Heartbeat rules are documented for the websocket channels. [CLM-0071]

## Snapshot and Incremental Updates

- The market channel supports a full `book` snapshot and incremental `price_change` updates. [CLM-0072] [CLM-0073]
- It also documents `last_trade_price`, `tick_size_change`, `best_bid_ask`, `new_market`, and `market_resolved` events when the custom feature is enabled. [CLM-0074] [CLM-0075]
- Documented ambiguity: the reviewed docs do not specify a fully deterministic gap-recovery algorithm for missed websocket updates.

## Authentication

- L1 authentication uses a wallet signature to create or derive API credentials. [CLM-0061] [CLM-0062]
- L2 trading requests require the five POLY_* headers. [CLM-0063]

## Order Creation

- `POST /order` creates a new order in the book and requires authenticated headers. [CLM-0064]
- The schema enforces order and owner plus the documented order-type and execution constraints. [CLM-0065]
- The response can return live, matched, or delayed states, along with trade identifiers and hashes. [CLM-0066]

## Order Types and Time in Force

- The documented order types include GTC, GTD, FOK, and FAK. [CLM-0055]
- Post-only orders rest on the book or are rejected if they would cross the spread. [CLM-0055]
- Order validation checks signature, balances, allowances, and minimum tick size. [CLM-0056]

## Order Lifecycle

- Orders are created offchain, matched by an operator, and settled onchain through smart contracts. [CLM-0054]
- Trade statuses include MATCHED, MINED, CONFIRMED, RETRYING, and FAILED. [CLM-0057]
- The review layer preserves the distinction between individual-trade settlement and multi-leg strategy execution.

## Offchain Matching and Onchain Settlement

- The reviewed docs explicitly use offchain matching and onchain settlement language. [CLM-0054]
- That language belongs to Polymarket’s venue-local model and must not be generalized to Kalshi. [CLM-0054] [CLM-0113]

## Atomicity Scope

- The settlement of one matched trade is atomic. [CLM-0054]
- That does not imply atomic execution across multiple independently submitted orders or arbitrage legs. [CLM-0054]

## Resolution

- Polymarket resolves markets through the UMA Optimistic Oracle, with explicit challenge and dispute mechanics. [CLM-0058] [CLM-0059]
- The market rules specify the resolution source, end date, and edge cases. [CLM-0058]

## Redemption

- Winning tokens redeem for $1 each through the CTF collateral adapter into pUSD. [CLM-0060]
- Redemption is therefore token-based, not exchange-lifecycle-based.

## Fees

- Polymarket charges taker fees on certain markets and exempts geopolitical and world-event markets. [CLM-0076]
- The fee formula is explicit, makers are not charged, and fee precision is rounded to 5 decimal places in USDC. [CLM-0077]

## Rate Limits

- Polymarket’s reviewed docs expose rate-limiting behavior through platform documentation, but the details are mutable and should be refreshed before implementation. [CLM-0078] [CLM-0079]

## Mutable Facts and Refresh Requirements

- Current websocket event shapes are mutable. [CLM-0070] [CLM-0071] [CLM-0072] [CLM-0073] [CLM-0074] [CLM-0075]
- Fee behavior is mutable. [CLM-0076] [CLM-0077]
- Rate-limit behavior is mutable. [CLM-0078] [CLM-0079]
- Refresh before using these details in any production design.

## Documented Ambiguities

- The reviewed docs do not fully specify gap recovery after missed websocket updates.
- The docs do not establish same-block execution guarantees.
- The docs do not describe direct-RPC submission as a standard documented path.

## Unsupported Practitioner Claims

- Same-block execution as a general guarantee.
- Direct-RPC latency advantages.
- Any claim that an individual matched-trade settlement guarantee applies to an entire strategy.
- Any claim that current API fields, fee schedules, or rate limits are timeless.

## Related Pages

- [Market Relationship Taxonomy](../concepts/market-relationship-taxonomy.md)
- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)

## Sources and Claims

- `SRC-0007`: [CLM-0045], [CLM-0046], [CLM-0047]
- `SRC-0008`: [CLM-0048], [CLM-0049], [CLM-0050]
- `SRC-0009`: [CLM-0051], [CLM-0052], [CLM-0053]
- `SRC-0010`: [CLM-0054], [CLM-0055], [CLM-0056], [CLM-0057]
- `SRC-0011`: [CLM-0058], [CLM-0059], [CLM-0060]
- `SRC-0012`: [CLM-0061], [CLM-0062], [CLM-0063]
- `SRC-0013`: [CLM-0064], [CLM-0065], [CLM-0066]
- `SRC-0014`: [CLM-0067], [CLM-0068]
- `SRC-0015`: [CLM-0069], [CLM-0070], [CLM-0071]
- `SRC-0016`: [CLM-0072], [CLM-0073], [CLM-0074], [CLM-0075]
- `SRC-0017`: [CLM-0076], [CLM-0077]
- `SRC-0018`: [CLM-0078], [CLM-0079]
