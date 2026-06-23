---
page_id: SOURCE-SUMMARY-0001
title: LLM Wiki
page_type: source-summary
status: reviewed
created_at: 2026-06-22
updated_at: 2026-06-22
source_id: SRC-0001
sources:
  - SRC-0001
related_pages:
  - PROCESS-0001
tags:
  - llm-wiki
  - knowledge-management
  - research-workflow
---

# Source Summary

## Citation

Karpathy, Andrej. "LLM Wiki." Gist, April 4, 2026. Source ID: `SRC-0001`.

## Source Type

Technical proposal / idea note for an LLM-maintained personal knowledge base.

## Purpose or Research Question

The source asks how to move beyond conventional retrieval-based workflows and instead maintain a persistent, evolving wiki between raw sources and query-time answers.

## Methodology

The source is a conceptual proposal rather than an empirical study. It describes a workflow and architecture based on experience and intended use, not a formal evaluation.

## Data or Evidence Used

The source does not present datasets or experiments. It relies on illustrative examples such as personal knowledge management, research, book reading, and business/team wikis.

## Main Findings

- Conventional RAG retrieves chunks at query time but does not accumulate knowledge in a persistent structure.
- A persistent wiki can compile knowledge once, keep it current, and preserve cross-references and contradictions.
- The wiki sits between raw sources and query-time use, and the LLM is responsible for maintaining it.
- Invariant should treat this as a design pattern for a research wiki, not as a finished implementation spec.

## Important Claims

### Explicitly stated by the source

- RAG-style workflows rediscover knowledge from scratch on each question.
- A persistent wiki can be incrementally maintained by an LLM.
- Raw sources are immutable and the wiki is a separate synthesized layer.
- The schema document tells the LLM how to operate.
- Ingest, query, and lint are the core recurring operations.
- `index.md` should be content-oriented and `log.md` chronological.
- The system can begin with a simple setup and add search tooling only as scale requires.
- Humans should curate sources and guide emphasis during ingestion.

### Invariant’s interpretation

- `invariant-research` can use this pattern as a governed research layer that feeds `invariant-engine`.
- The wiki should preserve provenance, contradictions, and review status so downstream context packs remain trustworthy.
- The source implies that operational discipline matters more than elaborate tooling at the start.

### Unresolved questions

- How much structure should be imposed on the wiki before enough sources exist to justify it?
- What level of review is required before a synthesis becomes context-pack material?
- Which search or lint tooling, if any, should be added after the first ingestion cycle?

## Limitations

The source is intentionally abstract. It does not specify concrete schemas, exact file formats, automation details, or review thresholds.

## Relevance to Invariant

This source is directly relevant because it describes the exact operating model this repository is meant to support: immutable raw sources, a maintained wiki layer, explicit provenance, and append-only logging.

## Conflicts With Existing Knowledge

- The source is compatible with the current governance model.
- It leaves unresolved how to represent review, dispute handling, and source versioning in enough detail for this repository.
- It suggests a broad wiki structure, while `invariant-research` is intentionally keeping its top-level boundaries stable and minimal for now.

## Wiki Pages Affected

- `wiki/source-ingestion.md`

## New Research Questions

- What should the first reviewed wiki pages be after the source is fully ingested?
- What search or lint support is justified at this repository’s current scale?
- How should source-derived context be packaged for `invariant-engine` once the wiki grows?

## Review Notes

The source explicitly distinguishes raw sources, the wiki, and the schema. The interpretation here is that `invariant-research` should treat those as governing layers rather than optional conventions. The main uncertainty is implementation detail, not the overall pattern.
