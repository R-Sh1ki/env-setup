#!/usr/bin/env bash

os="$(uname -s)"
kernel="$(uname -r)"
arch="$(uname -m)"

distro=''
distro_version=''
if [[ -r /etc/os-release ]]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    distro="${ID:-}"
    distro_version="${VERSION_ID:-}"
fi
