---
artifact_path:
artifact_exists: false
artifact_complete: false
artifact_inspectable: false
capture_method:
canonical_url:
capture_date:
primary_playbook:
secondary_playbooks: []
source_type_ambiguity:
failure_reason:
content_type:
page_count:
byte_count:
---

# Capture Report

Use this report for the acquisition gate before source ID allocation.

## Required fields

- `artifact_path`
- `artifact_exists`
- `artifact_complete`
- `artifact_inspectable`
- `capture_method`
- `canonical_url`
- `capture_date`
- `primary_playbook`
- `secondary_playbooks`
- `source_type_ambiguity`
- `failure_reason`

## Optional fields

- `content_type`
- `page_count`
- `byte_count`

## Playbook Fields

- `primary_playbook` must be exactly one of:
  - `academic-research`
  - `official-documentation`
  - `practitioner-content`
  - `journalism`
- `secondary_playbooks` may be empty.
- `secondary_playbooks` must contain only supported values.
- `secondary_playbooks` must not duplicate values.
- `primary_playbook` must not also appear in `secondary_playbooks`.
- `source_type_ambiguity` may be empty, but it should preserve material classification uncertainty when present.

## Legacy Compatibility

Legacy capture reports without the playbook fields may still be accepted by the standalone capture-report validator only when invoked with `--allow-legacy`.
They are not accepted for new-ingestion ID allocation.

## Pass criteria

A capture passes only when all of the following are true:

- `artifact_path` exists.
- `artifact_exists` is true.
- `artifact_complete` is true.
- `artifact_inspectable` is true.
- `failure_reason` is empty.

Do not infer completeness from file size alone. Capture completeness must be
established by inspection of the artifact itself.
