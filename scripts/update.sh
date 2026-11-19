#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

log 'Backing up Ubuntu sources and selecting the USTC mirror...'

if [[ -f /etc/apt/sources.list ]]; then
    [[ -f /etc/apt/sources.list.bak ]] || sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo sed -i 's@//[^ /]*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
fi

sources=/etc/apt/sources.list.d/ubuntu.sources
if [[ -f $sources ]]; then
    [[ -f ${sources}.bak ]] || sudo cp "$sources" "${sources}.bak"
    sudo sed -i 's@//[^ /]*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' "$sources"
fi

log 'Updating Ubuntu packages...'
sudo apt-get update
sudo apt-get upgrade -y
success 'Ubuntu packages updated.'
