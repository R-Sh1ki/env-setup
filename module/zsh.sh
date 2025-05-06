#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

info "The current shell is $(echo $SHELL)"

info "Installing zsh..."
sudo apt install -y zsh autojump

info "Install oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

info "Installing plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-autosuggestions

info "Install starship theme..."
curl -sS https://starship.rs/install.sh | sh

cp ./dotfile/.zshrc $HOME/.zshrc
cp ./dotfile/starship.toml $HOME/.config/starship.toml

chsh -s /bin/zsh