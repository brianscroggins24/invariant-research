---
page_id: SOURCE-SUMMARY-0009
title: Order Lifecycle
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0010
sources:
  - SRC-0010
related_pages: []
tags:
  - polymarket
  - official-documentation
  - order-lifecycle
  - execution
  - clob
---

# Source Summary

## Citation

Polymarket documentation. "Order Lifecycle." Source ID: `SRC-0010`. Canonical URL: `https://docs.polymarket.com/concepts/order-lifecycle.md`.

## Source Type

Official documentation / primary platform. This page describes the order state machine from client signing through matching, settlement, and confirmation.

## Purpose or Scope

The page explains how orders are created, validated, matched, settled, and cancelled, including supported order types and delayed execution windows.

## Key Facts

- Orders are created offchain, matched by an operator, and settled onchain through smart contracts.
- All orders are limit orders; market orders are immediate-execution limit orders.
- Orders are EIP712-signed messages that authorize the Exchange contract without taking custody of funds.
- Supported order types are GTC, GTD, FOK, and FAK; post-only orders rest on the book or are rejected if they cross the spread.
- The operator validates signatures, balances, allowances, and minimum tick size, and some markets apply taker delay windows before matching.
- Settlement of an individual matched trade is described as atomic, and the page defines live, matched, delayed, unmatched, MATCHED, MINED, CONFIRMED, RETRYING, and FAILED statuses.

## Important Claims

- [CLM-0054] Orders are created offchain and matched by an operator, while each matched trade is settled onchain atomically, meaning that the settlement of that individual trade either succeeds completely or fails completely.
- [CLM-0055] The supported order types are GTC, GTD, FOK, and FAK, and post-only orders rest on the book or are rejected if they would cross the spread.
- [CLM-0056] Order submission validates signatures, balances, allowances, and tick size, and selected markets use taker-delay windows before matching.
- [CLM-0057] The page defines order and trade statuses, plus cancellation limits for delayed and partially filled orders.

## Limitations

The page does not describe resolution, fee calculation, or WebSocket market-data sequencing.

## Relevance to Invariant

This is the primary source for order-state modeling and execution semantics. It is also the clearest source in this set for separating offchain matching from onchain settlement.

## Comparison to SRC-0004

- The page supports the distinction between offchain matching and onchain settlement. It states that settlement of an individual matched trade is atomic, but it does not state that multiple independently submitted orders or arbitrage legs fill atomically. It therefore does not resolve or contradict the multi-leg execution risk discussed in `SRC-0003` and `SRC-0004`.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
