#!/bin/bash

set -euo pipefail

# Ensure Homebrew is in PATH (Apple Silicon vs Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v fnm &>/dev/null; then
  echo "Error: fnm not found. Run 02-packages.sh first."
  exit 1
fi

echo "Installing Node.js LTS via fnm..."
fnm install --lts

echo ""
echo "Node.js LTS installed."
echo "Make sure your .zshrc includes:"
echo '  eval "$(fnm env --use-on-cd)"'
