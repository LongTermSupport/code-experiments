#!/usr/bin/env bash
# QA for every Go source file in the current directory: format check, then analysers.
# Stops at the first failure. Tools: gofmt, go vet, staticcheck.
set -euo pipefail
shopt -s nullglob
files=(*.go)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .go files here" >&2
  exit 2
fi

echo "== gofmt"
unformatted="$(gofmt -l "${files[@]}")"
if [[ -n "$unformatted" ]]; then
  echo "gofmt: these files are not formatted:"
  echo "$unformatted"
  exit 1
fi

echo "== go vet"
go vet "${files[@]}"

echo "== staticcheck"
staticcheck "${files[@]}"
