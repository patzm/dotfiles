# Configure /edit various dotfiles
alias zshconfig='nvim ${HOME}/.zshrc'
alias zshosconfig='nvim ${HOME}/.zshosdep'
alias zshinstanceconfig='nvim ${HOME}/.zshinstance'

alias i3config='nvim ${HOME}/.config/i3/config'
alias polybarconfig='nvim ${HOME}/.config/polybar/config'

alias sshconfig='nvim ${HOME}/.ssh/config'

alias vimconfig='nvim ${HOME}/.vim/vimrc'
alias nvimconfig='nvim ${HOME}/.config/init.rc'

alias tmuxconfig='nvim ${HOME}/.tmux.conf'

# Alias related to zshmarks
alias to='jump'
alias bm='bookmark'
alias bd='deletemark'
alias bl='showmarks'

# Alias for conventional image renaming
alias img-rename="exiv2 -Fr '%Y-%m-%d_%H%M%S'"
alias mp4-rename="exiftool '-filename<CreateDate' -d %y-%m-%d_%H%M%S%%-c.%%le"

# Functions
mkcdir () {
    mkdir -p -- '$1' && cd -P -- '$1'
}

# video file conversion
function convert-video () {
	input=${1}
	input_dir=$(dirname ${input})
	input_file_name=$(basename ${input})
	output=${2:-${input_dir}/out_${input_file_name}}
	echo "Converting ${input} and storing it in ${output}"
	nice ffmpeg -i ${input} \
		-c:v libx264 -preset slow -crf 26 \
		-c:a aac \
		${output}
}

function convert-videos () {
    for i in ${@}; do
        convert-video $i
    done
}

# Common system / file system interaction
alias clc='clear'
alias l='ls -la'
alias dush='du -sm * | sort -h'
alias pa='ps aux | grep'
alias getp='readlink -f'
alias ducks='du -cks * | sort -rn | head'

# Pastebins
alias pbin='nc pbin.patz.app 9999'

# For the deep learning guys
alias nv='watch -n 0.1 nvidia-smi'
