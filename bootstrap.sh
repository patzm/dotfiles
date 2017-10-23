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

install_xdotool() {
    xdotool_dir=/tmp/xdotool
    git clone https://github.com/jordansissel/xdotool $xdotool_dir
    cd $xdotool_dir
    make
    sudo make install
    cd - # go to the previous folder
    rm -rf $xdotool_dir # clean up
}

install_nethogs() {
    nethogs_dir=/tmp/nethogs
    git clone https://github.com/raboof/nethogs $nethogs_dir
    cd $nethogs_dir
    make
    sudo make install
    cd - # go to the previous folder
    rm -rf $nethogs_dir # clean up
}

# create a bin directory for the current user
mkdir -p "$HOME/bin"

# install required software packages
echo "Install required programs?"
select yn in "Yes: Ubuntu" "No"; do
    case $yn in
        "Yes: Ubuntu" )
            sudo apt-get -qq update
            sudo apt-get -qq install -y \
                xclip \
                htop \
                lm-sensors \
                feh \
                python-pip \
                cmake \
                zsh \
                libxkbcommon-dev `# build-essential libncurses5-dev libpcap-dev` \
                build-essential libncurses5-dev libpcap-dev `# nethogs` \
                vim \
                git \
                wmctrl \
                tmux \
                imagemagick \
                tree
            break;;
        "No" ) break;;
    esac
done

# i3
if program_installed "i3"; then
    VIM_TARGET_DIR="$HOME/.i3"
    if [[ -d "$VIM_TARGET_DIR" && ! -L "$VIM_TARGET_DIR" ]]; then
        echo "removing existing vim folder $VIM_TARGET_DIR"
        rm -rf $VIM_TARGET_DIR
    fi
    ln -sf -T "$DIR/i3" $VIM_TARGET_DIR
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

    # install requirements for markdown rendering
    echo "Install required programs for vim markdown rendering?"
    select yn in "Yes: Ubuntu" "No"; do
        case $yn in
            "Yes: Ubuntu" )
                install_xdotool
                sudo pip install grip
                break;;
            "No" ) break;;
        esac
    done
fi

# zsh
if program_installed "zsh"; then
    ln -sf $DIR/ZSH/.zshrc "$HOME/.zshrc"
    echo "Link OS specific ZSH instructions?"
    select os in "Ubuntu" "MacOSX" "None"; do
        zshosdep="$HOME/.zshosdep"
        case $os in
            "Ubuntu")   ln -sf $DIR/ZSH/zshubuntu $zshosdep; break;;
            "MacOSX")   ln -sf $DIR/ZSH/zshmacosx $zshosdep; break;;
            "None")
                if [[ -e "$zshosdep" ]]; then
                    rm $zshosdep
                fi
                break;;
        esac
    done
    echo "Do you wish to set 'zsh' as the default shell?"
    select yn in "Yes" "No"; do
        case $yn in
            "Yes") chsh -s $(which zsh); break;;
            "No")  break;;
        esac
    done
fi

# tmux
if program_installed "tmux"; then
    ln -sf $DIR/tmux/.tmux.conf "$HOME/.tmux.conf"
fi

# nethogs
echo "Do you wish to install nethogs for network traffic monitoring?"
select yn in "Yes" "No"; do
    case $yn in
        "Yes") install_nethogs; break;;
        "No")   break;;
    esac
done

