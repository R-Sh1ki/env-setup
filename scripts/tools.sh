#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

tools=(git curl wget jq ripgrep fd fzf bat tree)

# Use existing commands regardless of installation source.
for tool in "${tools[@]}"; do
    cmd="$tool"
    [[ $tool == ripgrep ]] && cmd=rg

    if command -v "$cmd" >/dev/null 2>&1 &&
        { [[ $tool != git ]] || git --version >/dev/null 2>&1; }; then
        log "$tool is already installed."
    else
        log "Installing $tool..."
        brew install "$tool"
    fi
done

success 'Common tools setup completed.'
