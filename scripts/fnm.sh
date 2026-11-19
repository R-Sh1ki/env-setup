#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "${repodir}/scripts/lib/common.sh"

# Install the version manager.
if ! command -v fnm >/dev/null 2>&1; then
    brew install fnm
fi

# Install LTS Node and select it as the default.
eval "$(fnm env --shell bash)"
fnm install --lts
fnm use lts-latest
fnm default lts-latest

# Enable fnm in future Zsh sessions.
[[ -d "$configdir/zsh" ]] || mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/fnm.zsh" "$configdir/zsh/fnm.zsh"

success 'fnm and node.js setup completed.'
log 'Start a new Zsh session or run: source ~/.zshrc'
