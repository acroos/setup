#!/bin/bash

set -euo pipefail

KEY_FILE="$HOME/.ssh/id_ed25519"
SSH_CONFIG="$HOME/.ssh/config"

# Generate key if one doesn't exist
if [ -f "$KEY_FILE" ]; then
  echo "SSH key already exists at $KEY_FILE — skipping generation."
else
  read -r -p "Enter your email address for the SSH key: " email
  echo "Generating SSH key..."
  ssh-keygen -t ed25519 -C "$email" -f "$KEY_FILE"
fi

# Write SSH config to use Keychain and auto-add key (macOS)
if [ ! -f "$SSH_CONFIG" ] || ! grep -q "UseKeychain" "$SSH_CONFIG"; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  cat >> "$SSH_CONFIG" <<EOF

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
  echo "SSH config updated."
fi

# Add key to agent and Keychain
eval "$(ssh-agent -s)" > /dev/null
ssh-add --apple-use-keychain "$KEY_FILE" 2>/dev/null || ssh-add "$KEY_FILE"

echo ""
echo "Your public key (add this to GitHub → Settings → SSH keys):"
echo ""
cat "${KEY_FILE}.pub"
echo ""

# Copy to clipboard if pbcopy is available
if command -v pbcopy &>/dev/null; then
  pbcopy < "${KEY_FILE}.pub"
  echo "Public key copied to clipboard."
fi
