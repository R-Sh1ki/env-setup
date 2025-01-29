#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

desc "Install gnome-tweaks..."
sudo apt-get install -y gnome-tweaks gnome-shell-extensions chrome-gnome-shell

desc "Install themes..."
if [[ ! -d "${HOME}/.themes" ]]; then
	mkdir "${HOME}/.themes"
else
	desc " - The .themes dir has existed!"
fi

for file in $(ls ./assets/themes/)
do
	tar xJf ./assets/themes/${file} -C ${HOME}/.themes/
done


desc "Install icons..."
if [[ ! -d "${HOME}/.icons" ]]; then
	mkdir "${HOME}/.icons"
else
	desc " - The .icons dir has existed!"
fi

for file in $(ls ./assets/icons/)
do
	tar xJf ./assets/icons/${file} -C ${HOME}/.icons/
done


desc "Install cursor themes..."
git clone https://github.com/yeyushengfan258/ArcMidnight-Cursors.git

if [[ ! -d "${HOME}/.icons/ArcMidnight" ]]; then
	mkdir "${HOME}/.icons/ArcMidnight"
fi

cp -r ArcMidnight-Cursors/dist/cursors/ ~/.icons/ArcMidnight/

rm -rf ArcMidnight-Cursors

desc "Install gnome-nord-terminal..."
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src

./nord.sh

cd ../../
rm -rf nord-gnome-terminal

desc "Install plymouth theme..."
sudo apt-get install -y plymouth libplymouth5 plymouth-label

git clone https://github.com/emanuele-scarsella/vortex-ubuntu-plymouth-theme.git
cd vortex-ubuntu-plymouth-theme/
sudo chmod u+x install
sudo ./install
cd ../

rm -rf vortex-ubuntu-plymouth-theme/


