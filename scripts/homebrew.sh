#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

[[ $os == Darwin ]] || die 'This Homebrew setup requires macOS.'

case "$arch" in
    arm64) brew_bin='/opt/homebrew/bin/brew' ;;
    x86_64) brew_bin='/usr/local/bin/brew' ;;
    *) die "Unsupported architecture: $arch" ;;
esac

# Install mirror settings and shell initialization.
brew_config="$HOME/.homebrew"
mkdir -p "$brew_config" "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/brew.env" "$brew_config/brew.env"
install -m 0644 "$repodir/dotfiles/zsh/homebrew.zsh" "$configdir/zsh/homebrew.zsh"

# Apply mirror settings to the Homebrew installer too.
set -a
source "$brew_config/brew.env"
set +a

if [[ ! -x $brew_bin ]]; then
    log 'Installing Homebrew...'
    installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /bin/bash -c "$installer"
fi

[[ -x $brew_bin ]] || die "Homebrew executable not found: $brew_bin"
"$brew_bin" --version
success 'Homebrew setup completed.'
