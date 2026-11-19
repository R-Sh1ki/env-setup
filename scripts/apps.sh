#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

if command -v code >/dev/null 2>&1; then
    log 'Visual Studio Code is already installed.'
else
    log 'Installing Visual Studio Code repository...'
    sudo install -d -m 0755 /etc/apt/keyrings
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc |
        gpg --dearmor |
        sudo tee /etc/apt/keyrings/packages.microsoft.gpg >/dev/null
    sudo chmod 0644 /etc/apt/keyrings/packages.microsoft.gpg
    echo 'deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' |
        sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
    sudo apt-get update
    sudo apt-get install -y code
fi

if command -v google-chrome >/dev/null 2>&1; then
    log 'Google Chrome is already installed.'
elif [[ $arch == x86_64 ]]; then
    log 'Installing Google Chrome...'
    deb="$(mktemp --suffix=.deb)"
    trap 'rm -f "$deb"' EXIT
    curl -fsSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o "$deb"
    sudo apt-get install -y "$deb"
else
    warn "Google Chrome is unavailable for Ubuntu architecture: $arch"
fi

success 'Desktop applications setup completed.'
