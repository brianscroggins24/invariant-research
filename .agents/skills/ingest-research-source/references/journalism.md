# Journalism Playbook

## Purpose

Use this playbook for news articles, reported commentary, and other journalism where the article’s job is to report, quote, or analyze rather than to serve as primary evidence.

## Source Classification

- Selected playbook: `journalism`
- Registry source_type: `financial-commentary`
- Authority: `secondary-journalism`
- Do not treat the article as primary proof of the quoted or reported claim.

The selected playbook is separate from the registry `source_type`; the registry value should stay on an existing journalism-oriented enum such as `financial-commentary` when that better matches the artifact.

## Acquisition Requirements

- Capture the complete article.
- Preserve attribution and publication context.
- Record the canonical URL and publication date if available.
- Produce a passing capture report before ID allocation.

## Metadata Requirements

- Record the exact title and author when available.
- Record publication date from the article or trusted metadata.
- Record the source as secondary journalism.

## Summary Requirements

Separate:

- observed events;
- quotations;
- statements attributed to named people;
- statements attributed to research;
- journalist analysis;
- forecasts;
- speculation;
- policy recommendations.

## Claim Requirements

- Preserve attribution in every claim.
- Use wording such as “the article reports,” “the author argues,” or “the quoted researcher states.”
- Keep one fact per claim.
- Do not rewrite reported or quoted claims as direct empirical findings.

Journalism may establish that:

- an event was reported;
- a person made a statement;
- a policy proposal exists.

It does not automatically establish that:

- the quoted claim is true;
- a forecast is reliable;
- a systemic risk has been empirically demonstrated;
- a recommended control is effective.

## Cross-Source Boundaries

- Use journalism to preserve attribution and context.
- Use primary research or official documentation to validate the underlying technical claim.
- Do not let a news report overwrite the original source’s evidence boundary.

## Required Limitations

- Quotations and paraphrases remain attribution-bound.
- Forecasts and opinions are not empirical proof.
- Reported claims may need direct source inspection before they are used as technical evidence.

## Stop Conditions

Stop when:

- the full article is unavailable;
- quotations are detached from attribution;
- the article references research that must be inspected directly for the intended claim.

## Reviewer Checklist

- Attribution is preserved.
- Analysis is separated from reported fact.
- Quoted claims are not promoted to primary evidence.
- Any research cited by the article is tracked to its original source.

## Final-Report Requirements

- Report the reported events, quotations, and analysis separately.
- Report any quoted research that still needs direct inspection.
- Report unsupported forecasts, speculation, or recommendations.
- Report attribution ambiguity if it remains.
