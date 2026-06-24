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
