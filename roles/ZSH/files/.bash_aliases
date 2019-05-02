# Configure /edit various dotfiles
alias zshconfig='vim ${HOME}/.zshrc'
alias zshosconfig='vim ${HOME}/.zshosdep'
alias zshinstanceconfig='vim ${HOME}/.zshinstance'

alias i3config='vim ${HOME}/.config/i3/config'
alias polybarconfig='vim ${HOME}/.config/polybar/config'

alias sshconfig='vim ${HOME}/.ssh/config'

alias vimconfig='vim ${HOME}/.vim/vimrc'
alias nvimconfig='vim ${HOME}/.config/init.rc'

alias tmuxconfig='vim ${HOME}/.tmux.conf'

# Alias related to zshmarks
alias to='jump'
alias bm='bookmark'
alias bd='deletemark'
alias bl='showmarks'

# Alias for conventional image renaming
alias img-rename='exiv2 -Fr '%Y-%m-%d_%H%M%S''

# Common system / file system interaction
alias clc='clear'
alias ll='ls -la'
alias dush='du -sm * | sort -h'
alias pa='ps aux | grep'
alias getp='readlink -f'

# For the deep learning guys
alias nv='watch -n 0.1 nvidia-smi'

# Use neovim
alias _vim='/usr/bin/vim'
alias vim='nvim'

# Functions
mkcdir () {
    mkdir -p -- '$1' && cd -P -- '$1'
}

