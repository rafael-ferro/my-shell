# User configuration
DEFAULT_USER="rafael"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/.local/share:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/${DEFAULT_USER}/.oh-my-zsh"

# Anaconda3 path
export PATH="/home/${DEFAULT_USER}/.anaconda3/bin:$PATH"

# Apache Spark path
export SPARK_HOME="/home/${DEFAULT_USER}/.spark-2.4.3-bin-hadoop2.7"
export PATH="/home/${DEFAULT_USER}/.spark-2.4.3-bin-hadoop2.7/bin:$PATH"
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# https://askubuntu.com/questions/54145/how-to-fix-strange-backspace-behaviour-with-urxvt-zsh
TERM="xterm-256color"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
#HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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
)

source $ZSH/oh-my-zsh.sh
# My aliases
source $HOME/.aliases

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=pt_BR.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


##############################################################################
# Powerlevel9k zhs-theme customization
# https://github.com/bhilburn/powerlevel9k
##############################################################################
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_insync_status root_indicator background_jobs battery)

# Dropbox status
prompt_dropbox_status() {
  local red='%F{red}'
  local NC='\033[0m' # No Color
  local dropbox_status="$(dropbox status)"
  local dropbox_filestatus="$(dropbox filestatus . | cut -d\  -f2-)"
  if [[ "$dropbox_status" = "Sincronização pausada" ]]; then
    echo -e -n "${red}Dropbox paused %D{%-H:%M:%S}"
  elif [[ "$dropbox_status" = "Dropbox isn't running!" ]]; then
    echo -e -n "${red}Dropbox offline %D{%-H:%M:%S}"
  else
    if [[ "$dropbox_filestatus" != 'unwatched' ]]; then
      dropbox_status="$(dropbox status | sed -n 1p | cut -d\  -f-1)"
      echo -e -n "Dropbox ${(L)dropbox_status} %D{%-H:%M:%S}"
    fi
  fi
}

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
#POWERLEVEL9K_ANACONDA_FOREGROUND='blue'
#POWERLEVEL9K_ANACONDA_BACKGROUND='grey'
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='grey'
#POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
#POWERLEVEL9K_VCS_CLEAN_BACKGROUND='grey'
#POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
#POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='grey'
#POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
#POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='grey'

