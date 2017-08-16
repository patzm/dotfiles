#!/bin/bash

pushd `dirname $0` > /dev/null
DIR=`pwd`
popd > /dev/null

echo "Location of the configs repository: $DIR"

program_installed() {
    if hash "$1" 2>/dev/null; then
        return 0 # true
    else
        echo "$1 does not seem to be installed"
        return 1 # false
    fi
}

# i3
if program_installed "i3"; then
    ln -sf $DIR/i3 "$HOME/.i3"
fi

# vim
if program_installed "vim"; then 
    ln -sf $DIR/vim/.vimrc "$HOME/.vimrc"
    vim_bundle_dir="$HOME/.vim/bundle"
    if [[ ! -d $vim_bundle_dir ]]; then
        echo "Creating vim bundle directory $vim_bundle_dir"
        mkdir -p $vim_bundle_dir
    fi
    vim_vundle_dir="$vim_bundle_dir/vundle"
    if [[ ! -d $vim_vundle_dir ]]; then
       git clone https://github.com/VundleVim/Vundle.vim.git $vim_vundle_dir
    fi
    vim +PluginInstall +qall
fi

# zsh
if program_installed "zsh"; then
    ln -sf $DIR/ZSH/.zshrc "$HOME/.zshrc"
    echo "Do you wish to set 'zsh' as the default shell?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) chsh -s $(which zsh); break;;
            No ) break;;
        esac
    done
fi

# tmux
if program_installed "tmux"; then
    ln -sf $DIR/tmux/.tmux.conf "$HOME/.tmux.conf"
fi

