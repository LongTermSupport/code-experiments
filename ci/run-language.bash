#!/usr/bin/env bash
# Proves one language's QA: LANG/pass must pass, and every LANG/fail/<case>/ must fail as its
# EXPECTED file says. The QA itself is LANG/qa.bash, run inside each directory.
#
#   ci/run-language.bash LANG
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: ci/run-language.bash LANG" >&2
  exit 2
fi
root="$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)"
readonly root
readonly lang="$1"
readonly qa="$root/$lang/qa.bash"

bash "$root/ci/expect.bash" pass "$root/$lang/pass" -- bash "$qa"

cases=0
for case in "$root/$lang"/fail/*/; do
  bash "$root/ci/expect.bash" fail "${case%/}" -- bash "$qa"
  cases=$((cases + 1))
done
if [[ $cases -eq 0 ]]; then
  echo "::error::$lang has no fail cases: prove its QA can fail"
  exit 1
fi
echo "OK $lang: pass passes, $cases fail case(s) fail as expected"
