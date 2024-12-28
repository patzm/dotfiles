# Disable compfix checking for multi-user setup
ZSH_DISABLE_COMPFIX=true

# Add the correct HomeBrew folder to the PATH
if [ "$(sysctl -in sysctl.proc_translated)" = "0" ]; then
    local brew_path="/opt/homebrew/bin:/opt/homebrew/sbin"
else
    local brew_path="/usr/local/bin:/usr/local/sbin"
fi
export PATH="${brew_path}:${PATH}"

# Add all local HomeBrew install folders of Python to the PATH
for python_dir in $(brew --prefix)/opt/python@*; do
	export PATH="${python_dir}/bin:${PATH}"
done

# for https://github.com/pyenv/pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init -)"
pyenv virtualenvwrapper

# Add custom plugins
plugins+=(brew)

# from https://github.com/pyenv/pyenv#homebrew-in-macos
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brew-update='brew update && brew upgrade && brew cleanup'

# vim: set filetype=zsh : 
