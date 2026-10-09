#!/usr/bin/env bash
# QA for every C source file in the current directory: format check, then analysers.
# Stops at the first failure. Tools: clang-format-18, clang-tidy-18, gcc (-fanalyzer).
set -euo pipefail
shopt -s nullglob
files=(*.c)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .c files here" >&2
  exit 2
fi

echo "== clang-format"
clang-format-18 --dry-run --Werror --style=file "${files[@]}"

for f in "${files[@]}"; do
  echo "== clang-tidy $f"
  clang-tidy-18 --warnings-as-errors='*' --checks='clang-analyzer-*,bugprone-*' "$f" -- -std=c11
  echo "== gcc -fanalyzer $f"
  gcc -std=c11 -Wall -Wextra -Werror -fanalyzer -c "$f" -o /dev/null
done
