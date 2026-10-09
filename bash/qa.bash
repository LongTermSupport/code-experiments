#!/usr/bin/env bash
# QA for Bash, run in the current directory over every .bash and .sh file there.
# Formatter first (shfmt, two-space indent, diff as the check), then ShellCheck at its
# strictest severity. Stops at the first failure.
set -euo pipefail

mapfile -t files < <(find . \( -name '*.bash' -o -name '*.sh' \) -type f | sort)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no shell files found in $PWD" >&2
  exit 2
fi

echo "== shfmt -i 2 -d"
shfmt -i 2 -d "${files[@]}"

echo "== shellcheck -s bash -S style"
shellcheck --norc -s bash -S style "${files[@]}"
