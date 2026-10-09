#!/usr/bin/env bash
# F# QA for the current directory: Fantomas check, FSharpLint, then the compiler with warnings as errors.
set -euo pipefail
fantomas --check .
dotnet fsharplint lint ./*.fsproj
dotnet build --nologo -warnaserror
