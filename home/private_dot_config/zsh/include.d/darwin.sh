# macOS-specific configuration
[[ "$OSTYPE" != darwin* ]] && return 0

# Disable compfix checking for multi-user setup
ZSH_DISABLE_COMPFIX=true

# Add the correct Homebrew folder to the PATH
if [ "$(sysctl -in sysctl.proc_translated 2>/dev/null)" = "0" ]; then
    path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)
else
    path=("/usr/local/bin" "/usr/local/sbin" $path)
fi

# Add custom plugins
znap source ohmyzsh/ohmyzsh plugins/brew

alias brew-update='brew update && brew upgrade && brew upgrade --cask --greedy-auto-updates && brew cleanup'

# Launch commands
alias only-office='open -na "OnlyOffice"'
