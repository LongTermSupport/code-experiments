#!/usr/bin/env bash
# QA for the Cargo package in the current directory: format check, then Clippy with every
# warning and the pedantic group denied. Stops at the first failure. A compile (type) error
# fails the Clippy step. The toolchain is pinned by rust/rust-toolchain.toml.
set -euo pipefail
if [[ ! -f Cargo.toml ]]; then
  echo "no Cargo.toml here" >&2
  exit 2
fi
CARGO_TARGET_DIR="$(mktemp -d)"
export CARGO_TARGET_DIR
trap 'rm -rf "$CARGO_TARGET_DIR"' EXIT

cargo --version
cargo fmt --version
cargo clippy --version

echo "== cargo fmt"
cargo fmt --check

echo "== cargo clippy"
cargo clippy --locked --all-targets -- -D warnings -W clippy::pedantic
