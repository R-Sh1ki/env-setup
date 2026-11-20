#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

mkdir -p "$localbin"
if ! command -v fnm >/dev/null 2>&1; then
    log 'Installing fnm from GitHub releases...'

    case "$arch" in
        x86_64) asset='fnm-linux.zip' ;;
        aarch64|arm64) asset='fnm-arm64.zip' ;;
        *) die "Unsupported architecture for fnm: $arch" ;;
    esac

    workdir="$(mktemp -d)"
    trap 'rm -rf "$workdir"' EXIT

    release_json="$workdir/release.json"
    curl -fsSL https://api.github.com/repos/Schniz/fnm/releases/latest -o "$release_json"
    download_url="$(jq -r --arg asset "$asset" '
        .assets[] | select(.name == $asset) | .browser_download_url
    ' "$release_json")"

    [[ -n $download_url && $download_url != null ]] || die "Could not find fnm release asset: $asset"
    curl -fsSL "$download_url" -o "$workdir/fnm.zip"
    unzip -p "$workdir/fnm.zip" fnm > "$localbin/fnm"
    chmod 0755 "$localbin/fnm"
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
