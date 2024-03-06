# Configure /edit various dotfiles
alias i3config='nvim ${XDG_CONFIG_HOME}/i3/config'
alias nvimconfig='nvim ${XDG_CONFIG_HOME}/init.rc'
alias polybarconfig='nvim ${XDG_CONFIG_HOME}/polybar/config'
alias sshconfig='nvim ${HOME}/.ssh/config'
alias tmuxconfig='nvim ${HOME}/.tmux.conf'
alias vimconfig='nvim ${HOME}/.vim/vimrc'
alias zshconfig='nvim ${XDG_CONFIG_HOME}/zsh/.zshrc'
alias zshinstanceconfig='nvim ${XDG_CONFIG_HOME}/zsh/zshinstance'
alias zshosconfig='nvim ${XDG_CONFIG_HOME}/zsh/zshosdep'

# Alias related to zshmarks
alias to='jump'
alias bm='bookmark'
alias bd='deletemark'
alias bl='showmarks'

# Alias related to virtualenvwrapper
alias lsvenv="lsvirtualenv -b"
alias mkvenv="mkvirtualenv"
alias rmvenv="rmvirtualenv"

# Alias for conventional image and movie renaming
alias img-rename="exiv2 -Fr '%Y-%m-%d_%H%M%S'"
function img-shift-tz () {
	: 'img-shift-tz: Shift images timestamps by a specific offset.

	img-shift-tz -=2:30 *.jpg
		shifts by 2h30min back
	'
	tz_shift=${1}
	for file in "${@:2}"; do
		exiftool "-AllDates${tz_shift}" "${file}"
	done
}

function img-meta-update() {
	: 'img-meta-update: updates the metadata of an image base on the file name.
	
	matches for instance
	- "20-03-23 15-02-59 4123.jpg"
	- "22-07-24 14-20-42.jpg"
	'
	exiftool -d "\"%y-%m-%d %H-%M-%S\"" '-DateTimeOriginal<${Filename;s/(\s([0-9])+)?\.[^.]*$//}' "$@"
}

function img-show-date() {
	: 'img-show-date: shows the dates that are stored in the file name.'
	exiftool -T -FileName -DateTimeOriginal "$@"
}

rename_to_jpg() {
  for file in "$@"; do
    if [[ "$file" == *.jpeg || "$file" == *.JPEG ]]; then
      mv "$file" "${file%.*}.jpg"
    elif [[ "$file" == *.JPG ]]; then
      # Handling case-sensitive filesystems by using an intermediate rename
      mv "$file" "${file%.*}.jpg.tmp"
      mv "${file%.*}.jpg.tmp" "${file%.*}.jpg"
    else
      echo "Skipping file $file, extension not matching."
    fi
  done
}

alias mov-rename="exiftool -ExtractEmbedded '-FileName<CreateDate' -api QuickTimeUTC -d %Y-%m-%d_%H%M%S%%-c.%%le"
alias mov-meta-update="exiftool '-*date<\${filename}' -wm w"
function mov-shift-tz () {
	# mov-shift-tz -=2 *.mov
	tz_shift=${1}
	for file in "${@:2}"; do
		echo "Shifting timezone of ${file} by ${tz_shift}."
		exiftool '-*date'${tz_shift} "${file}"
	done
}

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
alias ks="k -h --group-directories-first"

# Pastebins
alias pbin='nc pbin.patz.app 9999'

# For the deep learning guys
alias nv='watch -n 0.1 nvidia-smi'
function tb () {
    model_dir="gs://${1}"
    echo "Launching TensorBoard for ${model_dir}"
    tensorboard serve --bind_all --logdir ${model_dir} | grep "Press CTRL+C"
}

# For docker 🐳
alias docker-ps="docker ps -a --format '{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}' | column -t -s $'\t'"
