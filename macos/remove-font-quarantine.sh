#!/usr/bin/env bash

# Remove macOS quarantine attributes from Nerd Fonts
# This prevents font loading issues in long-running terminal sessions

echo "Removing quarantine attributes from Nerd Fonts..."

# Remove quarantine from all Nerd Font files in user's font directory
if ls ~/Library/Fonts/*NerdFont*.otf 1> /dev/null 2>&1; then
    xattr -d com.apple.quarantine ~/Library/Fonts/*NerdFont*.otf 2>/dev/null
    echo "✓ Cleaned Nerd Font files"
else
    echo "No Nerd Font files found"
fi

# Restart font server to pick up changes
killall fontd 2>/dev/null && echo "✓ Restarted font server"
