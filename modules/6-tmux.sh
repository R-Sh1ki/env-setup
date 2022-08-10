#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

desc "Install tmux..."
sudo apt-get install -y tmux

desc "Install tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

