#!/usr/bin/env bash
# Rust QA for the Cargo package in the current directory, through the first-party rust-qa
# (rust-qa-ci) in check-only mode: the format check, then every detector (the project record,
# unrecorded suppressions, rule docs, the bundled ast-grep pack, Clippy with the package's
# [lints], the bundled dylint library). The runners (tests, coverage, cargo-deny, machete,
# mutants) are not run: they need more than a hello world. rust/install.bash installs rust-qa
# at the commit in rust/rust-qa-ci.rev, and the package must load its dylint library from the
# same commit. The toolchain is pinned by rust/rust-toolchain.toml.
set -euo pipefail
if [[ ! -f Cargo.toml ]]; then
  echo "no Cargo.toml here" >&2
  exit 2
fi
here="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
readonly here
rev="$(<"$here/rust-qa-ci.rev")"
readonly rev
if ! grep -qF "rev = \"$rev\"" Cargo.toml; then
  echo "Cargo.toml does not load the dylint library at rust-qa-ci $rev" >&2
  exit 2
fi
CARGO_TARGET_DIR="$(mktemp -d)"
export CARGO_TARGET_DIR
trap 'rm -rf "$CARGO_TARGET_DIR"' EXIT

rust-qa --version
rust-qa run --no-fix -t fmt -t record -t suppression -t docs -t ast-grep -t clippy -t dylint
