---
name: tide-report
description: Write the harbour's tide report from the readings in data/. Use when asked for a tide report.
---

# Tide report

Context marker: SKILL-BODY-TIDE-REPORT

1. Read `data/harbour.csv`.
2. Find the highest and the lowest reading, skipping any height of `-99`.
3. Reply with exactly two lines: `High: <height> m at <timestamp>` and
   `Low: <height> m at <timestamp>`.
