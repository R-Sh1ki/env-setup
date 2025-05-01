#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

desc "Install web tools (git, curl, wget)..."
sudo apt-get install -y git curl wget

desc "Install media tools (okular, mpv)..."
sudo apt-get install -y okular mpv

desc "Install program compiler(gcc, g++, cmake)..."
sudo apt-get install -y build-essential cmake

desc "Install input method..."
sudo apt-get install -y fcitx5 fcitx5-chinese-addons

desc "Install nerd-font..."
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ../
rm -rf nerd-fonts

desc "Install google chrome..."
is_installed=$(dpkg --get-selections | grep google-chrome-stable)
if [[ -z $is_installed ]]; then
	wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i chrome.deb
	rm -rf chrome.deb
else
	desc " - Google chrome has installed."
fi
