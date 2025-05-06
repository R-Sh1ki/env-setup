#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

info "Installing basic tools..."
sudo apt install -y git curl wget build-essential cmake net-tools openssh-server

info "Installing common editors..."
sudo apt install -y vim

code_installed=$(dpkg --get-selections | grep code)
if [[ -z $code_installed ]]; then
    info "Installing VSCode..."
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
    
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code # or code-insiders
fi

chrome_installed=$(dpkg --get-selections | grep google-chrome-stable)
if [[ -z $chrome_installed ]]; then
    info "Installing chrome browser."
    wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i chrome.deb
	rm -rf chrome.deb
fi
