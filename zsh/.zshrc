fpath+=~/.zfunc

export ZSH="$HOME/.oh-my-zsh"

pip install cowsay > /dev/null
cowsay -t "Hello, $(whoami)"

ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true
plugins=(git)
source ~/.zshaddons
source $ZSH/oh-my-zsh.sh

if [[ -z "$TMUX"  ]] && [ "$SSH_CONNECTION" != ""  ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

bindkey "^X\x7f" backward-kill-line
