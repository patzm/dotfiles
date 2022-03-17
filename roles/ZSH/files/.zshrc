# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Function definitions
check_zsh_theme() {
    if [[ ! -d "${ZSH_CUSTOM_THEMES}" ]]; then
        mkdir -p ${ZSH_CUSTOM_THEMES}
    fi
    THEME_INSTALL_FOLDER="${ZSH_CUSTOM_THEMES}/$1"
    if [[ ! -d $THEME_INSTALL_FOLDER ]]; then
        echo "\n${GREEN}ZSH-theme $1 not found. Downloading ...${NORMAL}"
        git clone --depth=1 $2 $THEME_INSTALL_FOLDER
        echo "Linking $THEME_INSTALL_FOLDER/*.zsh-theme to ${ZSH_THEMES}/"
        ln -sf $THEME_INSTALL_FOLDER/*.zsh-theme ${ZSH_THEMES}/
    fi
    unset THEME_INSTALL_FOLDER
}

check_zsh_plugin () {
    if [[ ! -d "${ZSH_PLUGINS}/$1" ]]; then
        echo "\n${GREEN}ZSH-plugin $1 not found. Downloading ...${NORMAL}"
        git clone $2 "${ZSH_PLUGINS}/$1"
    fi
}

# If you come from bash you might have to change your ${PATH}.
export PATH="${PATH}:/usr/local/sbin"

# Include the user's private bin directories
if [ -d "${HOME}/bin" ] ; then
    export PATH="${HOME}/bin:${PATH}"
fi
if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# If snap is installed
if [ -d "/snap/bin" ]; then
    export PATH="/snap/bin:${PATH}"
fi
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export ZSH_CONFIG=${XDG_CONFIG_HOME}/zsh
export ZSH=${HOME}/.oh-my-zsh
ZSH_GIT=${ZSH}/.git

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

if [ ! -d ${ZSH} ] || [ ! -d ${ZSH_GIT} ]; then
    # This script is an extract from https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    echo "oh-my-zsh not found in ${ZSH}. Downloading ..."
    # Only enable exit-on-error after the non-critical colorization stuff,
    # which may fail on systems lacking tput or terminfo
    set -e

    CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
    if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
        printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
        exit
    fi
    unset CHECK_ZSH_INSTALLED

    if [ ! -d ${ZSH_GIT} ]; then
        printf "${RED}Warning: ${ZSH} already exists but is not a repository\nClearing ...\n${NORMAL}"
        rm -rf ${ZSH}
    fi

    # Prevent the cloned repository from having insecure permissions. Failing to do
    # so causes compinit() calls to fail with "command not found: compdef" errors
    # for users with insecure umasks (e.g., "002", allowing group writability). Note
    # that this will be ignored under Cygwin by default, as Windows ACLs take
    # precedence over umasks except for filesystems mounted with option "noacl".
    umask g-w,o-w

    printf "${GREEN}Cloning Oh My Zsh...${NORMAL}\n"
    # The Windows (MSYS) Git is not compatible with normal use on cygwin
    if [ "$OSTYPE" = cygwin ]; then
        if git --version | grep msysgit > /dev/null; then
            echo "Error: Windows/MSYS Git is not supported on Cygwin"
            echo "Error: Make sure the Cygwin git package is installed and is first on the path"
            exit 1
        fi
    fi
    env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ${ZSH} || {
        printf "Error: git clone of oh-my-zsh repo failed\n"
        # exit 1
    }
fi
unset ZSH_GIT

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export ZSH_CUSTOM_THEMES=${ZSH}/custom/themes
export ZSH_THEMES=${ZSH}/themes

check_zsh_theme "powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"

ZSH_THEME="powerlevel10k/powerlevel10k"

[[ ! -f ${ZSH_CONFIG}/.p10k.zsh ]] || source ${ZSH_CONFIG}/.p10k.zsh

# Advanced renaming cmd line tool
autoload -U zmv

# Check if ZSH plugins are missing
export ZSH_PLUGINS=${ZSH}/custom/plugins

check_zsh_plugin "zshmarks" "https://github.com/jocelynmallon/zshmarks.git"
check_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
check_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
check_zsh_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions"

source ${ZSH_PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    docker
    git
    npm
    pip
    rsync
    tmux
    virtualenv
    virtualenvwrapper
    zsh-autosuggestions
    zsh-completions
    zshmarks
)

# Load all instance dependent settings
if [[ -f ${ZSH_CONFIG}/zshinstance ]]; then
    source ${ZSH_CONFIG}/zshinstance
fi

# Load all OS dependent settings
if [[ -f ${ZSH_CONFIG}/zshosdep ]]; then
    source ${ZSH_CONFIG}/zshosdep
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
# TODO: maybe handle this through ansible exclusively
GIT_AUTHOR_NAME="Martin Patz"
GIT_AUTHOR_EMAIL="mailto@martin-patz.de"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global credential.helper 'cache --timeout 36000'
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global pull.ff only
git config --global push.default simple
git config --global core.editor vim # Set a default editor to avoid "Could not execute editor" error

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Activate pattern reverse / forward search
bindkey '^X^R' history-incremental-pattern-search-backward
bindkey '^X^S' history-incremental-pattern-search-forward

# Allow inserting new lines in commands pulled from the history
bindkey '^[^M' self-insert-unmeta

unsetopt auto_name_dirs
unset -f check_zsh_plugin
unset -f check_zsh_theme

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Python and virtualenv
export WORKON_HOME=${HOME}/.venvs
export VIRTUAL_ENV_DISABLE_PROMPT=
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENV_PYTHON=$(which python3.7 || which python3)
if [[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]; then
    . /usr/local/bin/virtualenvwrapper.sh
fi

# vim: set filetype=zsh : 
