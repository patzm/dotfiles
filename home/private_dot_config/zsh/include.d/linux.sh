# Linux-specific configuration
[[ "$OSTYPE" != linux* ]] && return 0

export CLI_CLIP_COPY=wl-copy
export CLI_CLIP_PASTE=wl-paste

alias open='xdg-open'
