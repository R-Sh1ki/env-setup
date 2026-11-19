#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

log 'Installing tmux...'
sudo apt-get install -y tmux xclip

plugin_dir="$HOME/.tmux/plugins/tpm"
if [[ -d "$plugin_dir/.git" ]]; then
    log 'Tmux Plugin Manager is already installed.'
else
    [[ ! -e $plugin_dir ]] || die "TPM path exists but is not a Git repository: $plugin_dir"
    mkdir -p "$(dirname "$plugin_dir")"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$plugin_dir"
fi

if [[ ! -e "$HOME/.tmux.conf" && ! -L "$HOME/.tmux.conf" ]]; then
    install -m 0644 "$repodir/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
elif ! cmp -s "$repodir/dotfiles/.tmux.conf" "$HOME/.tmux.conf"; then
    warn 'Keeping existing ~/.tmux.conf; merge dotfiles/.tmux.conf manually.'
fi

success 'tmux setup completed.'
