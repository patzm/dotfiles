# If you come from bash you might have to change your ${PATH}.
export PATH="${PATH}:/usr/local/sbin"

# Include the user's private bin directories
if [ -d "${HOME}/bin" ] ; then
    export PATH="${HOME}/bin:${PATH}"
fi
if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export ZSH_CONFIG=${XDG_CONFIG_HOME}/zsh
export ZSH=${HOME}/.oh-my-zsh

# Advanced renaming cmd line tool
autoload -U zmv

# Check if ZSH plugins are missing
export ZSH_PLUGINS=${ZSH}/custom/plugins

source ${ZSH_PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    docker
    git
    k
    pip
    rsync
    tmux
    zsh-autosuggestions
    zsh-completions
    zshmarks
)

# Set name of the theme to load. "random" is also an option.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export ZSH_CUSTOM_THEMES=${ZSH}/custom/themes
export ZSH_THEMES=${ZSH}/themes
ZSH_THEME="fino-time"

# Load all OS dependent settings
if [[ -f ${ZSH_CONFIG}/zshosdep ]]; then
    source ${ZSH_CONFIG}/zshosdep
fi

# Load all instance dependent settings
if [[ -f ${ZSH_CONFIG}/zshinstance ]]; then
    source ${ZSH_CONFIG}/zshinstance
fi

# Load all aliases
if [[ -f ${HOME}/.bash_aliases ]]; then
    source ${HOME}/.bash_aliases
fi

# Load oh-my-zsh
source ${ZSH}/oh-my-zsh.sh

# User configuration
tabs -4

# GIT
if [[ ! -d "${HOME}/.git" ]]; then
    mkdir "${HOME}/.git"
fi

# You may need to manually set your language environment
export LC_ALL=C
export LANG=en_US.UTF-8

# Activate pattern reverse / forward search
bindkey '^X^R' history-incremental-pattern-search-backward
bindkey '^X^S' history-incremental-pattern-search-forward

# Allow inserting new lines in commands pulled from the history
bindkey '^[^M' self-insert-unmeta

unsetopt auto_name_dirs

# Add a new line before 
precmd() { print "" }

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Python, pyenv, and virtualenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv virtualenvwrapper

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=${HOME}/.venvs
export VIRTUALENVWRAPPER_HOOK_DIR="${XDG_CONFIG_HOME}/virtualenvwrapper"
export VIRTUAL_ENV_DISABLE_PROMPT=

# vim: set filetype=zsh : 
