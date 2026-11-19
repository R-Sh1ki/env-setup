# Go data and installed commands.
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"

# Add Go commands to PATH without duplicates.
typeset -U path
path=("$GOBIN" "${path[@]}")
