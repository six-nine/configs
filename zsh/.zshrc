fpath+=~/.zfunc

export ZSH="$HOME/.oh-my-zsh"

export PATH="/home/vadickozlov/.local/clangd_17.0.3/bin:/home/vadickozlov/.local/bin:$HOME/.cargo/bin:$PATH"
export LD_LIBRARY_PATH="/home/vadickozlov/.local/clangd_17.0.3/lib:$LD_LIBRARY_PATH"

ZSH_THEME="jonathan"
ZSH_DISABLE_COMPFIX=true
plugins=(
    git
    fast-syntax-highlighting
    arc-prompt
)
source ~/.zshaddons
source $ZSH/oh-my-zsh.sh

if [[ -z "$TMUX"  ]] && [ "$SSH_CONNECTION" != ""  ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

alias nvim="/usr/local/bin/nvim"
alias vimdiff='nvim -d'

