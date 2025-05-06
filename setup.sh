#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

sudo chmod u+x ./module/*.sh

./module/systeminfo_display.sh

confirmation "[1] Do you want to change the source and update the software?" ./module/software_update.sh

confirmation "[2] Do you want to uninstall uncommon software (snap, libreoffice)?" ./module/remove_software.sh

confirmation "[3] Do you want to install common utils?" ./module/common_utils.sh

confirmation "[4] Do you want to optimize the appearance?" ./module/appearance.sh

confirmation "[5] Do you want to install and set ZSH as the default shell?" ./module/zsh.sh

confirmation "[6] Do you want to install tmux?" ./module/tmux.sh