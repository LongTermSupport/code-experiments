#!/usr/bin/env bash
# CSS QA for the current directory: Prettier format check, then stylelint.
set -euo pipefail
npm ci --no-audit --no-fund
npx prettier --check .
npx stylelint "**/*.css"
