---
page_id: SOURCE-SUMMARY-0010
title: Resolution
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0011
sources:
  - SRC-0011
related_pages: []
tags:
  - polymarket
  - official-documentation
  - resolution
  - oracle
  - redemption
---

# Source Summary

## Citation

Polymarket documentation. "Resolution." Source ID: `SRC-0011`. Canonical URL: `https://docs.polymarket.com/concepts/resolution.md`.

## Source Type

Official documentation / primary platform. This page describes how market outcomes are resolved and how winning tokens are redeemed.

## Purpose or Scope

The page covers the UMA Optimistic Oracle process, dispute flow, bond economics, and the post-resolution redemption path through the collateral adapter.

## Key Facts

- Market resolution uses the UMA Optimistic Oracle.
- Every market has predefined resolution rules that include the resolution source, end date, and edge cases.
- Anyone can propose a resolution, and anyone can dispute it.
- The challenge period is 2 hours, and disputes can escalate to UMA's DVM.
- After resolution, winning tokens are redeemable for $1 each, and redemption runs through the CTF collateral adapter into pUSD.
- The page also describes additional context updates that can clarify rules without changing the question's fundamental intent.

## Important Claims

- [CLM-0058] Polymarket resolves markets through the UMA Optimistic Oracle, and the market's rules define the resolution source, end date, and edge cases.
- [CLM-0059] The challenge/dispute process uses a 2-hour challenge period, can escalate to UMA DVM, and is backed by proposer/disputer bonds.
- [CLM-0060] Winning tokens redeem for $1 each through the CTF collateral adapter, and clarifications can be issued as additional context.

## Limitations

The page does not explain CTF token creation in detail or how market data channels report resolution events.

## Relevance to Invariant

This is the primary source for resolution and redemption semantics. It supports the distinction between market resolution and order settlement.

## Comparison to SRC-0004

- Supports the need to separate market resolution from trade settlement.
- Does not support any direct trading-strategy or projection claim.
- The page gives oracle mechanics, not executable position-sizing guidance.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
