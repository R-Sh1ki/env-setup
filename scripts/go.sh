#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

# Keep Go data and commands under ~/.local.
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
[[ -d "$GOPATH" ]] || mkdir -p "$GOPATH"
[[ -d "$GOBIN" ]] || mkdir -p "$GOBIN"

# Install only if missing.
if command -v go >/dev/null 2>&1; then
    log 'Go is already installed.'
else
    log 'Installing Go...'
    brew install go
fi

# Enable Go commands in Zsh.
[[ -d "$configdir/zsh" ]] || mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/go.zsh" "$configdir/zsh/go.zsh"

go version
log "GOPATH: $(go env GOPATH)"
log "GOBIN: $(go env GOBIN)"
success 'Go setup completed.'
log 'Start a new Zsh session or run: source ~/.zshrc'
