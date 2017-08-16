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
    ln -sf $DIR/i3 ~/.i3
fi

# vim
if program_installed "vim"; then 
    ln -sf $DIR/vim/.vimrc ~/.vimrc
    vim_bundle_dir="~/.vim/bundle"
    if [! -d $vim_bundle_dir ]; then
        mkdir -p $vim_bundle_dir
    fi
    vim_vundle_dir="$vim_bundle_dir/vundle"
    if [! -d $vim_vundle_dir ]; then
       git clone git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim $vim_vundle_dir
    fi
    vim +PluginInstall +qall
fi

# zsh
if program_installed "zsh"; then
    ln -sf $DIR/ZSH/.zshrc ~/.zshrc
    echo "Changing the default log-in shell to zsh"
    chsh -s $(which zsh)
fi

# tmux
if program_installed "tmux"; then
    ln -sf $DIR/tmux/.tmux.conf ~/.tmux.conf
fi

