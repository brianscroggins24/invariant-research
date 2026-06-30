# Official Documentation Playbook

## Purpose

Use this playbook for platform documentation, API references, concept pages, and lifecycle docs published by the platform operator.

## Source Classification

- Selected playbook: `official-documentation`
- Registry source_type: `official-documentation`
- Authority: `primary-platform`
- Treat the official page as the authority for venue-local behavior only.

## Acquisition Requirements

- Capture one source per approved official page.
- Use the official domain only.
- Capture the complete page artifact.
- Record the capture date.
- Do not use snippets, previews, or reconstructed pages.

## Metadata Requirements

- Record `source_type: official-documentation`.
- Record `authority: primary-platform`.
- Record a retrieval date.
- Record a publication or update date only when the page explicitly provides one.
- Do not substitute the retrieval date for a missing publication date.

## Summary Requirements

Separate:

- stable conceptual model;
- API request behavior;
- API response behavior;
- authentication;
- lifecycle behavior;
- mutable limits;
- examples that are not guarantees;
- documented ambiguities.

## Claim Requirements

- Use capture-date-scoped claims for mutable facts.
- Include the exact page locator.
- Include documentation update date when available.
- Do not infer ordering guarantees, recovery behavior, atomicity, timing guarantees, settlement architecture, or cross-platform equivalence.

## Cross-Source Boundaries

Keep venue-local terminology separate.

- Polymarket terms such as `condition`, `outcome token`, `offchain matching`, and `onchain settlement` remain Polymarket-specific unless the page explicitly says otherwise.
- Kalshi terms such as `series`, `event`, `market`, `YES/NO bid books`, fixed-point fields, and exchange-managed lifecycle remain Kalshi-specific.
- Do not import one venue’s architecture into the other venue’s documentation.

## Required Limitations

- API fields, channels, fees, and limits are mutable.
- Examples are not contractual guarantees unless the page says they are.
- Missing sequencing or recovery detail must remain an ambiguity rather than a guessed implementation rule.

## Stop Conditions

Stop when:

- the page appears deprecated or superseded;
- canonical status is unclear;
- required semantics are only available in snippets;
- the selected page set does not cover a required fact.

## Reviewer Checklist

- The correct official page was captured in full.
- The metadata separates retrieval date from publication or update date.
- The summary separates concepts, API behavior, and ambiguities.
- Claims are dated when mutable.
- Venue-local terminology is preserved.

## Final-Report Requirements

- Report the official page title and canonical URL.
- Report the capture date and any explicit update date.
- Report mutable facts and ambiguities.
- Report any venue-local terminology boundary decisions.
