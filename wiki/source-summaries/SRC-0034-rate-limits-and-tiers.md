---
page_id: SOURCE-SUMMARY-0033
title: Rate Limits and Tiers
page_type: source-summary
status: reviewed
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0034
sources:
  - SRC-0034
related_pages: []
tags:
  - kalshi
  - official-documentation
  - rate-limits

---

# Source Summary

## Citation

Kalshi documentation. "Rate Limits and Tiers". Source ID: `SRC-0034`. Canonical URL: `https://docs.kalshi.com/getting_started/rate_limits.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Explains Kalshi’s token-bucket rate limits, tier budgets, burst behavior, and tier-qualification rules.

## Key Facts

- Every authenticated request costs tokens, and sustained rate is budget divided by cost; the default cost is 10 tokens.
- Read and Write are separate token buckets, REST and FIX drain the same buckets, and the buckets refill continuously with burst capacity.
- The page lists current event-contract tier budgets and explains that higher tiers can be earned by volume or assigned manually.

## Important Claims

- [CLM-0117] Every authenticated request costs tokens; sustained rate is budget ÷ cost; the default request cost is 10 tokens; and Read/Write are separate buckets that REST and FIX both drain.
- [CLM-0118] Kalshi rate limits use token buckets with burst capacity and no cooldown, and 429 responses do not include `Retry-After` or `X-RateLimit-*` headers.
- [CLM-0119] The current event-contract tier budgets are Basic 200/100, Advanced 300/300, Expert 600/600, Premier 1000/1000, Paragon 2000/2000, Prime 4000/4000, and Prestige 6000/8000, with higher tiers earned by volume or assigned manually.
## Limitations

- Rate limits are explicitly time-sensitive and should be refreshed against the live docs before production use.
- Batch requests are billed per item rather than as a discounted bundle.

## Relevance to Invariant

- This page is required for throttling and capacity planning.
- The tier and burst rules matter for adapter load-shedding and retry policy.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s rate-limit model is token-bucket based and should not be inferred from Polymarket docs.
- The page does not support any claim that requests are queued rather than rejected when the bucket is empty.

## Open Questions

- Should downstream code cache tier budgets or query them on startup and periodically thereafter?
- How should a client budget for bursts across REST and FIX if both share the same buckets?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
