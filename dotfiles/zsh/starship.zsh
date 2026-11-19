# Initialize the Starship prompt.
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi
