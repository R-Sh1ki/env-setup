#!/bin/bash

if [[ -z $format_sourced ]]; then 
	source ./libs/format-output.sh
fi

desc "The current shell is $(echo $SHELL)"

desc "Install zsh..."
sudo apt install -y zsh autojump

desc "Install oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

desc "Install plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-autosuggestions

desc "Install spaceship theme..."
sudo apt-get install -y fonts-powerline
git clone https://github.com/spaceship-prompt/spaceship-prompt.git ${HOME}/.oh-my-zsh/custom/themes/spaceship-prompt --depth=1
ln -s ${HOME}/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ${HOME}/.oh-my-zsh/themes/spaceship.zsh-theme 

chsh -s /bin/zsh
