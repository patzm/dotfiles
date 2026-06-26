#! /usr/bin/env bash

set -e

if ! command -v xdg-mime >/dev/null 2>&1; then
    echo "xdg-mime is not installed or not in PATH. Skipping MIME configuration."
    exit 0
fi

printf "\nSetting default MIME handlers\n"
xdg-mime default org.gnome.Evince.desktop application/pdf

# vim: set filetype=zsh :
