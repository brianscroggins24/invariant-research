---
name: ingest-research-source
description: Ingest, register, capture, summarize, and review research sources for invariant-research. Use when the user asks to ingest, register, capture, summarize, or review a research source, paper, article, documentation page, social thread, or market-rules document.
---

# Ingest Research Source

## Overview

Use this skill to turn a complete, inspectable raw artifact into governed repository artifacts: temporary acquisition capture, a structured capture report, canonical raw capture, registry entries, a source summary, candidate claims, and index/log updates.

Follow the repository governance in `AGENTS.md` and the source-ingestion process in `wiki/source-ingestion.md` before making edits.

Before source analysis begins, select exactly one primary evidence playbook:

- `references/academic-research.md`
- `references/official-documentation.md`
- `references/practitioner-content.md`
- `references/journalism.md`

If a source genuinely spans multiple classes, keep the strictest applicable playbook as primary and use any secondary playbook only to narrow the evidence boundary.

## Workflow Orchestration

When the user asks for parallel or subagent-based ingestion, the parent agent must explicitly spawn the subagents in this order:

1. Read `AGENTS.md` and `wiki/source-ingestion.md`, then inspect repository state.
2. Run `scripts/validate_ingestion.rb` as a baseline repository check. A nonzero result blocks progression.
3. Select exactly one primary playbook for the source, then spawn `source-capturer` to perform an acquisition check and produce a structured capture report that identifies the playbook and any source-type ambiguity.
4. Validate the capture report with `ruby .agents/skills/ingest-research-source/scripts/validate_capture_report.rb --file capture-report.md`. Only a passing capture report permits the parent to run `ruby .agents/skills/ingest-research-source/scripts/next_ids.rb --capture-report capture-report.md`.
5. If and only if a complete, inspectable raw artifact exists and the capture report passes, run `ruby .agents/skills/ingest-research-source/scripts/next_ids.rb --capture-report capture-report.md` to assign provisional source, summary-page, and claim ID ranges.
6. After capture succeeds and the parent has copied or moved the exact artifact into the canonical raw-source path, run `scripts/hash_source.sh` on the canonical raw file, then spawn `source-analyst` and `claim-extractor` in parallel.
7. Wait for both results.
8. Reconcile the results and write the shared artifacts:
   - source registry entry;
   - source summary;
   - claims;
   - page registry entry;
   - `index.md`;
   - `log.md`.
9. Run `scripts/validate_ingestion.rb` again after the writes. A nonzero result blocks progression.
10. Use `scripts/validate_links.rb` and `scripts/validate_promotion.rb` for the relevant review and promotion gates when those phases apply.
11. Spawn `ingestion-reviewer` with the specific staged files or the review brief in `references/ingestion-review-brief.md`, and require one bounded pass only.
12. Report review findings and stop without promotion, commit, or push.

If acquisition fails, the content is blocked, or only partial material is available, stop before analysis unless there is a complete inspectable raw artifact to work from. Report the legitimate capture options that remain and do not consume an ID.

Do not automatically promote statuses. Leave new artifacts at `review-required` unless repository policy explicitly requires a different state.
In a dry run, execute the baseline validation only; skip `scripts/hash_source.sh`, skip `ruby .agents/skills/ingest-research-source/scripts/next_ids.rb --capture-report ...`, and skip the post-ingestion validation because no raw file or new artifacts exist.
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
- Use `ruby .agents/skills/ingest-research-source/scripts/validate_capture_report.rb --file capture-report.md` to gate ID allocation on a passing capture report.
- Use `scripts/validate_links.rb` to catch broken local Markdown links before review.
- Use `scripts/validate_promotion.rb` to ensure staged promotion diffs are status-only when promotion is requested.
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

- [Capture report template](references/capture-report.md)
- [Academic research playbook](references/academic-research.md)
- [Official documentation playbook](references/official-documentation.md)
- [Practitioner content playbook](references/practitioner-content.md)
- [Journalism playbook](references/journalism.md)
- [Ingestion checklist](references/ingestion-checklist.md)
- [Review rubric](references/review-rubric.md)
- [Ingestion review brief](references/ingestion-review-brief.md)
