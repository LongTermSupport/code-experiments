#!/usr/bin/env bash
# PowerShell QA for the current directory: Invoke-Formatter comparison, then PSScriptAnalyzer.
set -euo pipefail
exec pwsh -NoProfile -File "$(dirname "$(readlink -f "$0")")/qa.ps1"
