---
page_id: SOURCE-SUMMARY-0012
title: Post a new order
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0013
sources:
  - SRC-0013
related_pages: []
tags:
  - polymarket
  - official-documentation
  - order-entry
  - api
  - clob
---

# Source Summary

## Citation

Polymarket documentation. "Post a new order." Source ID: `SRC-0013`. Canonical URL: `https://docs.polymarket.com/api-reference/trade/post-a-new-order.md`.

## Source Type

Official documentation / primary platform. This page is the OpenAPI reference for posting a new order into the CLOB.

## Purpose or Scope

The page describes the POST /order request body, response states, security requirements, and common validation failures.

## Key Facts

- POST /order creates a new order in the order book.
- The endpoint requires the five L2 security headers.
- SendOrder requires order and owner, and the order payload includes maker, signer, tokenId, makerAmount, takerAmount, side, expiration, timestamp, builder, signature, salt, and signatureType.
- orderType supports GTC, FOK, GTD, and FAK; postOnly is only supported for GTC and GTD; deferExec defaults to false.
- Successful responses can be live, matched, or delayed, and matched responses include transaction hashes and trade IDs.
- Documented error cases include invalid payloads, owner/signature mismatches, banned addresses, closed-only mode, unauthorized requests, and cancel/post-only mode.

## Important Claims

- [CLM-0064] POST /order creates a new order and requires the L2 security headers.
- [CLM-0065] SendOrder requires order and owner, and the documented orderType, deferExec, and postOnly constraints are enforced by the schema.
- [CLM-0066] The endpoint returns live, matched, or delayed statuses, with matched responses carrying transaction hashes and trade IDs and documented validation/authentication errors.

## Limitations

The page does not describe full matching internals, settlement timing guarantees, or WebSocket trade propagation.

## Relevance to Invariant

This is the main source for order-entry payload shape and response handling. It is the most concrete API reference for order creation in this set.

## Comparison to SRC-0004

- Supports the existence of a signed order submission flow.
- Does not support a claim that the API can be bypassed by direct RPC submission.
- Does not provide the production-fill or latency claims that appear in `SRC-0004`.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
