#!/usr/bin/env bash
# Java QA over every .java file in the current directory: format check, compile with all
# warnings fatal, then PMD. Needs google-java-format, javac and pmd on PATH.
set -euo pipefail

shopt -s nullglob
files=(*.java)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .java files in $PWD" >&2
  exit 2
fi

echo "== google-java-format"
google-java-format --dry-run --set-exit-if-changed "${files[@]}"

echo "== javac"
out="$(mktemp -d)"
javac -Xlint:all -Werror -d "$out" "${files[@]}"

echo "== pmd"
pmd check --no-cache -d . -R rulesets/java/quickstart.xml -f text
