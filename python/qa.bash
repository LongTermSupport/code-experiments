#!/usr/bin/env bash
# Python QA for the current directory: the first-party py-qa pipeline (py-qa-ci, pinned in
# python/requirements.txt) in check mode. It runs the format, record, suppression, docs, Ruff,
# mypy and Pylint lanes; the test runners are not run, since a snippet has no test suite.
set -euo pipefail
export CI=true PYTHONDONTWRITEBYTECODE=1
py-qa --version
py-qa run --ci -t fmt -t record -t suppression -t docs -t ruff -t mypy -t pylint
