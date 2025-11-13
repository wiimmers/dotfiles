#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# 1) ~/.zshenv -> repo
ln -snf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"

# 2) LaunchAgent -> symlink + load
mkdir -p "$HOME/Library/LaunchAgents"
ln -snf "$DOTFILES/macos/env.xdg-config-home.plist" \
        "$HOME/Library/LaunchAgents/env.xdg-config-home.plist"

launchctl bootstrap "gui/$UID" "$HOME/Library/LaunchAgents/env.xdg-config-home.plist" 2>/dev/null || true
launchctl enable "gui/$UID/env.xdg-config-home"
launchctl kickstart -k "gui/$UID/env.xdg-config-home"

echo "XDG_CONFIG_HOME=$(launchctl getenv XDG_CONFIG_HOME)"
echo "Done. Restart GUI apps (or log out/in) so they pick up the env."
