# User configuration
DEFAULT_USER="rafael"

# Path to your oh-my-zsh installation.
export ZSH="/home/${DEFAULT_USER}/.config/oh-my-zsh"

# Anaconda3 path
export PATH="/home/${DEFAULT_USER}/.anaconda3/bin:$PATH"

# Apache Spark path
export SPARK_HOME="/home/${DEFAULT_USER}/.spark-2.4.3-bin-hadoop2.7"
export PATH="/home/${DEFAULT_USER}/.spark-2.4.3-bin-hadoop2.7/bin:$PATH"
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# https://askubuntu.com/questions/54145/how-to-fix-strange-backspace-behaviour-with-urxvt-zsh
TERM="xterm-256color"

ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  virtualenv
  python
  pyenv
  colorize
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# My aliases
source $HOME/.aliases

# You may need to manually set your language environment
export LANG=pt_BR.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

##############################################################################
# Powerlevel9k zhs-theme customization
# https://github.com/bhilburn/powerlevel9k
##############################################################################
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_insync_status root_indicator background_jobs battery)

# Insync status
# https://help.insynchq.com/installation-on-windows-linux-and-macos/advanced/linux-controlling-insync-via-command-line-cli
prompt_insync_status() {
  local red='%F{red}'
  local NC='\033[0m' # No Color
  local insync_drive_status="$(insync get_file_status $(pwd))"
  local insync_status="$(insync get_status)"
  insync_drive_status="${(L)insync_drive_status}"
  insync_status="${(L)insync_status}"
  if [[ "$insync_status" = "paused" ]] || [[ "$insync_status" = "offline" ]] || [[ "$insync_status" = "error" ]]; then
    echo -e -n "${red}Isync ${insync_status} %D{%-H:%M:%S}"
  elif [[ "$insync_drive_status" = "synced" ]] || [[ "$insync_drive_status" = "syncing" ]]; then
    echo -e -n "${insync_drive_status} %D{%-H:%M:%S}"
  fi
}

POWERLEVEL9K_CUSTOM_DROPBOX_STATUS="prompt_dropbox_status"
POWERLEVEL9K_CUSTOM_INSYNC_STATUS="prompt_insync_status"
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5


# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

