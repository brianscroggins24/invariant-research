# Log

## 2026-06-22

- Established the initial repository governance layer for `invariant-research`.
- Defined repository scope, provenance rules, review flow, adaptive structure boundaries, and the separation between research knowledge and executable trading logic.
- Initialized registry stubs for sources, pages, and claims.
- Added the source record template.
- Added the source summary template.
- Added the source ingestion process page.
- Registered `PROCESS-0001`.
- Added the process link to `index.md`.
- Updated `AGENTS.md` to recognize process pages and require the canonical ingestion workflow.
- No external research sources have been ingested yet.

## 2026-06-22

- Registered `SRC-0001` for Andrej Karpathy's `LLM Wiki`.
- Captured the immutable raw source in `raw/sources/SRC-0001-karpathy-llm-wiki.md`.
- Registered the SHA-256 hash for the captured source.
- Created `SOURCE-SUMMARY-0001`.
- Registered claims `CLM-0001` through `CLM-0004`.
- Added the source and summary to `index.md`.
- `SRC-0001` remains `pending-ingestion`.
- The source summary and claims remain `review-required`.
- No source-derived knowledge has yet been promoted to reviewed status.

## 2026-06-22

- `SRC-0001` was promoted to `active`.
- `SOURCE-SUMMARY-0001` was promoted to `reviewed`.
- `CLM-0001` through `CLM-0004` were promoted to `reviewed`.
- The first source ingestion is complete.

## 2026-06-23

- The original `SRC-0001` capture was found to have collapsed Markdown formatting.
- `SRC-0001` was retained and marked `superseded`.
- An exact raw Markdown capture was added as `SRC-0002`.
- `SRC-0002` was marked `active`.
- The existing source summary and claims were updated to reference `SRC-0002`.
- `PROCESS-0001` received its missing creation and update dates.
- No substantive source interpretation or claim wording changed.

## 2026-06-23

- Captured the canonical arXiv PDF for `Unravelling the Probabilistic Forest: Arbitrage in Prediction Markets` as `SRC-0003`.
- Ran the parent hash script and registered SHA-256 `9b55dcf818ff6a7d18d102b4711d86b9c49e374994de4ffd77690469a7d0e930`.
- Created `SOURCE-SUMMARY-0002` and candidate claims `CLM-0005` through `CLM-0013`.
- Registered `SRC-0003` as `pending-ingestion` and left the source summary and claims at `review-required`.
- Ran baseline and post-write deterministic validation successfully.
- No synthesis, concept, platform, or strategy pages were created.
- No promotion, commit, or push was performed.

## 2026-06-25

- Captured the authenticated Obsidian Web Clipper Markdown article `The Math Needed for Trading on Polymarket (Complete Roadmap)` as `SRC-0004`.
- Ran the parent hash script and registered the canonical SHA-256 for the copied raw Markdown artifact.
- Created `SOURCE-SUMMARY-0003` and candidate claims `CLM-0014` through `CLM-0023`.
- Registered `SRC-0004` as `pending-ingestion` and left the source summary and claims at `review-required`.
- Added the new source and source-summary entries to `index.md`.
- Ran baseline and post-write deterministic validation successfully.
- No synthesis, concept, platform, or strategy pages were created.
- No promotion, commit, or push was performed.

## 2026-06-27

- Captured the canonical arXiv PDF for `Arbitrage-Free Combinatorial Market Making via Integer Programming` as `SRC-0005`.
- Verified the PDF with `pypdf`, confirmed it is a complete 21-page, text-readable document, and registered the canonical SHA-256 `58170e2db5eae346af6fc198fcdd3b8524ff95f4d0da5bc9370cb8591593180c`.
- Created `SOURCE-SUMMARY-0004` and candidate claims `CLM-0024` through `CLM-0034`.
- Registered `SRC-0005` as `pending-ingestion` and left the source summary and claims at `review-required`.
- Added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed yet.

## 2026-06-27

- Captured the complete Bloomberg Opinion Markdown article `I Built an AI Trading Platform in Six Days. That’s Terrifying` as `SRC-0006`.
- Ran baseline validation, allocated provisional IDs, copied the exact raw Markdown into the canonical raw-source path, and registered the canonical SHA-256 `bf637a6e98afd94e021286762ababfcd64eaaa75ad20b934746e54ea8d4eb234`.
- Created `SOURCE-SUMMARY-0005` and candidate claims `CLM-0035` through `CLM-0044`.
- Registered `SRC-0006` as `pending-ingestion` and left the source summary and claims at `review-required`.
- Added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed.
