# Rust toolchain mirror.
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# Include rustup and commands installed with Cargo.
typeset -U path
path=("${CARGO_HOME:-$HOME/.cargo}/bin" "${path[@]}")
