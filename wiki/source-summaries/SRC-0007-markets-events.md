---
page_id: SOURCE-SUMMARY-0006
title: Markets & Events
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0007
sources:
  - SRC-0007
related_pages: []
tags:
  - polymarket
  - official-documentation
  - market-model
  - clob
---

# Source Summary

## Citation

Polymarket documentation. "Markets & Events." Source ID: `SRC-0007`. Canonical URL: `https://docs.polymarket.com/concepts/markets-events.md`.

## Source Type

Official documentation / primary platform. This page defines the platform's market and event terminology and notes when a market is eligible for CLOB trading.

## Purpose or Scope

The page establishes the basic entity model for Polymarket: markets, events, identifiers, and the trading eligibility gate for order-book markets.

## Key Facts

- A market is the fundamental tradable unit and represents a single binary yes/no question.
- Each market has a Condition ID, Question ID, and token IDs for the two outcome tokens.
- An event groups one or more related markets, with single-market and multi-market examples shown separately.
- `enableOrderBook` must be true for CLOB trading.
- Sports markets auto-cancel outstanding limit orders when the game begins, but game-start timing can shift.

## Important Claims

- [CLM-0045] Markets are the fundamental tradable unit, and they are identified by Condition ID, Question ID, and token IDs.
- [CLM-0046] Events group one or more related markets, with the single-market and multi-market cases treated differently.
- [CLM-0047] CLOB trading requires `enableOrderBook: true`, and sports orders can auto-cancel at game start.

## Limitations

This page is conceptual. It does not describe pricing, authentication, fee calculation, order lifecycle details, or WebSocket reconstruction behavior.

## Relevance to Invariant

This page supports the base entity model for market/event indexing. It does not support the optimization, projection, or execution-direction claims found in `SRC-0004`.

## Comparison to SRC-0004

- Directly supports the market/event terminology.
- Does not support claims about Bregman projection, Frank-Wolfe optimization, or executable position sizing.
- The page's trading gate is an eligibility flag, not a matching or settlement description.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
