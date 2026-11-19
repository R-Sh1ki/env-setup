#!/usr/bin/env bash
set -Eeuo pipefail

# Load paths and logging helpers.
repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "${repodir}/scripts/lib/common.sh"

[[ $os == Darwin ]] || die 'MacTeX installation requires macOS.'

log 'Installing MacTeX...'
brew install --cask mactex-no-gui

success 'MacTeX setup completed.'
