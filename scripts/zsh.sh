#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

if command -v zsh >/dev/null 2>&1; then
    log 'Zsh is already installed.'
else
    log 'Installing Zsh...'
    sudo apt-get install -y zsh
fi

mkdir -p "$configdir/zsh"
for config in alias proxy; do
    install -m 0644 "$repodir/dotfiles/zsh/$config.zsh" "$configdir/zsh/$config.zsh"
done

zshrc="${ZDOTDIR:-$HOME}/.zshrc"
if [[ ! -e $zshrc && ! -L $zshrc ]]; then
    mkdir -p "$(dirname "$zshrc")"
    install -m 0644 "$repodir/dotfiles/.zshrc" "$zshrc"
    success "Installed $zshrc."
elif cmp -s "$repodir/dotfiles/.zshrc" "$zshrc"; then
    log 'Zsh configuration is already up to date.'
else
    warn "Keeping $zshrc; add the loader from dotfiles/.zshrc manually."
fi

success 'Zsh setup completed.'
log "Zsh executable: $(command -v zsh)"
log 'Your login shell has not been changed; run chsh -s "$(command -v zsh)" if desired.'
