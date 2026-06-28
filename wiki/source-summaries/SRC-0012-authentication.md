---
page_id: SOURCE-SUMMARY-0011
title: Authentication
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0012
sources:
  - SRC-0012
related_pages: []
tags:
  - polymarket
  - official-documentation
  - authentication
  - api
  - security
---

# Source Summary

## Citation

Polymarket documentation. "Authentication." Source ID: `SRC-0012`. Canonical URL: `https://docs.polymarket.com/api-reference/authentication.md`.

## Source Type

Official documentation / primary platform. This page defines the two-level authentication model for the CLOB API.

## Purpose or Scope

The page explains which endpoints are public, which require authentication, how API credentials are created, and how request signatures work.

## Key Facts

- The CLOB API uses L1 private-key authentication and L2 API-key authentication.
- Gamma API, Data API, and CLOB read endpoints are public; trading endpoints require all five POLY_* L2 headers.
- L1 uses an EIP-712 signature over a request header to create or derive API credentials.
- L2 uses apiKey, secret, and passphrase values with HMAC-SHA256 request signing.
- Even with L2 headers, user-order creation still requires signing the order payload.
- Signature types include EOA, POLY_PROXY, GNOSIS_SAFE, and POLY_1271; new API users are directed to deposit wallets with POLY_1271.

## Important Claims

- [CLM-0061] The CLOB API uses L1 and L2 authentication, with public Gamma/Data/CLOB-read endpoints and authenticated trading endpoints.
- [CLM-0062] L1 uses EIP-712 signing to create or derive API credentials, and L2 uses apiKey/secret/passphrase with HMAC-SHA256.
- [CLM-0063] Trading requests require the five POLY_* headers, user-order creation still requires signing the order payload, and POLY_1271 is the recommended signature type for new API users.

## Limitations

This page does not describe fee calculation, WebSocket market-data payloads, or resolution mechanics.

## Relevance to Invariant

This is the primary source for request authentication and signature separation. It is important for distinguishing signer identity, API identity, and execution authorization.

## Comparison to SRC-0004

- Supports the distinction between signing and authenticated API access.
- Does not support any claim that direct RPC submission bypasses the API.
- Does not describe production trading systems or order execution guarantees.

## Review Notes

Captured from the official docs on 2026-06-27. No page-level last-updated date was present in the markdown capture.
