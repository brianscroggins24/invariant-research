---
page_id: SOURCE-SUMMARY-0040
title: Get Market Orderbook
page_type: source-summary
status: reviewed
created_at: 2026-08-31
updated_at: 2026-08-31
source_id: SRC-0041
sources:
  - SRC-0041
related_pages:
  - PLATFORM-0002
  - CONCEPT-0002
tags:
  - kalshi
  - official-documentation
  - orderbook
  - market-data
  - authentication
  - fixed-point
  - read-only
---

# Source Summary

## Citation

Kalshi documentation. "Get Market Orderbook." Source ID: `SRC-0041`. Canonical URL: `https://docs.kalshi.com/api-reference/market/get-market-orderbook`. Captured 2026-08-31. No explicit publication or page-update date appears. `SRC-0022`, captured 2026-06-27, is the older same-page capture used only for version comparison.

## Source Type and Playbook

Official documentation / primary platform, analyzed under the `official-documentation` playbook. It is authority only for the Kalshi-local endpoint contract at capture time. Server addresses, authentication, schemas, limits, and errors are mutable.

## Purpose or Scope

The page documents one operation: `GET /markets/{ticker}/orderbook`, which retrieves the current order book for a specified Kalshi market (`SRC-0041`, lines 5-7 and 62-69). The captured path contains no POST, PUT, PATCH, DELETE, order-entry, cancellation, or mutation operation. This GET-only evidence does not authorize credential exposure, orders, or trading.

## Request Behavior

- `ticker` is a required string path parameter (`SRC-0041`, lines 70-71 and 103-110).
- `depth` is optional, integer, defaults to `0`, and has schema bounds `0..100` (`SRC-0041`, lines 72-84).
- The depth prose also says negative values retrieve all levels, conflicting with the schema minimum and validation tag. Negative depth must not be assumed supported.
- The page does not define whether depth applies independently per side or how a depth-limited snapshot may be combined with another response.

## Authentication

- The operation-level security stanza lists access-key, RSA-PSS signature, and millisecond-timestamp schemes together (`SRC-0041`, lines 98-101 and 182-197).
- The operation documents a `401` response described as authentication required (`SRC-0041`, lines 92-93 and 163-169).
- Although the OpenAPI document has top-level `security: []`, the operation-specific stanza and `401` support treating this endpoint as authenticated. The page does not explain precedence in prose.
- Credential scope, signing input, timestamp freshness, replay protection, rotation, and secret storage are outside this page and require separate reviewed authority.

## Response and Fixed-Point Behavior

- A successful response is JSON using `GetMarketOrderbookResponse` and requires `orderbook_fp` (`SRC-0041`, lines 85-91 and 112-119).
- `orderbook_fp` requires both `yes_dollars` and `no_dollars`, each an array of price levels (`SRC-0041`, lines 120-136).
- Each price level is exactly a two-string array `[dollars_string, fp]`, containing dollar price first and fixed-point contract quantity second (`SRC-0041`, lines 149-162).
- The example values do not establish universal precision, scale, normalization, range, or rounding.
- The page does not specify response timestamp, sequence, atomicity, freshness, duplicate levels, nullability, or exact empty-book semantics.

## Venue-Native Book Semantics

The endpoint describes active YES bids and NO bids only, not direct ask arrays. For a binary market it states that a YES bid at price `X` is equivalent to a NO ask at `100-X` with identical size (`SRC-0041`, lines 5-7 and 63-68). Any ask view is therefore derived and must not impersonate a published ask ladder. The prose says levels are best-to-worst but supplies no exact array sorting or tie rule.

## Documented Servers

The capture lists two production and two demo Trade API servers (`SRC-0041`, lines 21-29). It supplies no server priority, failover equivalence, data equivalence, or credential-portability guarantee.

## Errors

The operation documents `401`, `404`, and `500` (`SRC-0041`, lines 92-97 and 163-181). Their shared error schema contains optional `code`, `message`, and `details` strings with no required list or error-code enumeration (`SRC-0041`, lines 137-148). No retryability or recovery semantics are given.

## Important Claims

- [CLM-0179] The endpoint is `GET /markets/{ticker}/orderbook`.
- [CLM-0180] The operation requires the three Kalshi authentication headers.
- [CLM-0181] Four environment-specific base servers are documented.
- [CLM-0182] Ticker is a required string path parameter.
- [CLM-0183] Depth is optional with schema bounds `0..100`, while negative-depth prose conflicts.
- [CLM-0184] The response preserves YES and NO bids; asks are complementary derivations.
- [CLM-0185] A successful response requires `orderbook_fp`.
- [CLM-0186] Both side arrays are required.
- [CLM-0187] Each level has exact two-string price/quantity grammar.
- [CLM-0188] The operation documents `401`, `404`, and `500`.
- [CLM-0189] Error fields are optional strings with no stable enumeration.

## Comparison With `SRC-0022`

A direct byte-level text comparison found two substantive changes: the embedded OpenAPI version changes from `3.22.0` to `3.29.0`, and the optional `ErrorResponse.service` field in `SRC-0022` is absent from `SRC-0041`. Endpoint, servers, authentication, parameters, success schema, tuple grammar, and status mappings are otherwise unchanged.

The removed field is no longer documented; that does not prove a runtime server can never emit it. The version number is not a deployment date. Registry lifecycle promotion marks `SRC-0022` superseded by this source while retaining the immutable older capture.

## Invariant Interpretation

After review, downstream code may model this as an authenticated, read-only snapshot request, preserve price and quantity strings until exact decimal validation, retain YES and NO bid arrays, and label complementary asks as derived. This interpretation does not authorize secret persistence, write methods, orders, execution, or trading.

## Limitations and Unsupported Assertions

No snapshot timestamp, sequence, atomicity, freshness, pagination, stream recovery, retry, backoff, or rate-limit behavior is specified. The source does not support negative depth despite its conflicting prose, a separate per-level order-count value, example precision as a contract, response completeness beyond requested depth, server interchangeability, environment credential portability, or equivalence to another venue.

## Open Questions

- What are the formal fixed-point precision, range, and rounding rules?
- Is exact ordering or tie behavior documented?
- What snapshot timestamp, atomicity, and freshness semantics exist?
- Are read-only credential scopes available?
- How should unknown response and error fields be retained without weakening strict required-field validation?

## Review Notes

The complete source was reviewed. Direct findings, interpretation, uncertainty, and version comparison remain separated. No credentials were inspected and no request was sent. Independent ingestion review found no blocking issues; status is `reviewed`.
