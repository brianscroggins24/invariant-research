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
- No promotion, commit, or push was performed.

## 2026-06-27

- Captured the approved official Polymarket documentation set as `SRC-0007` through `SRC-0018`.
- Copied the exact markdown captures into the canonical raw-source paths and registered their SHA-256 hashes.
- Created `SOURCE-SUMMARY-0006` through `SOURCE-SUMMARY-0017` and candidate claims `CLM-0045` through `CLM-0079`.
- Registered the 12 Polymarket sources as `pending-ingestion` and left the new summaries and claims at `review-required`.
- Added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed.
## 2026-06-27

- Captured the approved minimum official Kalshi documentation set as `SRC-0019` through `SRC-0034`.
- Copied the exact markdown captures into the canonical raw-source paths and registered their SHA-256 hashes.
- Created `SOURCE-SUMMARY-0018` through `SOURCE-SUMMARY-0033` and candidate claims `CLM-0080` through `CLM-0119`.
- Registered the 16 Kalshi sources as `pending-ingestion` and left the new summaries and claims at `review-required`.
- Added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed.
- No promotion, commit, or push was performed.

## 2026-06-28

- Promoted the Phase 2 source layer for `SRC-0003` through `SRC-0034` to active/reviewed status after completed validation and review.
- Promoted source summaries `SOURCE-SUMMARY-0002` through `SOURCE-SUMMARY-0033` to `reviewed`.
- Promoted claims `CLM-0005` through `CLM-0119` to `reviewed`.
- No artifacts were withheld; the completed Phase 2 source layer is ready for synthesis.

## 2026-06-28

- Created synthesis pages `CONCEPT-0001`, `CONCEPT-0002`, `CONCEPT-0003`, `THEORY-0001`, `STRATEGY-0001`, `PLATFORM-0001`, and `PLATFORM-0002` at `review-required`.
- Registered the synthesis pages in `registry/pages.yaml` and added them to `index.md`.
- The synthesis tree preserves source boundaries between primary research, practitioner interpretation, official documentation, and repository-level inference.

## 2026-06-28

- Promoted synthesis pages `CONCEPT-0001`, `CONCEPT-0002`, `CONCEPT-0003`, `THEORY-0001`, `STRATEGY-0001`, `PLATFORM-0001`, and `PLATFORM-0002` to `reviewed`.
- Updated `registry/pages.yaml`, the seven synthesis page frontmatter records, and `index.md` to match the reviewed status.
- No pages were withheld; the Phase 2 synthesis layer passed registry, link, and semantic review checks and is ready for final consistency audit.

## 2026-07-09

- Captured `SRC-0035` as the author-hosted PDF for "Makers and Takers: The Economics of the Kalshi Prediction Market" and verified that the artifact is complete and inspectable.
- Created `SOURCE-SUMMARY-0034` and candidate claims `CLM-0120` through `CLM-0132` at `review-required`.
- Registered `SRC-0035` as `pending-ingestion` and added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed.

## 2026-07-15

- Captured `SRC-0036` as the complete user-provided PDF for "Who Wins and Who Loses in Prediction Markets? Evidence from Polymarket" and verified that the artifact is complete and inspectable.
- Created `SOURCE-SUMMARY-0035` and candidate claims `CLM-0133` through `CLM-0143` at `review-required`.
- Registered `SRC-0036` as `pending-ingestion` and added the new source and source-summary entries to `index.md`.
- `SRC-0036` was ingested from a user-provided complete PDF artifact after SSRN acquisition was blocked in the agent environment. The current artifact, registry, summary, claims, links, and repository validators pass, but the original temporary capture-report file and pre-ID `next_ids.rb --capture-report` output were not preserved. This is documented as a process-proof gap for the source-level ingestion; no source was promoted in this batch.
- No promotion, commit, or push was performed.
- Captured `SRC-0037` as the complete user-provided PDF for "Prediction Market Accuracy: Crowd Wisdom or Informed Minority?" and verified that the artifact is complete and inspectable.
- Copied the exact PDF into the canonical raw-source path and registered its SHA-256 hash.
- Created `SOURCE-SUMMARY-0036` and candidate claims `CLM-0144` through `CLM-0153` at `review-required`.
- Registered `SRC-0037` as `pending-ingestion` and added the new source and source-summary entries to `index.md`.
- Captured `SRC-0038` as the complete user-provided PDF for "Exploring Decentralized Prediction Markets: Accuracy, Skill, and Bias on Polymarket" and verified that the artifact is complete and inspectable.
- Copied the exact PDF into the canonical raw-source path and registered its SHA-256 hash.
- Created `SOURCE-SUMMARY-0037` and candidate claims `CLM-0154` through `CLM-0163` at `review-required`.
- Registered `SRC-0038` as `pending-ingestion` and added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed.
- Captured `SRC-0039` as the complete user-provided PDF for "From Iran to Taylor Swift: Informed Trading in Prediction Markets" and verified that the artifact is complete and inspectable.
- Copied the exact PDF into the canonical raw-source path and registered its SHA-256 hash.
- Created `SOURCE-SUMMARY-0038` and candidate claims `CLM-0164` through `CLM-0170` at `review-required`.
- Registered `SRC-0039` as `pending-ingestion` and added the new source and source-summary entries to `index.md`.
- No promotion, commit, or push was performed.

## 2026-07-17

- Promoted `SRC-0035` through `SRC-0039` from `pending-ingestion` to `active`, promoted `SOURCE-SUMMARY-0034` through `SOURCE-SUMMARY-0038` from `review-required` to `reviewed`, and promoted `CLM-0120` through `CLM-0170` from `review-required` to `reviewed`.
- Updated `registry/sources.yaml`, `registry/pages.yaml`, `registry/claims.yaml`, the five source-summary frontmatter records, and `index.md` to reflect the reviewed source layer.
- `SRC-0036` retains the documented process-proof gap: the original temporary capture-report file and pre-ID `next_ids.rb --capture-report` output were not preserved, even though the current artifact and repository validators pass.
- Created `CONCEPT-0004` / `Market Accuracy and Price Discovery` at `review-required` to synthesize the reviewed Kalshi and Polymarket accuracy and price-discovery evidence from `SRC-0035` through `SRC-0038`.
- Created `CONCEPT-0005` / `Informed Trading and Surveillance` and `STRATEGY-0002` / `Liquidity Provision and Execution Quality` at `review-required` to extend the cross-paper synthesis around anomaly screening, identity limits, maker/taker economics, and execution-quality interpretation.
