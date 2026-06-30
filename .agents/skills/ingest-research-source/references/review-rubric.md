# Review Rubric

Use this rubric to judge whether a source ingestion pass is ready for review.

## Required checks

- The raw source file exists at the registered local path.
- The raw source was not overwritten.
- The content hash matches the captured bytes.
- A structured capture report passed before ID allocation for the ingested source.
- The source ID was allocated only after a complete inspectable raw artifact existed.
- The source record status is correct for the current phase.
- The source summary points to the active source version.
- Claims reference the correct source and locator.
- `index.md` and `log.md` reflect the correction or ingest.
- YAML parses successfully.
- Every referenced file exists.
- Local Markdown links resolve from the file that contains them.
- Promotion-only diffs change only status fields and appended log entries.

## Quality checks

- The summary separates explicit source statements from Invariant interpretation.
- Claims use precise locators and avoid broad paraphrase.
- Uncertainty stays visible instead of being collapsed away.
- Duplicate or superseded sources are linked explicitly.
- The review notes explain provenance corrections when a source version changes.

## Reject or revise when

- A raw capture is reconstructed from memory instead of bytes.
- A URL, partial preview, cached fragment, or third-party summary was registered as a source.
- The capture report says the artifact is incomplete or uninspectable but ingestion continues anyway.
- A source version is overwritten instead of versioned.
- Claims or summary wording drift from the source without justification.
- A file reference or registry entry points to a missing path.
- The ingest introduces unreviewed assertions as if they were established fact.
