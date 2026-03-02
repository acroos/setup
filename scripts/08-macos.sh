#!/bin/bash

set -euo pipefail

echo "Applying macOS defaults..."

# =============================================================================
# Keyboard
# =============================================================================

# Fast key repeat (lower = faster; default is 6)
defaults write NSGlobalDomain KeyRepeat -int 2
# Short delay before repeat starts (lower = faster; default is 25)
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable autocorrect, autocapitalize, smart quotes, smart dashes
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# =============================================================================
# Finder
# =============================================================================

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar at the bottom
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar at the bottom
defaults write com.apple.finder ShowStatusBar -bool true
# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Don't warn when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Show full POSIX path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# =============================================================================
# Dock
# =============================================================================

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Don't show recently used apps
defaults write com.apple.dock show-recents -bool false
# Smaller icon size
defaults write com.apple.dock tilesize -int 40

# =============================================================================
# Screenshots
# =============================================================================

mkdir -p "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
# Save as PNG (default, but explicit)
defaults write com.apple.screencapture type -string "png"
# Disable screenshot shadow
defaults write com.apple.screencapture disable-shadow -bool true

# =============================================================================
# Misc
# =============================================================================

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Quit printer app once jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Apply changes
echo "Restarting Finder and Dock..."
killall Finder
killall Dock

echo ""
echo "macOS defaults applied. Log out and back in for all changes to take effect."
