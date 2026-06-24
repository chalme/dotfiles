#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT

HOME_DIR="$TEST_ROOT/home"
mkdir -p "$HOME_DIR"

assert_symlink_target() {
  local path="$1"
  local expected="$2"
  local actual

  if [[ ! -L "$path" ]]; then
    echo "expected symlink but found something else: $path" >&2
    exit 1
  fi

  actual="$(readlink "$path")"
  if [[ "$actual" != "$expected" ]]; then
    echo "symlink target mismatch for $path: expected $expected got $actual" >&2
    exit 1
  fi
}

HOME="$HOME_DIR" "$ROOT_DIR/link.sh"

assert_symlink_target "$HOME_DIR/.vimrc" "$ROOT_DIR/.vimrc"
assert_symlink_target "$HOME_DIR/.mackup.cfg" "$ROOT_DIR/.mackup.cfg"

HOME="$HOME_DIR" "$ROOT_DIR/link.sh"
assert_symlink_target "$HOME_DIR/.vimrc" "$ROOT_DIR/.vimrc"

rm "$HOME_DIR/.vimrc"
printf 'legacy vimrc\n' > "$HOME_DIR/.vimrc"

HOME="$HOME_DIR" "$ROOT_DIR/link.sh"

assert_symlink_target "$HOME_DIR/.vimrc" "$ROOT_DIR/.vimrc"

backup_count="$(find "$HOME_DIR" -maxdepth 1 -name '.vimrc.backup.*' | wc -l | tr -d ' ')"
if [[ "$backup_count" -lt 1 ]]; then
  echo "expected at least one backup file for .vimrc" >&2
  exit 1
fi

echo "test_link.sh: PASS"
