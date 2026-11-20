#!/usr/bin/env bash
set -Eeuo pipefail

repodir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$repodir/scripts/lib/common.sh"

[[ $os == Linux && $distro == ubuntu ]] || die 'This setup requires Ubuntu.'
prepare_paths

# Install prerequisites in this order.
# prerequisites=(apt zsh)
prerequisites=(zsh)

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
done

run_installers
