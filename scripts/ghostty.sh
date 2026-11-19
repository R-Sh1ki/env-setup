#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

# Check standard app locations and PATH.
if [[ -d /Applications/Ghostty.app || -d "$HOME/Applications/Ghostty.app" ]] ||
    command -v ghostty >/dev/null 2>&1; then
    log 'Ghostty is already installed.'
else
    log 'Installing Ghostty...'
    brew install --cask ghostty
fi

# Install the terminal configuration.
[[ -d "$configdir/ghostty" ]] || mkdir -p "$configdir/ghostty"
install -m 0644 "$repodir/dotfiles/ghostty_config" "$configdir/ghostty/config"

success 'Ghostty and configuration installed.'
