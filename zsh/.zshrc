fpath+=~/.zfunc

export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:/home/vadickozlov/.local/bin/"

ZSH_THEME="agnoster"
ZSH_DISABLE_COMPFIX=true
plugins=(
    git
    zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-autocomplete
)
source ~/.zshaddons
source $ZSH/oh-my-zsh.sh

if [[ -z "$TMUX"  ]] && [ "$SSH_CONNECTION" != ""  ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

bindkey "^X\x7f" backward-kill-line
