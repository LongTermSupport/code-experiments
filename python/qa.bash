#!/usr/bin/env bash
# Python QA for the current directory: ruff format check, ruff lint, then mypy --strict.
set -euo pipefail
ruff format --check --no-cache .
ruff check --no-cache --select E,F,I,B,UP,SIM,ANN,N,C4,RUF .
mypy --strict --cache-dir=/dev/null .
