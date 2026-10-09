#!/usr/bin/env bash
# PHP QA for the current directory, a Composer project using php-qa-ci: installs it, then runs
# the strict-types, parallel-lint, PHP CS Fixer and PHPStan (level max) lanes one by one.
# The full pipeline and the markdown-links lane are not run: they need more than a hello world.
set -euo pipefail
export CI=true QA_READONLY=1 PHP_QA_CI_DISABLE_CONFIG_PUSH=true
composer install --no-interaction --no-progress --prefer-dist
for lane in stricttypes lint fixer stan; do
  vendor/bin/qa -t "$lane"
done
