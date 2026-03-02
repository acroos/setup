#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/../Brewfile"

# Ensure Homebrew is in PATH (Apple Silicon vs Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew not found. Run 01-homebrew.sh first."
  exit 1
fi

echo "Installing packages from Brewfile..."
brew bundle --file="$BREWFILE"
