#!/usr/bin/env bash
# Swift QA over every .swift file in the current directory: swift-format lint, a type-check
# compile, then SwiftLint. Needs swift, swiftc and swiftlint on PATH.
set -euo pipefail

shopt -s nullglob
files=(*.swift)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .swift files in $PWD" >&2
  exit 2
fi

echo "== swift format"
swift format lint --strict "${files[@]}"

echo "== swiftc"
swiftc -typecheck -warnings-as-errors "${files[@]}"

echo "== swiftlint"
swiftlint lint --strict --quiet "${files[@]}"
