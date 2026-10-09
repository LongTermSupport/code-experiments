#!/usr/bin/env bash
# Kotlin QA over every .kt file in the current directory: ktlint, compile with warnings
# fatal, then detekt. Needs ktlint, kotlinc and detekt-cli on PATH.
set -euo pipefail

shopt -s nullglob
files=(*.kt)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .kt files in $PWD" >&2
  exit 2
fi

echo "== ktlint"
ktlint "${files[@]}"

echo "== kotlinc"
out="$(mktemp -d)"
kotlinc -Werror -d "$out" "${files[@]}"

echo "== detekt"
detekt-cli --input "$PWD" --build-upon-default-config
