#!/bin/bash

set -euo pipefail

# Ensure Homebrew is in PATH
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Initialize rbenv so gem points to the right Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if ! command -v gem &>/dev/null; then
  echo "Error: gem not found. Run 05-ruby.sh first."
  exit 1
fi

gem update --system

gems=(
  "bundler"     # manage per-project gems
  "rails"       # Rails framework
  "rubocop"     # Ruby linter/formatter
  "solargraph"  # Ruby language server (LSP)
  "pry"         # better Ruby REPL
)

echo "Installing global Ruby gems..."
gem install "${gems[@]}"