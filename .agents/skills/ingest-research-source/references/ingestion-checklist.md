# Ingestion Checklist

1. Read `AGENTS.md` and `wiki/source-ingestion.md`.
2. Inspect `registry/sources.yaml`, `registry/pages.yaml`, `registry/claims.yaml`, `index.md`, and `log.md`.
3. Run `scripts/next_ids.rb` to identify the next available source, summary-page, and claim IDs.
4. Determine whether the source is accessible, reference-only, or inaccessible.
5. Capture the exact raw source when legal and technical access allow it.
6. Save raw bytes under `raw/sources/`, then run `scripts/hash_source.sh <path>` to compute SHA-256.
7. Register the source as `pending-ingestion` first.
8. Create or update the source-summary page from `templates/source-summary.md`.
9. Extract candidate claims with precise locators.
10. Register pages and claims, keeping new artifacts at `review-required`.
11. Update `index.md` and `log.md` after the registry edits are consistent.
12. Run `scripts/validate_ingestion.rb` to validate YAML, file paths, hashes, and references before finishing.

## Script usage

- `scripts/next_ids.rb`
- `scripts/hash_source.sh raw/sources/SRC-0002-example.md`
- `scripts/validate_ingestion.rb`
