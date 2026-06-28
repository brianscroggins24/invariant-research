---
page_id: SOURCE-SUMMARY-0018
title: Get Series
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0019
sources:
  - SRC-0019
related_pages: []
tags:
  - kalshi
  - official-documentation
  - series
  - event-model

---

# Source Summary

## Citation

Kalshi documentation. "Get Series". Source ID: `SRC-0019`. Canonical URL: `https://docs.kalshi.com/api-reference/market/get-series.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Defines what a series is and which metadata the API exposes for series-level retrieval.

## Key Facts

- A series is a template for recurring events that share the same format and rules.
- The Series schema exposes series-level settlement sources, contract URLs, category, tags, and fee metadata.
- The response also exposes `volume_fp` and `last_updated_ts` for the series record.

## Important Claims

- [CLM-0080] A series is a template for recurring events and defines the structure, settlement sources, and metadata applied to each recurring event instance.
- [CLM-0081] The Series schema includes `ticker`, `frequency`, `title`, `category`, `tags`, `settlement_sources`, `contract_url`, `contract_terms_url`, `fee_type`, `fee_multiplier`, `volume_fp`, and `last_updated_ts`.
## Limitations

- This page is a read endpoint and does not describe order execution or settlement mechanics in detail.
- It does not map Kalshi series terminology onto Polymarket concepts.

## Relevance to Invariant

- Useful for data modeling because series are the top-level grouping for recurring event instances.
- The fee fields and settlement-source metadata are relevant for adapter design and provenance tracking.

## Comparison to Polymarket / `SRC-0004`

- Kalshi uses series / event / market terminology; do not collapse it into Polymarket condition / outcome-token terminology without qualification.
- Nothing on this page supports the Bregman-projection or Frank-Wolfe execution claims in `SRC-0004`.

## Open Questions

- How should downstream code represent series-level fee metadata when an event-level override exists?
- Which series fields should be treated as stable identifiers versus mutable metadata?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
