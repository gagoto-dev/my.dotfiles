USE_CONDA=0
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load zsh-completions
autoload -U compinit && compinit

# Keybindings
bindkey -e

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

alias ls='ls --color'
alias ll='ls -lA'

# Github aliases
alias ggs='git status'
alias gga='git add'
alias ggc='git commit -m'
alias ggcd='git checkout'
alias ggpull='git pull'
alias ggpush='git push'

alias python="python3"
alias sqlite="sqlite3"
path+=('/opt/nvim/bin')

export GOROOT=/usr/local/go-1.24.1
export GOPATH=$HOME/go

path+=($GOPATH/bin)
export PATH=$PATH:/usr/local/go-1.24.1/bin
alias go="/usr/local/go-1.24.1/bin/go"

export PATH=$PATH:$HOME/bin
typeset -T LD_LIBRARY_PATH ld_library_path

# Set up fzf key bindings and fuzzy completion
# source /usr/share/doc/fzf/examples/key-bindings.zsh
source <(fzf --zsh)

# pnpm
export PNPM_HOME="/home/gaspar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Pomodoro
# Requires https://github.com/caarlos0/timer to be installed. spd-say should ship with your distro
# https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7
declare -A pomo_options
pomo_options["work"]="50"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"

alias reload="source ~/.zshrc"
alias nvimpull="~/pull_nvim.sh"

# eval "tmux source ~/.tmux.conf"

# CUDA Paths
export PATH=/usr/local/cuda-12.8/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64\ ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

if [ $USE_CONDA -eq 1 ]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/gaspar/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/gaspar/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/gaspar/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/gaspar/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi
