---
page_id: CONCEPT-0002
title: Prediction Market Mechanics
page_type: concept
status: review-required
created_at: 2026-06-28
updated_at: 2026-06-28
sources:
  - SRC-0008
  - SRC-0009
  - SRC-0010
  - SRC-0014
  - SRC-0015
  - SRC-0016
  - SRC-0021
  - SRC-0022
  - SRC-0023
  - SRC-0024
  - SRC-0025
  - SRC-0026
  - SRC-0027
related_pages:
  - CONCEPT-0001
  - CONCEPT-0003
  - STRATEGY-0001
  - PLATFORM-0001
  - PLATFORM-0002
tags:
  - prediction-markets
  - order-book
  - liquidity
  - execution
---

# Prediction Market Mechanics

## Purpose

Explain the stable mechanics needed to interpret quoted prices and decide whether a theoretical opportunity may be executable. This page stays at the mechanics layer; venue-specific schemas belong on the platform pages.

## Quoted Price Versus Executable Price

- Polymarket shows probability-style prices, but the displayed value is not a promise of executable size at that price. [CLM-0051] [CLM-0052] [CLM-0053]
- Kalshi uses fixed-point price fields, so the numeric representation is different even when the economic meaning is similar. [CLM-0092] [CLM-0093]
- Repository synthesis: a quoted price is informational until there is sufficient depth to execute at that level.

## Bids and Asks

- Polymarket documents both bids and asks directly. [CLM-0051] [CLM-0053]
- Kalshi’s orderbook response returns YES bids and NO bids; opposite-side asks are derived from complementary pricing rather than returned directly. [CLM-0088] [CLM-0089] [CLM-0090] [CLM-0091]
- This difference is mechanical, not conceptual: both venues still expose a best-buy / best-sell view, but the wire representation differs.

## Spread

- The spread is the gap between the best bid and the best ask.
- `SRC-0009` explicitly treats spread as a price gap that matters for trade quality. [CLM-0053]
- `SRC-0023` shows that when only bid books are returned, the spread must be derived from the complementary side rather than read directly. [CLM-0090] [CLM-0091]

## Midpoint

- The midpoint is a descriptive summary of the top of book, not an execution guarantee.
- `SRC-0009` uses midpoint as a display convention and separately warns that execution happens at the bid or ask. [CLM-0052]
- Repository synthesis: midpoint can be useful for visualization, but executable evaluation must still use depth and fill assumptions.

## Order-Book Depth

- Depth is the available size at each price level.
- Large orders can move price significantly, so theoretical profit must be checked at executable size, not only at quoted top-of-book size. [CLM-0053]
- `SRC-0004` treats depth as an execution constraint and proposes limiting position size relative to depth, but that is practitioner guidance rather than venue policy. [CLM-0023] [CLM-0019]

## Liquidity

- Liquidity is the practical capacity to trade without moving the market too much.
- `SRC-0003` and `SRC-0004` both treat liquidity constraints as central to whether a logical opportunity is worth pursuing. [CLM-0009] [CLM-0010] [CLM-0023]

## Slippage

- Slippage is the gap between a quoted edge and the realized fill quality once the order consumes depth.
- `SRC-0004` uses VWAP language to estimate fill quality, but the reviewed sources do not establish a universal slippage formula. [CLM-0023]
- Repository synthesis: slippage is a venue- and size-dependent execution effect, not a fixed constant.

## Price Levels and Size

- Polymarket order books expose price levels with size arrays. [CLM-0067] [CLM-0068] [CLM-0073]
- Kalshi order books expose fixed-point quantity and price fields, including level depth in the response schema. [CLM-0088] [CLM-0089] [CLM-0092] [CLM-0093]
- Top-level level order matters because deeper levels can change the executable price.

## Partial Fills

- Both reviewed order-creation surfaces expose state that can indicate partial execution. Polymarket exposes order-response state that can indicate partial execution, while Kalshi's Create Order V2 response includes `fill_count` and `remaining_count`. [CLM-0057] [CLM-0096]
- The approved Kalshi documentation set does not include a dedicated fill-history endpoint, so complete historical fill-payload semantics remain deferred. This does not mean partial-order state is absent from the order response.
- Repository synthesis: partial fill is a mechanics concept only when the source surface exposes enough state to observe it.

## Execution Quantity

- Execution quantity is the amount that can actually be filled at acceptable cost.
- `SRC-0004` argues that theoretical profit must be evaluated at executable size, but `SRC-0005` shows that the underlying math only guarantees a profit bound under its assumptions. [CLM-0015] [CLM-0026]
- Practical sizing should therefore respect depth, fees, and order-book shape.

## Venue-Local Order-Book Representations

- Polymarket exposes both sides directly in its order-book surfaces. [CLM-0051] [CLM-0067] [CLM-0068]
- Kalshi exposes YES and NO bids and derives asks from the complement. [CLM-0088] [CLM-0089] [CLM-0090] [CLM-0091]
- Do not normalize these two surfaces to the same wire shape without preserving the venue-specific representation.

## Why Midpoint Is Not an Execution Guarantee

- `SRC-0009` explicitly distinguishes display price from execution price. [CLM-0052]
- `SRC-0014` and `SRC-0022` show that actual order-book snapshots carry depth and side-specific levels, so execution must still consume available size. [CLM-0067] [CLM-0088] [CLM-0089]
- Repository synthesis: midpoint can be misleading if depth is thin or if the complementary side moves while the order is staged.

## Mutable Platform Details

- Polymarket websocket and fee behavior are mutable and date-sensitive. [CLM-0069] [CLM-0070] [CLM-0071] [CLM-0076] [CLM-0077] [CLM-0078] [CLM-0079]
- Kalshi fixed-point migration, fee tiers, rate limits, and websocket behavior are also mutable. [CLM-0092] [CLM-0093] [CLM-0104] [CLM-0105] [CLM-0117] [CLM-0118] [CLM-0119]
- Refresh these facts before implementation.

## Open Questions

- What is the best venue-neutral way to model depth when one venue publishes both sides and the other publishes complementary bid books?
- When the docs do not spell out gap recovery, what minimal replay logic is safe to assume?
- How should fixed-point quantities be normalized without losing the original venue semantics?

## Related Pages

- [Market Relationship Taxonomy](../concepts/market-relationship-taxonomy.md)
- [Resolution and Settlement](../concepts/resolution-and-settlement.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0008` and `SRC-0009`: [CLM-0048], [CLM-0049], [CLM-0050], [CLM-0051], [CLM-0052], [CLM-0053]
- `SRC-0010`, `SRC-0014`, `SRC-0015`, `SRC-0016`: [CLM-0054], [CLM-0055], [CLM-0056], [CLM-0057], [CLM-0067], [CLM-0068], [CLM-0069], [CLM-0070], [CLM-0071], [CLM-0072], [CLM-0073], [CLM-0074], [CLM-0075]
- `SRC-0021`, `SRC-0022`, `SRC-0023`, `SRC-0024`, `SRC-0025`, `SRC-0026`, `SRC-0027`: [CLM-0085], [CLM-0086], [CLM-0088], [CLM-0089], [CLM-0090], [CLM-0091], [CLM-0092], [CLM-0093], [CLM-0094], [CLM-0095], [CLM-0096], [CLM-0097], [CLM-0101], [CLM-0102], [CLM-0103]
