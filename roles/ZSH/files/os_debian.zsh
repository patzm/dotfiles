# for https://github.com/pyenv/pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv virtualenv-init -)"

# Add custom plugins
plugins+=(debian)

# If snap is installed
if [ -d "/snap/bin" ]; then
    export PATH="/snap/bin:${PATH}"
fi

# View images from the command line
alias view="feh --scale-down --auto-zoom"
# terminal clipboard manager
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
o () {
    gnome-open "$1" 2> /dev/null &
}

# vim: set filetype=zsh : 
