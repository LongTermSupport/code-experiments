#!/usr/bin/env bash
# Ruby QA for the current directory: RuboCop layout check, full RuboCop, then Sorbet.
set -euo pipefail
rubocop --only Layout .
rubocop .
srb tc .
