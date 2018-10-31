# Configure /edit various dotfiles
alias zshconfig="vim ~/.zshrc"
alias i3config="vim ~/.config/i3/config"
alias polybarconfig="vim ~/.config/polybar/config"
alias sshconfig="vim ~/.ssh/config"

# Alias related to zshmarks
alias to="jump"
alias bm="bookmark"
alias bd="deletemark"
alias bl="showmarks"

# Alias for conventional image renaming
alias img_rename="exiv2 -Fr '%Y-%m-%d_%H%M%S'"

# Common system / file system interaction
alias clc="clear"
alias ll="ls -la"
alias dush="du -sm * | sort -h"
alias pa="ps aux | grep"
alias getp='readlink -f'

# For the deep learning guys
alias nv='watch -n 0.1 nvidia-smi'

# Functions
mkcdir () {
    mkdir -p -- "$1" && cd -P -- "$1"
}
