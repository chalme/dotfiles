# Link Bootstrap Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a safe `link.sh` entrypoint that symlinks selected dotfiles from this repository into `$HOME` and preserves existing files by backing them up first.

**Architecture:** Implement a manifest-driven Bash script at the repository root and verify it with a small shell-based integration test that runs inside a temporary `HOME`. Update the existing docs so the link entrypoint becomes the recommended first bootstrap step.

**Tech Stack:** Bash, standard macOS userland tools, Markdown documentation

---

### Task 1: Add a failing integration test for the link entrypoint

**Files:**
- Create: `tests/test_link.sh`

- [ ] **Step 1: Write the failing test**

```bash
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
  actual="$(readlink "$path")"
  [[ "$actual" == "$expected" ]]
}

HOME="$HOME_DIR" "$ROOT_DIR/link.sh"

assert_symlink_target "$HOME_DIR/.vimrc" "$ROOT_DIR/.vimrc"
assert_symlink_target "$HOME_DIR/.mackup.cfg" "$ROOT_DIR/.mackup.cfg"

echo "test_link.sh: PASS"
```

- [ ] **Step 2: Run test to verify it fails**

Run: `rtk bash tests/test_link.sh`
Expected: fail because `link.sh` does not exist yet

### Task 2: Implement the manifest-driven symlink bootstrap script

**Files:**
- Create: `link.sh`

- [ ] **Step 1: Write minimal implementation**

```bash
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

declare -a LINKS=(
  ".vimrc:$HOME/.vimrc"
  ".mackup.cfg:$HOME/.mackup.cfg"
)

link_file() {
  local source_rel="$1"
  local target="$2"
  local source="$ROOT_DIR/$source_rel"

  if [[ ! -e "$source" ]]; then
    echo "ERROR missing source: $source" >&2
    exit 1
  fi

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      echo "SKIPPED $target"
      return
    fi
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    local backup="${target}.backup.${TIMESTAMP}"
    mv "$target" "$backup"
    echo "BACKED UP $target -> $backup"
  fi

  ln -sfn "$source" "$target"
  echo "LINKED $target -> $source"
}

for mapping in "${LINKS[@]}"; do
  IFS=":" read -r source_rel target <<< "$mapping"
  link_file "$source_rel" "$target"
done

echo "Done."
```

- [ ] **Step 2: Run test to verify it passes**

Run: `rtk bash tests/test_link.sh`
Expected: `test_link.sh: PASS`

### Task 3: Cover idempotency and backup behavior in the integration test

**Files:**
- Modify: `tests/test_link.sh`

- [ ] **Step 1: Extend the test**

```bash
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
  actual="$(readlink "$path")"
  [[ "$actual" == "$expected" ]]
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
[[ "$backup_count" -ge 1 ]]

echo "test_link.sh: PASS"
```

- [ ] **Step 2: Run test to verify it fails for the new behavior**

Run: `rtk bash tests/test_link.sh`
Expected: fail until backup handling and idempotency are correct

### Task 4: Refine the script and wire docs

**Files:**
- Modify: `link.sh`
- Modify: `README.md`
- Modify: `docs/bootstrap.md`

- [ ] **Step 1: Update script behavior if the expanded test exposes gaps**

```bash
# Keep the manifest explicit.
# Ensure repeated runs skip correct links.
# Ensure existing files are backed up before linking.
```

- [ ] **Step 2: Document the new entrypoint**

Update:
- `README.md` quick start to mention `link.sh` first
- `README.md` repository map to include `link.sh`
- `docs/bootstrap.md` recommended order and script roles to include `link.sh`

- [ ] **Step 3: Run focused verification**

Run: `rtk bash tests/test_link.sh`
Expected: `test_link.sh: PASS`

- [ ] **Step 4: Run a final repository status check**

Run: `rtk git status --short`
Expected: shows only intended file additions and modifications

- [ ] **Step 5: Commit**

```bash
rtk git add README.md docs/bootstrap.md docs/superpowers/plans/2026-06-25-link-bootstrap.md docs/superpowers/specs/2026-06-25-link-bootstrap-design.md link.sh tests/test_link.sh
rtk git commit -m "feat: add dotfile link bootstrap"
```
