#!/usr/bin/env bash
# TypeScript QA for the current directory: install from the lockfile, then the first-party
# ts-qa pipeline (oxlint, Prettier, ESLint, tsc, dependency-cruiser) in read-only mode.
set -euo pipefail
npm ci --no-audit --no-fund
npx ts-qa --read-only --no-llm
