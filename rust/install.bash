#!/usr/bin/env bash
# Installs rust-qa (rust-qa-ci) at the commit in rust/rust-qa-ci.rev, with what its detectors
# need: the ast-grep, cargo-dylint and dylint-link versions that commit's tools.lock pins, and
# the nightly toolchain its bundled dylint library is built with.
set -euo pipefail
here="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
readonly here
rev="$(<"$here/rust-qa-ci.rev")"
readonly rev
src="$(mktemp -d)"
readonly src
trap 'rm -rf "$src"' EXIT

git -C "$src" init --quiet
git -C "$src" fetch --quiet --depth 1 https://github.com/LongTermSupport/rust-qa-ci "$rev"
git -C "$src" checkout --quiet FETCH_HEAD

(cd "$src" && rustup toolchain install)
(cd "$src/lints/rqaci_lints" && rustup toolchain install)
(cd "$src" && scripts/install-tools.sh ast-grep cargo-dylint dylint-link)
(cd "$src" && cargo install --locked --path crates/rust-qa)
rust-qa --version
