#!/bin/bash

set -euo pipefail

if ! command -v claude &>/dev/null; then
  echo "Error: claude not found. Make sure Claude Code is installed (02-packages.sh)."
  exit 1
fi

CCLSP_CONFIG="$HOME/.config/claude/cclsp.json"

echo "Registering MCP servers..."

# cclsp — exposes TypeScript and Ruby LSP servers to Claude Code
# Remove first in case it was previously registered with wrong settings
if claude mcp get cclsp &>/dev/null 2>&1; then
  claude mcp remove cclsp
fi
claude mcp add -s user cclsp cclsp --env "CCLSP_CONFIG_PATH=$CCLSP_CONFIG"
echo "  added: cclsp"

echo ""
echo "MCP servers registered. Run 'claude mcp list' to verify."
