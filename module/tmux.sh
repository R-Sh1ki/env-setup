#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

info "Install tmux..."
sudo apt-get install -y tmux xclip

info "Install tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp ./dotfile/.tmux.conf $HOME/.tmux.conf