---
artifact_path:
artifact_exists: false
artifact_complete: false
artifact_inspectable: false
capture_method:
canonical_url:
capture_date:
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
- `failure_reason`

## Optional fields

- `content_type`
- `page_count`
- `byte_count`

## Pass criteria

A capture passes only when all of the following are true:

- `artifact_path` exists.
- `artifact_exists` is true.
- `artifact_complete` is true.
- `artifact_inspectable` is true.
- `failure_reason` is empty.

Do not infer completeness from file size alone. Capture completeness must be
established by inspection of the artifact itself.
