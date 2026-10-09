#!/usr/bin/env bash
# Ruby QA for the current directory: RuboCop layout check, full RuboCop, then Sorbet.
set -euo pipefail
BUNDLE_GEMFILE="$(dirname "$(readlink -f "$0")")/Gemfile"
export BUNDLE_GEMFILE
bundle exec rubocop --only Layout .
bundle exec rubocop .
bundle exec srb tc .
