# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.config/oh-my-zsh"

# Set language
export LANG=pt_BR.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rafael/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rafael/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rafael/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/rafael/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Install Ruby Gems to ~/.gems
# https://jekyllrb.com/docs/installation/ubuntu/
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.gems/bin:$PATH"

# Plugins can be found in ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
#
# Add wisely, as too many plugins slow down shell startup.
#
# Instalar zsh-syntax-highlight:
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~ZSH_CUSTOM/plugins/zsh-syntax-highlighting
plugins=(
  extract
  zsh-syntax-highlighting
  vi-mode
)

# Enable vim mode
bindkey -v

# Map 'jj' to escape to vim command mode
bindkey çç vi-cmd-mode

# Make 'Alt+.' insert last argument from previous command
bindkey '\e.' insert-last-word

VI_MODE_SET_CURSOR=true

# https://askubuntu.com/questions/54145/how-to-fix-strange-backspace-behaviour-with-urxvt-zsh
TERM="xterm-256color"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh

# My aliases
source $HOME/.aliases

