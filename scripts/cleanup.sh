#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

if dpkg-query -W -f='${Status}' libreoffice-core 2>/dev/null | grep -q 'install ok installed'; then
    log 'Removing LibreOffice...'
    sudo apt-get purge -y --auto-remove 'libreoffice*'
else
    log 'LibreOffice is not installed.'
fi

if command -v snap >/dev/null 2>&1; then
    log 'Removing installed Snap packages...'
    mapfile -t snaps < <(snap list 2>/dev/null | awk 'NR > 1 {print $1}')
    for package in "${snaps[@]}"; do
        sudo snap remove --purge "$package" || warn "Could not remove Snap package: $package"
    done

    log 'Removing snapd...'
    sudo systemctl disable --now snapd.service snapd.socket 2>/dev/null || true
    sudo apt-get purge -y --auto-remove snapd
else
    log 'snapd is not installed.'
fi

success 'Uncommon software cleanup completed.'
