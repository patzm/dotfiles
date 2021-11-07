# configure the keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

[[ -f ~/.profile ]] && . ~/.profile
[[ -f ~/.xprofile ]] && . ~/.xprofile
[[ -f ~/.bashrc ]] && . ~/.bashrc
