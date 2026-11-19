#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

[[ $os == Linux && $distro == ubuntu ]] || die 'This package setup requires Ubuntu.'

log 'Refreshing APT package metadata...'
sudo apt-get update

log 'Installing setup prerequisites...'
sudo apt-get install -y ca-certificates curl git gnupg unzip

success 'APT prerequisites installed.'
