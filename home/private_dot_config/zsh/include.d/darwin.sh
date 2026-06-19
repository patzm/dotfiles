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

# Clipboard helpers
export CLI_CLIP_COPY=pbcopy
export CLI_CLIP_PASTE=pbpaste

# Add custom plugins
znap source ohmyzsh/ohmyzsh plugins/brew

function brew-update () {
    set -x
    brew update
    brew upgrade
    brew upgrade --cask --greedy-auto-updates
    brew cleanup

    # Fix permissions for a few apps
    xattr -cr /Applications/SourceGit.app
    set +x
}

# Launch commands
alias only-office='open -na "OnlyOffice"'
