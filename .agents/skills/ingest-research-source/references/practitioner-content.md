# Practitioner Content Playbook

## Purpose

Use this playbook for articles, posts, essays, and commentary written by practitioners rather than by primary researchers or platform operators.

## Source Classification

- Selected playbook: `practitioner-content`
- Registry source_type: `social-article`
- Authority: `secondary-practitioner`
- Do not classify the source as primary research merely because it discusses a paper, includes equations, or proposes a method.

The selected playbook is separate from the registry `source_type`; the registry value should stay on an existing practitioner enum such as `social-article` or `financial-commentary` when that better matches the artifact.

## Acquisition Requirements

- Capture the complete article or post.
- Preserve the original publication context.
- Record the canonical URL and publication date if available.
- Produce a passing capture report before ID allocation.

## Metadata Requirements

- Record the exact title and author when available.
- Record publication date from the source or trusted metadata.
- Do not infer publication date from retrieval date, file timestamps, or repository history.
- Record the source as secondary practitioner content.

## Summary Requirements

Separate:

- cited primary findings;
- the author’s interpretation;
- implementation advice;
- operational assertions;
- unsupported claims;
- forecasts;
- personal heuristics.

## Claim Requirements

- Each claim must say whether it is directly supported by a cited primary source, an interpretation, an anecdotal observation, an unsupported operational assertion, or a recommendation.
- Keep one fact per claim.
- Use precise locators for the practitioner’s own wording.
- Do not elevate practitioner assertions to established fact without corroboration.

Do not promote as established facts without corroboration:

- latency;
- capital requirements;
- execution-success rates;
- same-block execution;
- direct-RPC advantages;
- production iteration counts;
- realized performance;
- executable sizing rules.

## Cross-Source Boundaries

When the source cites a primary source:

- create the primary finding from the primary source;
- use the practitioner source only for added interpretation;
- preserve discrepancies between practitioner reporting and primary results.

## Required Limitations

- Practitioner commentary can be useful interpretation, but it is not primary evidence by itself.
- Numbers without scoping context must remain uncertain.
- Operational advice is not a guarantee of live execution performance.

## Stop Conditions

Stop when:

- the complete article is unavailable;
- citations cannot be distinguished from author assertions;
- the source presents unattributed numbers that cannot be scoped safely.

## Reviewer Checklist

- The source is classified as secondary practitioner content.
- Primary-source quotations are kept distinct from author interpretation.
- Unsupported operational claims remain labeled as unsupported.
- Any cited primary source is tracked separately.

## Final-Report Requirements

- Report the publication context and the evidence boundary used.
- Report any primary-source citations that were separated out.
- Report unsupported operational assertions.
- Report unresolved scope or attribution ambiguities.
