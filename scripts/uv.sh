#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

# Install only if missing.
if command -v uv >/dev/null 2>&1; then
    log 'uv is already installed.'
else
    log 'Installing uv...'
    brew install uv
fi

# Keep existing uv settings.
mkdir -p "$configdir/uv" "$configdir/zsh"
if [[ ! -e "$configdir/uv/uv.toml" && ! -L "$configdir/uv/uv.toml" ]]; then
    install -m 0644 "$repodir/dotfiles/uv.toml" "$configdir/uv/uv.toml"
elif ! cmp -s "$repodir/dotfiles/uv.toml" "$configdir/uv/uv.toml"; then
    warn 'Keeping existing uv.toml; merge dotfiles/uv.toml for mirror settings.'
fi

# Enable uv tool commands in Zsh.
install -m 0644 "$repodir/dotfiles/zsh/uv.zsh" "$configdir/zsh/uv.zsh"

uv --version
success 'uv setup completed.'
log 'Start a new Zsh session or run: source ~/.zshrc'
