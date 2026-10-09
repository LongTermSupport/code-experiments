#!/usr/bin/env bash
# QA for YAML, run in the current directory over every .yml and .yaml file there.
#
#   all files               Prettier --check, then yamllint --strict
#   workflows/*.yml         actionlint (GitHub Actions workflow files, kept as data)
#   playbooks/*.yml         ansible-lint, production profile, run from this directory
#
# Stops at the first failure. The yamllint config is the default one, with the key check of
# the truthy rule off so that a workflow's `on:` key is not mistaken for a boolean.
set -euo pipefail

mapfile -t files < <(find . \( -name '*.yml' -o -name '*.yaml' \) -type f | sort)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no YAML files found in $PWD" >&2
  exit 2
fi

echo "== prettier --check"
npx --yes prettier@3.9.9 --check "${files[@]}"

echo "== yamllint --strict"
yamllint --strict -d '{extends: default, rules: {truthy: {check-keys: false}}}' "${files[@]}"

mapfile -t workflows < <(find ./workflows -name '*.yml' -type f 2>/dev/null | sort)
if [[ ${#workflows[@]} -gt 0 ]]; then
  echo "== actionlint"
  actionlint "${workflows[@]}"
fi

mapfile -t playbooks < <(find ./playbooks -name '*.yml' -type f 2>/dev/null | sort)
if [[ ${#playbooks[@]} -gt 0 ]]; then
  echo "== ansible-lint --profile production"
  ansible-lint --profile production "${playbooks[@]}"
fi
