#!/usr/bin/env bash
# The status line: a fresh random token each time it is drawn, logged with the time, so the
# run's transcript can be searched for every token the terminal showed.
set -euo pipefail
input="$(cat)"
token="STATUS-$(od -An -tx1 -N8 /dev/urandom | tr -d ' \n')"
printf '%s %s input-bytes=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%S.%NZ)" "$token" "${#input}" \
  >>"$(dirname "$0")/statusline.log"
printf '%s\n' "$token"
