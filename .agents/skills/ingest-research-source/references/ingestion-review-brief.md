# Ingestion Review Brief

Use this brief when spawning `ingestion-reviewer`.

## Scope

- Review only the files named in the task or, if no files are named, the staged diff.
- Do not perform repository-wide discovery unless the task explicitly asks for it.
- Do not modify files.

## Required Categories

- Source classification
- Metadata
- Evidence boundaries
- Claim strength
- Limitations
- Unsupported assertions
- Source-type-specific stop conditions

## Stop Conditions

- Stop after one pass through the requested files.
- Do not continue searching once each category has been covered.
- If a finding is not supported by the requested scope, mark it as out of scope instead of expanding the review.

## Output Format

- Return PASS or FAIL for each category.
- List concrete file paths and the reason for each FAIL.
- Keep the report concise and bounded.
