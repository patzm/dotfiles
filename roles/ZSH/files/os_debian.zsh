# for https://github.com/pyenv/pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"

if ! command -v pyenv >/dev/null; then
    if [ -x "$PYENV_ROOT/bin/pyenv" ]; then
        export PATH="$PYENV_ROOT/bin:$PATH"
    fi
fi
if command -v pyenv >/dev/null; then
    eval "$(pyenv virtualenv-init -)"
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi

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
