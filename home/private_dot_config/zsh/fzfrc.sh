# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export FZF_DEFAULT_OPTS_FILE="${ZDOTDIR}/fzfdefaultopts.sh"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute(echo -n {2..} | ${CLI_CLIP_COPY})'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  --preview=''"
