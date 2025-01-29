#!/bin/bash

if [[ -z $format_sourced ]]; then
  source ./libs/format-output.sh
fi

desc "Install neovim..."
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim
sudo apt-get install -y python3-dev python3-pip

desc "Install fd, rg..."
sudo apt-get install -y fd-find ripgrep

desc "Install npm, node, php..."
sudo apt-get install -y python3.10-venv
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs php php-cli 
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo apt-get install -y ruby-full
sudo apt-get install -y golang-go
sudo apt-get install -y luarocks 
sudo apt-get install -y openjdk-18-jdk 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://install.julialang.org | sh

