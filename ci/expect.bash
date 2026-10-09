#!/usr/bin/env bash
# Runs a language's QA in one directory and checks the outcome.
#
#   ci/expect.bash pass DIR -- COMMAND...   the command must succeed in DIR
#   ci/expect.bash fail DIR -- COMMAND...   the command must fail in DIR, and its output must
#                                           contain every non-empty line of DIR/EXPECTED
#
# EXPECTED holds fixed strings, one per line: the rule identifier or message that shows the
# failure is the intended one, not an accident.
set -euo pipefail

if [[ $# -lt 4 || "$3" != "--" ]]; then
  echo "usage: ci/expect.bash pass|fail DIR -- COMMAND..." >&2
  exit 2
fi
readonly mode="$1"
readonly dir="$2"
shift 3

log="$(mktemp)"
readonly log
if (cd "$dir" && "$@") >"$log" 2>&1; then
  status=0
else
  status=$?
fi
cat "$log"

case "$mode" in
  pass)
    if [[ $status -ne 0 ]]; then
      echo "::error::$dir should pass its QA, but it exited $status"
      exit 1
    fi
    echo "OK $dir passes"
    ;;
  fail)
    if [[ $status -eq 0 ]]; then
      echo "::error::$dir should fail its QA, but it passed"
      exit 1
    fi
    if [[ ! -s "$dir/EXPECTED" ]]; then
      echo "::error::$dir/EXPECTED is missing or empty: say how this case must fail"
      exit 1
    fi
    while IFS= read -r expected; do
      [[ -z "$expected" ]] && continue
      if ! grep -qF -- "$expected" "$log"; then
        echo "::error::$dir failed, but its output does not contain: $expected"
        exit 1
      fi
    done <"$dir/EXPECTED"
    echo "OK $dir fails as expected (exit $status)"
    ;;
  *)
    echo "mode must be pass or fail, not: $mode" >&2
    exit 2
    ;;
esac
