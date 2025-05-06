#!/bin/bash

FORMAT_OUTPUT=1

# check that 1. terminal exists, 2. standard output is a terminal, and 3. supports color.
if [[ -t 1 ]] && [[ -n "$TERM" ]] && [[ "$TERM" != "dumb" ]]; then
	COLOR_RESET=$'\e[0m'
	COLOR_INFO=$'\e[1;32m'
	COLOR_WARNING=$'\e[1;33m'
	COLOR_ERROR=$'\e[1;31m'
	COLOR_QUERY=$'\e[1;36m'
else
	COLOR_RESET=""
	COLOR_INFO=""
	COLOR_WARNING=""
	COLOR_ERROR=""
	COLOR_QUERY=""
fi

# info message: info [text]
info() {
	printf "%s[INFO]: %s%s\n" "${COLOR_INFO}" "$*" "${COLOR_RESET}"
}

# warning message: warning [text]
warning() {
	printf "%s[WARNING]: %s%s\n" "${COLOR_WARNING}" "$*" "${COLOR_RESET}"
}

# error message: error [text]
error() {
	printf "%s[ERROR]: %s%s\n" "${COLOR_ERROR}" "$*" "${COLOR_RESET}"
}

# query message: query [text]
query() {
	printf "%s%s%s" "${COLOR_QUERY}" "$*" "${COLOR_RESET}"
}

# confirmation_prompt: confirmation_prompt [text]
confirmation_prompt() {
	prompt="$@ "
	prompt_suffix="[y/N]"

	while true; do
		query "$prompt" "$prompt_suffix"
		read -p " " choice

		case $choice in
			[Yy]*) return;;
			[Nn]*) break;;
			"") break;;
			*) warning "Please answer Y(es) or N(o).";;
		esac

	done

	false
}

# confirmation: comfirmation [text] [func]
confirmation() {
	prompt="$1"
	prompt_func="$2"

	if confirmation_prompt ${prompt}; then
		${prompt_func}
	fi
}
