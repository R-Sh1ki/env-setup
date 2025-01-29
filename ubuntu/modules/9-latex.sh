#!/bin/bash

if [[ -z $format_sourced ]]; then
  source ./libs/output-format.sh
fi

desc "Install texlive..."
sudo apt-get install -y texlive-full

desc "Install zathura..."
sudo apt-get install -y zathura
mkdir ~/.config/zathura
cp ./dotfiles/zathurarc ~/.config/zathura

pip install neovim-remote
