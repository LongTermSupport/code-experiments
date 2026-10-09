#!/usr/bin/env bash
# HTML QA for the current directory: Prettier format check, then html-validate.
set -euo pipefail
npm ci --no-audit --no-fund
npx prettier --check .
npx html-validate .
