#! /usr/bin/env bash
set -euo pipefail

OPT_DIR="$1"

download_and_extract() {
  local url=$1
  local destination="$OPT_DIR/$2"
  local binary_path=$3
  local link_name=${4:-$(basename "$binary_path")}

  sudo mkdir -p "$destination"
  wget -qO- "$url" | gunzip | sudo tar xvf - --overwrite -C "$destination"

  mkdir -p "$HOME/.local/bin"
  ln -sfn "$destination/$binary_path" "$HOME/.local/bin/$link_name"
}

download_and_extract \
  "https://github.com/eza-community/eza/releases/download/v0.23.4/eza_x86_64-unknown-linux-gnu.tar.gz" \
  "eza/bin" \
  "eza"

download_and_extract \
  "https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz" \
  "fzf/bin" \
  "fzf"

download_and_extract \
  "https://github.com/starship/starship/releases/download/v1.24.2/starship-x86_64-unknown-linux-gnu.tar.gz" \
  "starship/bin" \
  "starship"

download_and_extract \
  "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" \
  "nvim" \
  "nvim-linux-x86_64/bin/nvim" \
  "nvim"

DIRENV_BIN_PATH="$OPT_DIR/direnv/bin"
sudo mkdir -p $DIRENV_BIN_PATH
curl -sfL https://direnv.net/install.sh | sudo bin_path=$DIRENV_BIN_PATH bash
ln -sfn "${DIRENV_BIN_PATH}/direnv" ${HOME}/.local/bin/direnv
