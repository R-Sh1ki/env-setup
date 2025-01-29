#!/bin/bash

desc() {
	if [[ -z $TERM ]]; then
		echo $1
	else
		echo $(tput setaf 14; tput bold)$1$(tput sgr0)
	fi
}

warning() {
	if [[ -z $TERM ]]; then
		echo $1
	else
		echo $(tput setaf 11; tput bold)$1$(tput sgr0)
	fi
}

error() {
	if [[ -z $TERM ]]; then
		echo $1
	else
		echo $(tput setaf 1; tput bold)$1$(tput sgr0)
	fi
}

query() {
	if [[ -z $TERM ]]; then
		echo -n $1
	else
		echo -n $(tput setaf 9; tput bold)$1$(tput sgr0)
	fi
}


selector() {
	text="$@ [y/N]"
	while true; do
		query "${text}"

		read -p " " opt
		
		case ${opt} in
			[Yy]*)
				return;;
			[Nn]* | "")
				break;;
			*)
				warning "Invaild Input!";;
		esac
	done
	false
}

confirm() {
	func=$1
	text=${@:2}

	if selector ${text}; then
		${func}
	fi
}
