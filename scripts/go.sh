#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

export GOPATH="$localshare/go"
export GOBIN="$localbin"
mkdir -p "$GOPATH" "$GOBIN"

if command -v go >/dev/null 2>&1; then
    log 'Go is already installed.'
else
    log 'Installing Go...'
    sudo apt-get install -y golang-go
fi

mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/go.zsh" "$configdir/zsh/go.zsh"

go version
log "GOPATH: $(go env GOPATH)"
log "GOBIN: $(go env GOBIN)"
success 'Go setup completed.'
