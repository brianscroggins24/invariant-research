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

## 2026-07-17

- Promoted `CONCEPT-0004` / `Market Accuracy and Price Discovery`, `CONCEPT-0005` / `Informed Trading and Surveillance`, and `STRATEGY-0002` / `Liquidity Provision and Execution Quality` to `reviewed` after synthesis review and validation.

## 2026-08-31

- Captured the official Kalshi `API Keys` documentation as `SRC-0040` using the `official-documentation` playbook.
- Copied the exact 6,159-byte Markdown artifact into immutable raw storage and registered SHA-256 `96bb49b6c45f946489a0a207cc93e3987e1e6aa5ca2da5111db17982274fc5a4`.
- Created `SOURCE-SUMMARY-0039` and candidate claims `CLM-0171` through `CLM-0178` at `review-required`.
- Registered `SRC-0040` as `pending-ingestion`. The material informs a bounded authenticated read-only Kalshi `GET` boundary and does not authorize credential use or trading.
- No promotion, commit, or push was performed.
- Captured the refreshed official Kalshi `Get Market Orderbook` page as `SRC-0041`, version 2, superseding candidate `SRC-0022` after review.
- Preserved the exact 6,947-byte artifact and registered SHA-256 `f8d82f48e12694c124d284dade755663799efc27121b45da790118694905eba4`.
- Created `SOURCE-SUMMARY-0040` and candidate claims `CLM-0179` through `CLM-0189` at `review-required`.
- The refresh makes the authenticated GET boundary explicit in the reviewed pipeline and preserves the internal negative-depth inconsistency. No credential use or trading behavior is authorized.
- No promotion, commit, or push was performed.
- Promoted `SRC-0040` and `SRC-0041` to active after independent ingestion review found no blocking issues.
- Promoted `SOURCE-SUMMARY-0039`, `SOURCE-SUMMARY-0040`, and `CLM-0171` through `CLM-0189` to `reviewed`.
- Marked `SRC-0022` and `SOURCE-SUMMARY-0021` superseded by the refreshed source layer while preserving immutable history.
- Updated unchanged reviewed order-book claims and synthesis citations from `SRC-0022` to `SRC-0041`.
- This establishes reviewed prediction-market evidence for authenticated Kalshi order-book `GET` access; it does not authorize credential exposure, writes, orders, execution, risk, or trading.
- No commit or push was performed.
- Reverified the active Polymarket `SRC-0014` endpoint capture on 2026-08-31; the current 5,690-byte artifact was byte-identical and retained SHA-256 `fd98e9bea50208a07d4ea51a8d03e2048cb6cbf4db70149fb17deda8770815f7`, so no duplicate source ID was allocated.
- Refreshed reviewed Polymarket and Kalshi platform provenance metadata and added reciprocal Kalshi authentication synthesis for `SRC-0040` and `CLM-0171` through `CLM-0178`.

## 2026-09-02

- Captured the official Kalshi `API Environments and Endpoints` page as `SRC-0042` under the `official-documentation` playbook.
- Preserved the exact 3,509-byte Markdown artifact with SHA-256 `73509a19902422f651f5b2d540d3e033e7c0633c082486cf364d5429bf631e48`.
- Registered `SRC-0042` as `pending-ingestion` and created `SOURCE-SUMMARY-0041` plus candidate claims `CLM-0190` through `CLM-0193` at `review-required`.
- The source directly addresses environment credential separation, recommended versus compatibility origins, and signed-path host/query exclusion. It does not authorize credentials, failover, writes, or trading.
- No promotion, commit, or push was performed.
- Captured the official Kalshi `Generate API Key` endpoint page as `SRC-0043` under the `official-documentation` playbook.
- Preserved the exact 7,664-byte Markdown artifact with SHA-256 `254c5d2edead92a631d858a27f6e1ae84748a3d83282931b52c9cdb382efdad5`.
- Registered `SRC-0043` as `pending-ingestion` and created `SOURCE-SUMMARY-0042` plus candidate claims `CLM-0194` through `CLM-0196` at `review-required`.
- The source documents read/write and child scopes and warns through its schema that omitted scopes default to broad read/write access. No key-generation call or credential inspection occurred.
- No promotion, commit, or push was performed.
- Captured the official Kalshi `Get API Keys` endpoint page as `SRC-0044` under the `official-documentation` playbook.
- Preserved the exact 6,589-byte Markdown artifact with SHA-256 `ed7016715ea3978bcf6cf7dc94b0542c88b37d16e1c52bfc652a6a875b5fe82e`.
- Registered `SRC-0044` as `pending-ingestion` and created `SOURCE-SUMMARY-0043` plus candidate claim `CLM-0197` at `review-required`.
- The documented response exposes granted scope labels for returned keys, but no authenticated request or credential inspection was performed and runtime enforcement remains unverified.
- No promotion, commit, or push was performed.
- Captured the official Kalshi `Quick Start: Market Data` guide as `SRC-0045` under the `official-documentation` playbook.
- Preserved the exact 8,454-byte Markdown artifact with SHA-256 `31dec99d496b8343d2fa0613e9f7f1f7a67c4e82b1b55b7a1041e480079ae5f0`.
- Registered `SRC-0045` as `pending-ingestion` and created `SOURCE-SUMMARY-0044` plus candidate claims `CLM-0198` and `CLM-0199` at `review-required`.
- The guide explicitly presents the REST order-book request as unauthenticated, conflicting with active `SRC-0041` operation-level security. The conflict remains visible and unresolved; no live API request or credential use occurred.
- No promotion, commit, or push was performed.

## 2026-09-02

- Promoted `SRC-0042` through `SRC-0045` from `pending-ingestion` to `active` after completed validation and independent review.
- Promoted `SOURCE-SUMMARY-0041` through `SOURCE-SUMMARY-0044` and `CLM-0190` through `CLM-0199` from `review-required` to `reviewed`.
- Preserved the unresolved authentication conflict between `SRC-0041` and `SRC-0045`; no live request, credential access, synthesis update, commit, or push was performed.
