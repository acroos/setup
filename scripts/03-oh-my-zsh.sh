#!/bin/bash

set -euo pipefail

# Install Oh My Zsh (skip if already installed)
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh already installed — skipping."
else
  echo "Installing Oh My Zsh..."
  # RUNZSH=no  — don't launch a new shell at the end (would hang this script)
  # KEEP_ZSHRC=yes — don't overwrite .zshrc (we manage our own)
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Shades of Purple theme
echo "Installing Shades of Purple theme..."
curl -fsSL https://raw.githubusercontent.com/ahmadawais/shades-of-purple-iterm2/master/shades-of-purple.zsh-theme \
  > "$HOME/.oh-my-zsh/themes/shades-of-purple.zsh-theme"

# Download iTerm2 color scheme (double-click to import in iTerm2 > Preferences > Profiles > Colors)
mkdir -p "$HOME/tmp"
curl -fsSL https://raw.githubusercontent.com/ahmadawais/shades-of-purple-iterm2/master/shades-of-purple.itermcolors \
  > "$HOME/tmp/shades-of-purple.itermcolors"

echo ""
echo "Manual iTerm2 setup:"
echo "  1. Color scheme : Preferences > Profiles > Colors > Color Presets > Import"
echo "                    then select ~/tmp/shades-of-purple.itermcolors"
echo "  2. Font         : Preferences > Profiles > Text > Font"
echo "                    then select 'FiraCode Nerd Font'"
