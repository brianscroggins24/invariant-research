# Ingestion Checklist

1. Read `AGENTS.md` and `wiki/source-ingestion.md`.
2. Inspect `registry/sources.yaml`, `registry/pages.yaml`, `registry/claims.yaml`, `index.md`, and `log.md`.
3. Ask `source-capturer` to perform an acquisition check, and require a structured capture report for the attempt.
4. Validate the capture report before allocating IDs. If acquisition fails, the artifact is incomplete, or the capture report fails, stop immediately, report the remaining legitimate capture options, and do not touch registries, `index.md`, or `log.md`.
5. Only after a passing capture report succeeds, run `scripts/next_ids.rb --capture-report capture-report.md` to identify the next available source, summary-page, and claim IDs.
6. After ID allocation, copy or move the exact artifact into `raw/sources/`, then run `scripts/hash_source.sh <path>` to compute SHA-256.
7. Register the source as `pending-ingestion` first.
8. Create or update the source-summary page from `templates/source-summary.md`.
9. Extract candidate claims with precise locators.
10. Register pages and claims, keeping new artifacts at `review-required`.
11. Update `index.md` and `log.md` after the registry edits are consistent.
12. Run `scripts/validate_ingestion.rb` to validate YAML, file paths, hashes, dates, versions, and references before finishing.
13. Run `scripts/validate_links.rb` on governed Markdown files when reviewing link integrity.
14. Run `scripts/validate_promotion.rb` only for status-only promotion diffs.

## Script usage

- `scripts/validate_capture_report.rb capture-report.md`
- `scripts/next_ids.rb --capture-report capture-report.md` after capture succeeds
- `scripts/next_ids.rb --registry-inspection-only` only for explicit maintenance inspection, never for ingestion
- `scripts/hash_source.sh raw/sources/SRC-0002-example.md`
- `scripts/validate_ingestion.rb`

## Boundary checks

- Canonical URL is accessible and capture succeeds: ingestion proceeds and a source ID is assigned only after a complete artifact exists.
- Canonical URL cannot be accessed and no local artifact exists: ingestion stops, no ID is consumed, and no registry or log changes occur.
- Canonical URL cannot be accessed but the user provides a complete Markdown capture: the local artifact is treated as the raw source, the parent allocates the next ID, and ingestion proceeds normally.
- Only partial snippets are available: ingestion stops and no source is registered.
- A complete third-party article or summary may be ingested separately only when it is deliberately selected and classified as a secondary source.
