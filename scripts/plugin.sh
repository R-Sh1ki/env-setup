#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

# Download missing plugins.
plugindir="$localshare/zsh/plugins"
[[ -d "$plugindir" ]] || mkdir -p "$plugindir"

for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    if [[ -d "$plugindir/$plugin" ]]; then
        log "$plugin is already installed."
    else
        log "Installing $plugin..."
        git clone --depth 1 \
            "https://github.com/zsh-users/$plugin.git" \
            "$plugindir/$plugin"
    fi
done

# Install zoxide if missing.
if command -v zoxide >/dev/null 2>&1; then
    log 'zoxide is already installed.'
else
    log 'Installing zoxide...'
    brew install zoxide
fi

# Install the Zsh loader.
[[ -d "$configdir/zsh" ]] || mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/plugin.zsh" "$configdir/zsh/plugin.zsh"

success 'Zsh plugins installed.'
log 'Start a new Zsh session or run: source ~/.zshrc'
