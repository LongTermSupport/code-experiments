#!/usr/bin/env bash
# C# QA for the current directory: formatter check, then the compiler with analysers as errors.
set -euo pipefail
dotnet format --verify-no-changes --verbosity diagnostic
dotnet build --nologo -warnaserror
