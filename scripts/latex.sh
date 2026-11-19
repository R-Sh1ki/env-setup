#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

[[ $os == Linux && $distro == ubuntu ]] || die 'TeX Live installation requires Ubuntu.'

log 'Installing TeX Live...'
sudo apt-get install -y texlive-full

success 'TeX Live setup completed.'
