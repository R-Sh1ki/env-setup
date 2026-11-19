#!/usr/bin/env bash
set -Eeuo pipefail

repodir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$repodir/scripts/lib/common.sh"

# Install prerequisites in this order.
prerequisites=(homebrew zsh)

confirm() {
    local reply

    prompt INSTALL "$1 [Y/n]"
    read -r reply
    [[ -z $reply || $reply =~ ^[Yy]$ ]]
}

run_installers() {
    local script label prerequisite

    for script in "$repodir"/scripts/*.sh; do
        [[ -f $script ]] || continue
        label="$(basename "${script%.sh}")"

        for prerequisite in "${prerequisites[@]}"; do
            [[ $label == "$prerequisite" ]] && continue 2
        done

        if confirm "Install ${label}?"; then
            repodir="$repodir" bash "$script"
        fi
    done
}

for prerequisite in "${prerequisites[@]}"; do
    repodir="$repodir" bash "$repodir/scripts/$prerequisite.sh"

    # Update the parent shell before running dependent installers.
    if [[ $prerequisite == homebrew ]]; then
        source "$configdir/zsh/homebrew.zsh"
    fi
done

run_installers
