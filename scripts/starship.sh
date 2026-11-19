#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

# Install only if missing.
if command -v starship >/dev/null 2>&1; then
    log 'Starship is already installed.'
else
    log 'Installing Starship...'
    brew install starship
fi

# Install the prompt configuration.
[[ -d "$configdir" ]] || mkdir -p "$configdir"
install -m 0644 "$repodir/dotfiles/starship.toml" "$configdir/starship.toml"

# Enable Starship in Zsh.
[[ -d "$configdir/zsh" ]] || mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/starship.zsh" "$configdir/zsh/starship.zsh"

starship --version
success 'Starship and configuration installed.'
