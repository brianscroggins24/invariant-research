---
page_id: SOURCE-SUMMARY-0026
title: Orderbook Updates
page_type: source-summary
status: review-required
created_at: 2026-06-27
updated_at: 2026-06-27
source_id: SRC-0027
sources:
  - SRC-0027
related_pages: []
tags:
  - kalshi
  - official-documentation
  - websocket
  - orderbook

---

# Source Summary

## Citation

Kalshi documentation. "Orderbook Updates". Source ID: `SRC-0027`. Canonical URL: `https://docs.kalshi.com/websockets/orderbook-updates.md`.

## Source Type

Official documentation / primary platform. This page documents a Kalshi API or websocket surface and should be treated as platform reference material.

## Purpose or Scope

Documents the live orderbook stream, including the snapshot-first flow and incremental deltas.

## Key Facts

- The channel sends `orderbook_snapshot` first and then incremental `orderbook_delta` updates.
- Snapshot and delta payloads both carry `sid` and `seq` and are keyed by `market_ticker` and `market_id`.
- Snapshots carry `yes_dollars_fp` and `no_dollars_fp`; deltas carry `price_dollars`, `delta_fp`, `side`, and optional attribution fields.

## Important Claims

- [CLM-0101] The orderbook channel sends `orderbook_snapshot` first and then incremental `orderbook_delta` updates.
- [CLM-0102] Snapshot and delta messages both carry `sid` and `seq`; snapshot messages expose `yes_dollars_fp` and `no_dollars_fp`, while delta messages expose `price_dollars`, `delta_fp`, `side`, and market identifiers.
- [CLM-0103] The docs say `seq` should be checked for snapshot/delta consistency, but they do not specify a gap-recovery algorithm for missed updates.
## Limitations

- The page documents consistency metadata but not a full recovery procedure.
- The page does not document removal-by-zero explicitly as a general rule.

## Relevance to Invariant

- This is the main real-time input for orderbook reconstruction.
- The `seq` field is critical for detecting gaps in a downstream consumer.

## Comparison to Polymarket / `SRC-0004`

- Kalshi’s orderbook stream is snapshot-plus-delta based; do not infer a more complete recovery guarantee than the docs provide.
- Nothing here supports `SRC-0004` claims about direct execution direction or atomic multi-leg execution.

## Open Questions

- What should a consumer do when a `seq` gap is detected but the docs do not define recovery?
- Should snapshot and delta payloads be normalized into the same internal orderbook event type?

## Review Notes

Captured from official docs on 2026-06-27. Exact raw Markdown capture from the official Kalshi docs; captured on 2026-06-27. No page-level last-updated date was present in the markdown capture.
