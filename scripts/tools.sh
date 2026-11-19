#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

packages=(build-essential cmake net-tools openssh-server vim jq ripgrep fd-find fzf bat tree)

log 'Installing common tools...'
sudo apt-get install -y "${packages[@]}"

# Ubuntu names these commands differently from other platforms.
mkdir -p "$localbin"
command -v fd >/dev/null 2>&1 || ln -sfn "$(command -v fdfind)" "$localbin/fd"
command -v bat >/dev/null 2>&1 || ln -sfn "$(command -v batcat)" "$localbin/bat"

success 'Common tools setup completed.'
