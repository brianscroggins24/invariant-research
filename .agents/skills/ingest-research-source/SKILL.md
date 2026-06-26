---
name: ingest-research-source
description: Ingest, register, capture, summarize, and review research sources for invariant-research. Use when the user asks to ingest, register, capture, summarize, or review a research source, paper, article, documentation page, social thread, or market-rules document.
---

# Ingest Research Source

## Overview

Use this skill to turn a complete, inspectable raw artifact into governed repository artifacts: temporary acquisition capture, canonical raw capture, registry entries, a source summary, candidate claims, and index/log updates.

Follow the repository governance in `AGENTS.md` and the source-ingestion process in `wiki/source-ingestion.md` before making edits.

## Workflow Orchestration

When the user asks for parallel or subagent-based ingestion, the parent agent must explicitly spawn the subagents in this order:

1. Read `AGENTS.md` and `wiki/source-ingestion.md`, then inspect repository state.
2. Run `scripts/validate_ingestion.rb` as a baseline repository check. A nonzero result blocks progression.
3. Spawn `source-capturer` to perform an acquisition check.
4. If and only if a complete, inspectable raw artifact exists, run `scripts/next_ids.rb` to assign provisional source, summary-page, and claim ID ranges.
5. After capture succeeds and the parent has copied or moved the exact artifact into the canonical raw-source path, run `scripts/hash_source.sh` on the canonical raw file, then spawn `source-analyst` and `claim-extractor` in parallel.
6. Wait for both results.
7. Reconcile the results and write the shared artifacts:
   - source registry entry;
   - source summary;
   - claims;
   - page registry entry;
   - `index.md`;
   - `log.md`.
8. Run `scripts/validate_ingestion.rb` again after the writes. A nonzero result blocks progression.
9. Spawn `ingestion-reviewer`.
10. Report review findings and stop without promotion, commit, or push.

If acquisition fails, the content is blocked, or only partial material is available, stop before analysis unless there is a complete inspectable raw artifact to work from. Report the legitimate capture options that remain and do not consume an ID.

Do not automatically promote statuses. Leave new artifacts at `review-required` unless repository policy explicitly requires a different state.
In a dry run, execute the baseline validation only; skip `scripts/hash_source.sh`, skip `scripts/next_ids.rb`, and skip the post-ingestion validation because no raw file or new artifacts exist.
Use `scripts/hash_source.sh` for the canonical SHA-256 after capture, and use `scripts/validate_ingestion.rb` before ingestion and again after the shared writes.

## Operating Rules

- Read `AGENTS.md` and `wiki/source-ingestion.md` before acting.
- Inspect `registry/sources.yaml`, `registry/pages.yaml`, `registry/claims.yaml`, `index.md`, and `log.md` before assigning IDs, but do not assign those IDs until a complete raw artifact has been captured.
- Never overwrite an immutable raw source. Store corrected or refreshed content as a new source version.
- Preserve exact raw bytes when capture is possible. The parent records the canonical SHA-256 after running `scripts/hash_source.sh` on the canonical raw file.
- The parent owns the canonical hash by running `scripts/hash_source.sh`; the source-capturer reports capture metadata and limitations only.
- A URL alone is not a source. If the source cannot be fully captured, stop without registering it.
- Do not register uncaptured, contentless, or placeholder source records.
- Search snippets, partial previews, and cached fragments cannot substitute for the original source.
- A complete third-party article or summary may be ingested separately when it is intentionally selected and accurately classified as a secondary source.
- Distinguish source findings, Invariant interpretations, and uncertainty in the summary and claims.
- Only the parent agent writes shared YAML registries.
- Parallel agents must not assign final IDs.
- Use the deterministic helper scripts instead of reimplementing ID, hash, or validation logic ad hoc.
- Do not promote, commit, or push unless the user separately instructs it.

## Delegation

Use subagents for:

- source capture
- source analysis
- claim extraction
- read-only consistency review

Keep the parent agent responsible for:

- assigning IDs
- resolving duplicate or competing source records
- writing and editing registries
- updating `index.md` and `log.md`
- applying final repository edits
- spawning subagents only when explicitly requested by the task

## References

- [Ingestion checklist](references/ingestion-checklist.md)
- [Review rubric](references/review-rubric.md)
