#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

mkdir -p "$localbin"
if ! command -v fnm >/dev/null 2>&1; then
    log 'Installing fnm...'
    curl -fsSL https://fnm.vercel.app/install | bash -s -- \
        --install-dir "$localbin" --skip-shell
fi

export PATH="$localbin:$PATH"
eval "$(fnm env --shell bash)"
fnm install --lts
fnm use lts-latest
fnm default lts-latest

mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/fnm.zsh" "$configdir/zsh/fnm.zsh"

success 'fnm and Node.js setup completed.'
log 'Start a new Zsh session or run: source ~/.zshrc'
