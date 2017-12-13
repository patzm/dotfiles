#!/bin/bash

pushd `dirname $0` > /dev/null
DIR=`pwd`
popd > /dev/null

s_y_ubuntu="Yes:Ubuntu"
s_y_macosx="Yes:MasOSX"
s_n="No"

# make sure the user config directory exists
user_config_dir="${HOME}/.config"
if [[ ! -d $user_config_dir ]]; then
    echo "Creating user config directory $user_config_dir"
    mkdir $user_config_dir
fi

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
select yn in $s_y_ubuntu $s_n; do
    case $yn in
        $s_y_ubuntu)
            echo "Updating dpgk repositories"
            sudo apt-get -qq update
            echo "Installing required programs and libraries"
            sudo apt-get -qq install -y \
                xclip \
                htop \
                lm-sensors \
                feh \
                python-pip \
                cmake \
                zsh \
                libxkbcommon-dev \
                build-essential libncurses5-dev libpcap-dev `# nethogs` \
                vim \
                git \
                checkinstall libssl-dev `# nvm for nodejs` \
                wmctrl \
                python-software-properties software-properties-common \
                imagemagick \
                tree

            # tmux 2.0
            sudo add-apt-repository -y ppa:pi-rho/dev
            sudo apt-get update
            sudo apt-get install -y tmux=2.0-1~ppa1~t

            echo "Installing NVM"
            export NVM_DIR="$HOME/.nvm" && (
              git clone https://github.com/creationix/nvm.git "$NVM_DIR"
              cd "$NVM_DIR"
              git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
            ) && . "$NVM_DIR/nvm.sh"
            reset
            nvm install node
            nvm use node
            echo "Installing TLDR"
            npm install -g tldr
            break;;
        $s_n) break;;
    esac
done

# install Latex
echo "Install Latex?"
select yn in $s_y_ubuntu $s_n; do
    case $yn in
        $s_y_ubuntu)
            sudo apt-get -qq install -y \
                texlive-base \
                texlive-fonts-extra \
                texlive-lang-german \
                texlive-lang-english \
                texlive-latex-base \
                texlive-latex-extra \
                texlive-math-extra \
                texlive-science \
                texlive-xetex \
                biber \
                latexmk
            break;;
        $s_n) break;;
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
    select yn in $s_y_ubuntu $s_n; do
        case $yn in
            $s_y_ubuntu)
                install_xdotool
                sudo pip install grip
                break;;
            $s_n) break;;
        esac
    done
fi

# zsh
if program_installed "zsh"; then
    ln -sf $DIR/ZSH/.zshrc "$HOME/.zshrc"
    mkdir -p $DIR/plugins/tldr
    ln -sf $DIR/ZSH/tldr/autocompletion.zsh $DIR/plugins/tldr/_tldr
    echo "Link OS specific ZSH instructions?"
    select os in $s_y_ubuntu $s_y_macosx $s_n; do
        zshosdep="$HOME/.zshosdep"
        case $os in
            $s_y_ubuntu)
                ln -sf $DIR/ZSH/zshubuntu $zshosdep; break;;
            $s_y_macosx)
                ln -sf $DIR/ZSH/zshmacosx $zshosdep; break;;
            $s_n)
                if [[ -e "$zshosdep" ]]; then
                    rm $zshosdep
                fi
                break;;
        esac
    done
    echo "Do you wish to set 'zsh' as the default shell?"
    select yn in "Yes" $s_n; do
        case $yn in
            "Yes") chsh -s $(which zsh); break;;
            $s_n)  break;;
        esac
    done
fi

# gdb
if program_installed "gdb"; then
    ln -sf $DIR/gdb/.gdbinit "$HOME/.gdbinit"
fi

# powerline
powerline_config_dir=$user_config_dir/powerline
if [[ -d $powerline_config_dir ]]; then
    echo "Backing up old configuration of powerline"
    mv $powerline_config_dir "${powerline_config_dir}.bak"
fi
ln -sf $DIR/powerline $powerline_config_dir

# tmux
if program_installed "tmux"; then
    ln -sf $DIR/tmux/.tmux.conf "$HOME/.tmux.conf"
fi

# nethogs

# TODO: check, if nethogs is already installed
echo "Do you wish to install nethogs for network traffic monitoring?"
select yn in "Yes" $s_n; do
    case $yn in
        "Yes") install_nethogs; break;;
        $s_n)   break;;
    esac
done
