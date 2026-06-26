#! /usr/bin/env bash

status_json="$(bw status)"
server_url="$(printf '%s\n' "$status_json" | awk -F'"' '$2=="serverUrl"{print $4; exit}')"

if [ -z "$server_url" ]; then
  bw config server vault.patz.app
fi

# vim: set filetype=zsh :
