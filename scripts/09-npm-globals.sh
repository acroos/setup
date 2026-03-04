#!/bin/bash

set -euo pipefail

# Ensure Homebrew is in PATH
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v fnm &>/dev/null; then
  echo "Error: fnm not found. Run 02-packages.sh first."
  exit 1
fi

# Initialize fnm so node/npm are available
eval "$(fnm env)"

if ! command -v npm &>/dev/null; then
  echo "Error: npm not found. Run 04-node.sh first."
  exit 1
fi

packages=(
  "npm"
  "npm-check-updates"           # ncu — bump package.json deps to latest
  "typescript"                  # tsc — TypeScript compiler
  "ts-node"                     # run .ts files directly
  "vercel"                      # Vercel CLI
  "serve"                       # instant local static file server
  "typescript-language-server"  # LSP server for JS/TS
  "cclsp"                       # MCP server that exposes LSP to Claude Code
  "@nestjs/cli"                 # NestJS CLI for building server-side applications
)

echo "Installing global npm packages..."
npm install -g "${packages[@]}"
