#!/bin/bash

set -euo pipefail

# Ensure Homebrew is in PATH (Apple Silicon vs Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v rbenv &>/dev/null; then
  echo "Error: rbenv not found. Run 02-packages.sh first."
  exit 1
fi

# Update this to the latest stable Ruby as needed
RUBY_VERSION="3.4.8"

echo "Installing Ruby $RUBY_VERSION via rbenv..."
rbenv install --skip-existing "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"

echo ""
echo "Ruby $RUBY_VERSION installed and set as global."
echo "Make sure your .zshrc includes:"
echo '  eval "$(rbenv init - zsh)"'
