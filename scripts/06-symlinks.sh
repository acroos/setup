#!/bin/bash

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/../dotfiles"

GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
RESET=$'\033[0m'

# Map of dotfiles: "source_filename:target_path"
# Source paths are relative to dotfiles/
files=(
  ".zshrc:$HOME/.zshrc"
  ".vimrc:$HOME/.vimrc"
  ".gitconfig:$HOME/.gitconfig"
  "AGENTS.md:$HOME/.claude/CLAUDE.md"
  "cclsp.json:$HOME/.config/claude/cclsp.json"
)

link_file() {
  local src="$1"
  local target="$2"

  if [ ! -f "$src" ]; then
    printf "${YELLOW}  skip${RESET}  %s (not found in dotfiles/)\n" "$(basename "$src")"
    return
  fi

  # Already symlinked to the right place
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    printf "${GREEN}  ok${RESET}    %s\n" "$target"
    return
  fi

  # Back up existing file or symlink
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "${target}.backup"
    printf "${YELLOW}  backup${RESET} %s -> %s.backup\n" "$target" "$target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$src" "$target"
  printf "${GREEN}  linked${RESET} %s -> %s\n" "$src" "$target"
}

echo "Linking dotfiles..."
for entry in "${files[@]}"; do
  src_rel="${entry%%:*}"
  target="${entry##*:}"
  link_file "$DOTFILES_DIR/$src_rel" "$target"
done
