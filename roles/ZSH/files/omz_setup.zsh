#! /usr/bin/env zsh

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

check_zsh_theme "powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"

check_zsh_plugin "k" "https://github.com/supercrabtree/k"
check_zsh_plugin "zshmarks" "https://github.com/jocelynmallon/zshmarks.git"
check_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
check_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
check_zsh_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions"

unset -f check_zsh_plugin
unset -f check_zsh_theme
