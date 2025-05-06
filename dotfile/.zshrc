export ZSH="$HOME/.oh-my-zsh"
plugins=(git autojump zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"