#!/usr/bin/env bash

# Source this file to use log, success, warn, and die functions.
# ANSI palette colors follow the terminal's theme.
fmtprint() {
    local ending=$'\n'
    if [[ $1 == -n ]]; then
        ending=' '
        shift
    fi

    local fd=$1 color=$2 label=$3
    shift 3

    if [[ -t $fd && ${TERM:-} != dumb && -z ${NO_COLOR:-} ]]; then
        printf '\033[%sm[%s]\033[0m %s%s' "$color" "$label" "$*" "$ending" >&"$fd"
    else
        printf '[%s] %s%s' "$label" "$*" "$ending" >&"$fd"
    fi
}

log() {
    fmtprint 1 36 INFO "$@"
}

success() {
    fmtprint 1 32 ' OK ' "$@"
}

warn() {
    fmtprint 2 33 WARN "$@"
}

die() {
    fmtprint 2 31 ERROR "$@"
    exit 1
}

prompt() {
    local label=$1
    shift
    fmtprint -n 1 34 "$label" "$@"
}
