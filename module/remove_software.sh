#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

package_exists() {
    dpkg -l "$1" &> /dev/null
}

remove_snap_packages() {
    packages=$(snap list | awk "NR > 1 {print $1}")
    for snap_package in $packages; do
        info "Removing $snap_package..."
        sudo snap remove "$snap_package" || true
        sleep 2
    done
}

remove_snapd() {
    sudo systemctl stop snapd || true
    sudo systemctl disable snapd || true
    sudo systemctl mask snapd || true

    sudo apt purge -y snapd || true
}


if package_exists "libreoffice-core"; then
    info "Detect LibreOffice."
    info "Removing libreoffice..."
    sudo apt purge -y --auto-remove \
        libreoffice* \
        libreoffice-core \
        libreoffice-common \
        libreoffice-style*
fi

# First, remove snapd if it's installed
info "Removing snap..."
remove_snapd

# Remove all Snap packages
while snap list | awk 'NR > 1 {print $1}' | grep .; do
    remove_snap_packages
    echo "Waiting for Snap packages to be fully removed..."
    sleep 5
done