---
name: ingest-research-source
description: Ingest, register, capture, summarize, and review research sources for invariant-research. Use when the user asks to ingest, register, capture, summarize, or review a research source, paper, article, documentation page, social thread, or market-rules document.
---

# Ingest Research Source

## Overview

Use this skill to turn a source into governed repository artifacts: raw capture, registry entries, a source summary, candidate claims, and index/log updates.

Follow the repository governance in `AGENTS.md` and the source-ingestion process in `wiki/source-ingestion.md` before making edits.

## Workflow Orchestration

When the user asks for parallel or subagent-based ingestion, the parent agent must explicitly spawn the subagents in this order:

1. Read `AGENTS.md` and `wiki/source-ingestion.md`, then inspect repository state.
2. Run `scripts/next_ids.rb` to assign provisional source, summary-page, and claim ID ranges.
3. Run `scripts/validate_ingestion.rb` as a baseline repository check. A nonzero result blocks progression.
4. Spawn `source-capturer`.
5. If capture succeeds and legitimate accessible content exists, run `scripts/hash_source.sh` on the captured raw file, then spawn `source-analyst` and `claim-extractor` in parallel.
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

If source capture fails or the source is inaccessible, stop before analysis unless there is legitimate accessible content to analyze.

Do not automatically promote statuses. Leave new artifacts at `review-required` unless repository policy explicitly requires a different state.
In a dry run, execute the baseline validation only; skip `scripts/hash_source.sh` and skip the post-ingestion validation because no raw file or new artifacts exist.
Use `scripts/hash_source.sh` for the canonical SHA-256 after capture, and use `scripts/validate_ingestion.rb` before ingestion and again after the shared writes.

## Operating Rules

- Read `AGENTS.md` and `wiki/source-ingestion.md` before acting.
- Inspect `registry/sources.yaml`, `registry/pages.yaml`, `registry/claims.yaml`, `index.md`, and `log.md` before assigning IDs.
- Never overwrite an immutable raw source. Store corrected or refreshed content as a new source version.
- Preserve exact raw bytes when capture is possible. The parent records the canonical SHA-256 after running `scripts/hash_source.sh`.
- The parent owns the canonical hash by running `scripts/hash_source.sh`; the source-capturer reports capture metadata and limitations only.
- If the source is inaccessible or reference-only, preserve that status and do not invent raw content.
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
