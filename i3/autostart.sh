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
    setxkbmap -layout us,de
    setxkbmap -option 'grp:alt_shift_toggle'
fi

