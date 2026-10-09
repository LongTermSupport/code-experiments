#!/usr/bin/env bash
# Prints a greeting for each name given, or for the world.
set -euo pipefail

greet() {
  local name="$1"
  printf 'Hello, %s\n' "$name"
}

if [[ $# -eq 0 ]]; then
  greet "world"
else
  for name in "$@"; do
    greet "$name"
  done
fi
