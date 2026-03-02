#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[1;33m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

passed=()
failed_names=()
failed_scripts=()

run_step() {
  local name="$1"
  local script="$2"

  echo ""
  printf "${BOLD}==> %s${RESET}\n" "$name"
  echo "----------------------------------------"

  if bash "$script"; then
    passed+=("$name")
    printf "${GREEN}✓ %s${RESET}\n" "$name"
  else
    failed_names+=("$name")
    failed_scripts+=("$script")
    printf "${RED}✗ %s failed — skipping${RESET}\n" "$name"
  fi
}

run_step "Homebrew"      "$SCRIPTS_DIR/01-homebrew.sh"
run_step "Packages"      "$SCRIPTS_DIR/02-packages.sh"
run_step "Oh My Zsh"     "$SCRIPTS_DIR/03-oh-my-zsh.sh"
run_step "Node (fnm)"    "$SCRIPTS_DIR/04-node.sh"
run_step "Ruby (rbenv)"  "$SCRIPTS_DIR/05-ruby.sh"
run_step "Symlinks"      "$SCRIPTS_DIR/06-symlinks.sh"
run_step "npm Globals"   "$SCRIPTS_DIR/09-npm-globals.sh"
run_step "Ruby Gems"     "$SCRIPTS_DIR/10-ruby-gems.sh"
run_step "Claude MCPs"   "$SCRIPTS_DIR/11-claude-mcp.sh"
run_step "SSH Key"       "$SCRIPTS_DIR/07-ssh.sh"
run_step "macOS Defaults" "$SCRIPTS_DIR/08-macos.sh"

echo ""
printf "${BOLD}========================================\n"
printf "  Bootstrap Summary\n"
printf "========================================${RESET}\n"

for i in "${!passed[@]}"; do
  printf "  ${GREEN}✓${RESET}  %s\n" "${passed[$i]}"
done

for i in "${!failed_names[@]}"; do
  printf "  ${RED}✗${RESET}  %s\n" "${failed_names[$i]}"
done

if [ ${#failed_names[@]} -gt 0 ]; then
  printf "\n${YELLOW}Re-run failed steps:${RESET}\n"
  for i in "${!failed_names[@]}"; do
    printf "  bash %s\n" "${failed_scripts[$i]}"
  done
  printf "\n"
  exit 1
fi

printf "\n${GREEN}All steps completed!${RESET}\n"
printf "Open a new terminal session for all changes to take effect.\n"
