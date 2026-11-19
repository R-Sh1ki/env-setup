#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

mkdir -p "$localbin"
if command -v starship >/dev/null 2>&1; then
    log 'Starship is already installed.'
else
    log 'Installing Starship...'
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$localbin"
fi

mkdir -p "$configdir" "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/starship.toml" "$configdir/starship.toml"
install -m 0644 "$repodir/dotfiles/zsh/starship.zsh" "$configdir/zsh/starship.zsh"

starship --version
success 'Starship and configuration installed.'
