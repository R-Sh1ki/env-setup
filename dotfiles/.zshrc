# Enable colored file listings.
export CLICOLOR=1

# Initialize Homebrew before tools such as fnm.
if [[ -f "$HOME/.config/zsh/homebrew.zsh" ]]; then
    source "$HOME/.config/zsh/homebrew.zsh"
fi

# Load the remaining shell configuration.
for config_file in "$HOME"/.config/zsh/*.zsh(N); do
    [[ "$config_file" == "$HOME/.config/zsh/homebrew.zsh" ]] && continue
    source "$config_file"
done
unset config_file
