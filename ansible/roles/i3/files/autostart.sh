#!/bin/bash

program_exists() {
    if hash $1 2>/dev/null; then
        return 0 # true
    else
        return 1 # false
    fi
}

if program_exists "dropbox"; then
    dropbox start
fi

if program_exists "setxkbmap"; then
    gsettings set org.gnome.settings-daemon.plugins.keyboard active false
    # See: https://unix.stackexchange.com/questions/333368/gnome-3-22-disable-altshift-keyboard-layout-switching
    dconf write /org/gnome/desktop/input-sources/xkb-options "['grp_led:scroll']"
    setxkbmap -layout us,de
    setxkbmap -option 'grp:win_space_toggle'
fi

# Fixes audio playback issue for Firefox 59 and lower, see https://support.mozilla.org/en-US/kb/no-sound-firefox-59-linux
pulseaudio --start --exit-idle-time=-1
