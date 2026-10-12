---
paths:
  - "data/**/*.csv"
---

# Tide readings

A rule scoped to the readings, so it applies only when a CSV under `data/` is involved.

Context marker: RULE-DATA-PATHS

- Each row is `timestamp_utc,height_m`; never reorder the columns.
- A height of `-99` means the gauge was offline: skip the row, never treat it as a reading.
