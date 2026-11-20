# Keep user-installed commands available to all shell integrations.
typeset -U path
path=("$HOME/.local/bin" "${path[@]}")

# Enable colored file listings.
export CLICOLOR=1
export LS_COLORS="${LS_COLORS:-$(command -v dircolors >/dev/null 2>&1 && dircolors -b | sed -n 's/^LS_COLORS='"'"'\(.*\)'"'"'; export LS_COLORS.*$/\1/p')}"
alias ls='ls --color=auto'

# Load modular shell configuration.
for config_file in "$HOME"/.config/zsh/*.zsh(N); do
    source "$config_file"
done
unset config_file
