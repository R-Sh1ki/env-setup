#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

mkdir -p "$localbin"
if command -v uv >/dev/null 2>&1; then
    log 'uv is already installed.'
else
    log 'Installing uv...'
    UV_INSTALL_DIR="$localbin" UV_NO_MODIFY_PATH=1 \
        curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$localbin" UV_NO_MODIFY_PATH=1 sh
fi

mkdir -p "$configdir/uv" "$configdir/zsh"
if [[ ! -e "$configdir/uv/uv.toml" && ! -L "$configdir/uv/uv.toml" ]]; then
    install -m 0644 "$repodir/dotfiles/uv.toml" "$configdir/uv/uv.toml"
elif ! cmp -s "$repodir/dotfiles/uv.toml" "$configdir/uv/uv.toml"; then
    warn 'Keeping existing uv.toml; merge dotfiles/uv.toml for mirror settings.'
fi
install -m 0644 "$repodir/dotfiles/zsh/uv.zsh" "$configdir/zsh/uv.zsh"

uv --version
success 'uv setup completed.'
