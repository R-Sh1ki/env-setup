#!/usr/bin/env bash

# Personal software root.
localroot="$HOME/.local"

# Commands and symlinks; add to PATH.
localbin="${localroot}/bin"
# Manually installed apps.
localopt="${localroot}/opt"
# Source code for manual builds.
localsrc="${localroot}/src"
# Application data.
localshare="${localroot}/share"
# Logs, history, and session state.
localstate="${localroot}/state"

# Application settings.
configdir="$HOME/.config"
# Disposable caches.
cachedir="$HOME/.cache"

prepare_paths() {
    mkdir -p "$localbin" "$localopt" "$localsrc" "$localshare" "$localstate"
    mkdir -p "$configdir" "$cachedir"
}
