---
page_id: SOURCE-SUMMARY-0007
title: Positions & Tokens
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0008
sources:
  - SRC-0008
related_pages: []
tags:
  - polymarket
  - official-documentation
  - positions
  - tokens
  - ctf
---

# Source Summary

## Citation

Polymarket documentation. "Positions & Tokens." Source ID: `SRC-0008`. Canonical URL: `https://docs.polymarket.com/concepts/positions-tokens.md`.

## Source Type

Official documentation / primary platform. This page explains how outcome tokens, positions, collateral, and redemption work.

## Purpose or Scope

The page defines what a position is, how outcome tokens are created and backed, and how tokens move through split, trade, merge, and redeem flows.

## Key Facts

- Every prediction is represented by outcome tokens, and a position is the token balance for a market.
- Each market has exactly two outcome tokens, Yes and No, each redeeming for $1 if the corresponding outcome occurs.
- Outcome tokens are ERC1155 assets on Polygon using the Gnosis Conditional Token Framework.
- Every Yes/No pair is backed by exactly $1 of pUSD collateral locked in the CTF contract.
- Split, merge, trade, and redeem are all described explicitly, and position value is token balance times current price.
- Holding rewards are described as 4.00% annualized, sampled hourly, and distributed daily, with a variable rate.

## Important Claims

- [CLM-0048] A position is the balance of outcome tokens held for a market.
- [CLM-0049] Each market has exactly two outcome tokens, Yes and No, each redeeming for $1 under the described outcome rule.
- [CLM-0050] Outcome tokens are ERC1155 assets on Polygon using CTF, backed by exactly $1 of pUSD, and the page describes split, merge, and redeem flows.

## Limitations

The page does not describe order-book mechanics, CLOB matching, authentication, or resolution oracle mechanics in detail.

## Relevance to Invariant

This page is the primary source for position accounting, collateral backing, and token lifecycle assumptions. It supports inventory and redemption modeling, but not model-output execution logic.

## Comparison to SRC-0004

- Supports the claim that outcome tokens and positions are the relevant tradable units.
- Does not support claims that a market maker's projection or gradient directly yields executable trade sizing.
- The collateral lifecycle is explicit here, but the page does not discuss optimization or projection algorithms.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
