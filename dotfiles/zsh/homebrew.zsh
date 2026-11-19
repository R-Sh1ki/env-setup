
# Add Homebrew commands to PATH.
case "$(uname -m)" in
    arm64)
        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        ;;
    x86_64)
        if [[ -x /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        ;;
esac
