# Rust toolchain mirror.
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# Use Homebrew's Rust toolchain commands.
if [[ -n ${HOMEBREW_PREFIX:-} && -d "$HOMEBREW_PREFIX/opt/rustup/bin" ]]; then
    path=("$HOMEBREW_PREFIX/opt/rustup/bin" "${path[@]}")
fi

# Include rustup and commands installed with cargo.
typeset -U path
path=("${CARGO_HOME:-$HOME/.cargo}/bin" "${path[@]}")
