# Function definitions
program_installed() {
    if hash "$1" 2>/dev/null; then
        return 0 # true
    else
        echo "$1 does not seem to be installed"
        return 1 # false
    fi
}

check_zsh_theme() {
    if [[ ! -d "$ZSH_CUSTOM_THEMES" ]]; then
        mkdir -p $ZSH_CUSTOM_THEMES
    fi
    THEME_INSTALL_FOLDER="$ZSH_CUSTOM_THEMES/$1"
    if [[ ! -d $THEME_INSTALL_FOLDER ]]; then
        echo "\n${GREEN}ZSH-theme $1 not found. Downloading ...${NORMAL}"
        git clone $2 $THEME_INSTALL_FOLDER
        echo "Linking $THEME_INSTALL_FOLDER/*.zsh-theme to $ZSH_THEMES/"
        ln -sf $THEME_INSTALL_FOLDER/*.zsh-theme $ZSH_THEMES/
    fi
    unset THEME_INSTALL_FOLDER
}

check_zsh_plugin () {
	if [[ ! -d "$ZSH_PLUGINS/$1" ]]; then
		echo "\n${GREEN}ZSH-plugin $1 not found. Downloading ...${NORMAL}"
		git clone $2 "$ZSH_PLUGINS/$1"
	fi
}

mkcdir () {
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

o () {
    gnome-open "$1" 2> /dev/null &
}

# If you come from bash you might have to change your $PATH.
export PATH=$PATH:/usr/local/sbin
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH=$HOME/bin:$PATH
fi
# If snap is installed
if [ -d "/snap/bin" ]; then
	export PATH=/snap/bin:$PATH
fi
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export ZSH=${HOME}/.oh-my-zsh

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

if [ ! -d $ZSH ]; then
	# This script is an extract from https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	echo "oh-my-zsh not found in $ZSH. Downloading ..."
	# Only enable exit-on-error after the non-critical colorization stuff,
	# which may fail on systems lacking tput or terminfo
	set -e

	CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
	if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
		printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
		exit
	fi
	unset CHECK_ZSH_INSTALLED

	if [ ! -n "$ZSH" ]; then
		ZSH=~/.oh-my-zsh
	fi

	if [ -d "$ZSH" ]; then
		printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
		printf "You'll need to remove $ZSH if you want to re-install.\n"
		exit
	fi

	# Prevent the cloned repository from having insecure permissions. Failing to do
	# so causes compinit() calls to fail with "command not found: compdef" errors
	# for users with insecure umasks (e.g., "002", allowing group writability). Note
	# that this will be ignored under Cygwin by default, as Windows ACLs take
	# precedence over umasks except for filesystems mounted with option "noacl".
	umask g-w,o-w

	printf "${GREEN}Cloning Oh My Zsh...${NORMAL}\n"
	hash git >/dev/null 2>&1 || {
		echo "Error: git is not installed"
		exit 1
	}
	# The Windows (MSYS) Git is not compatible with normal use on cygwin
	if [ "$OSTYPE" = cygwin ]; then
		if git --version | grep msysgit > /dev/null; then
			echo "Error: Windows/MSYS Git is not supported on Cygwin"
			echo "Error: Make sure the Cygwin git package is installed and is first on the path"
			exit 1
		fi
	fi
	env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH || {
		printf "Error: git clone of oh-my-zsh repo failed\n"
		exit 1
	}
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export ZSH_CUSTOM_THEMES=$ZSH/custom/themes
export ZSH_THEMES=$ZSH/themes

check_zsh_theme "powerline" "https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme.git"

ZSH_THEME="agnoster"

# Completion settings
autoload -Uz compinit
compinit

# Advanced renaming cmd line tool
autoload -U zmv

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Check if ZSH plugins are missing
export ZSH_PLUGINS=$ZSH/custom/plugins

check_zsh_plugin "zshmarks" "https://github.com/jocelynmallon/zshmarks.git"
export ZSH_PLUGIN_SYNTAX_HIGHLIGHTING="$ZSH_PLUGINS/"
check_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"

source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git npm zshmarks zsh-completions zsh-autosuggestions tldr tmux)

# Load all instance dependent settings
if [[ -f .zshinstance ]]; then
    source .zshinstance
else
    echo "# Place any commands you want to execute on start here" > ~/.zshinstance
    chmod +x .zshinstance
fi

# Load all OS dependent settings
if [[ -f .zshosdep ]]; then
	source .zshosdep
fi

# Load all machine-specific aliases
if [[ -f .bash_aliases ]]; then
    source .bash_aliases
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# GIT
if [[ ! -d "$HOME/.git" ]]; then
    mkdir "$HOME/.git"
fi
GIT_AUTHOR_NAME="Martin Patz"
GIT_AUTHOR_EMAIL="mailto@martin-patz.de"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global credential.helper store
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global push.default simple
git config --global core.editor $(which vim) # Set a default editor to avoid "Could not execute editor" error

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="vim ~/.zshrc"
alias clc="clear"
alias ll="ls -la"

# Alias related to zshmarks
alias to="jump"
alias bm="bookmark"
alias bd="deletemark"
alias bl="showmarks"

if program_installed "feh"; then
	alias view="feh --scale-down --auto-zoom"
fi

if program_installed "xclip"; then
	alias pbcopy="xclip -selection c"
	alias pbpaste="xclip -selection clipboard -o"
fi

unsetopt auto_name_dirs

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
