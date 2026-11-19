# Keep user-installed commands available to all shell integrations.
typeset -U path
path=("$HOME/.local/bin" "${path[@]}")

# Enable colored file listings.
export CLICOLOR=1

# Load modular shell configuration.
for config_file in "$HOME"/.config/zsh/*.zsh(N); do
    source "$config_file"
done
unset config_file
