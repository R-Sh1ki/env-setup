#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

info "Backup ubuntu sources and use USTC mirror sources..."

# sources.list format
if [[ ! -f /etc/apt/sources.list.bak ]]; then
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
fi
sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list

# DEB822 format
if [[ -f /etc/apt/sources.list.d/ubuntu.sources ]]; then
    if [[ ! -f /etc/apt/sources.list.d/ubuntu.sources.bak ]]; then
        sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak
    fi
    sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
fi

info "Update and upgrade software..."
sudo apt-get update
sudo apt-get -y upgrade