#!/usr/bin/env bash
# QA for MySQL-dialect SQL, run in the current directory over every .sql file there.
# sqlfluff has no separate check mode: `lint` covers layout (formatting) and the analysis
# rules in one pass, and exits 1 on any finding. Inline noqa comments are ignored.
set -euo pipefail

mapfile -t files < <(find . -name '*.sql' -type f | sort)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no .sql files found in $PWD" >&2
  exit 2
fi

echo "== sqlfluff lint (layout and analysis rules, MySQL dialect)"
sqlfluff lint --dialect mysql --disable-noqa "${files[@]}"
