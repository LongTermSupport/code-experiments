#!/usr/bin/env bash
# QA for every C++ source file in the current directory: format check, then analysers.
# Stops at the first failure. Tools: clang-format-18, clang-tidy-18, cppcheck.
set -euo pipefail
shopt -s nullglob
files=(*.cpp)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .cpp files here" >&2
  exit 2
fi

echo "== clang-format"
clang-format-18 --dry-run --Werror --style=file "${files[@]}"

for f in "${files[@]}"; do
  echo "== clang-tidy $f"
  clang-tidy-18 --warnings-as-errors='*' --checks='clang-analyzer-*,bugprone-*' "$f" -- -std=c++20
  echo "== cppcheck $f"
  cppcheck --error-exitcode=1 --enable=warning,style,performance,portability --language=c++ --std=c++20 "$f"
done
