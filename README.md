# Various configurations scripts

* vim
* zsh
* i3wm
* tmux
* ranger (to be added)

# Setup

## Ubuntu 16.04 or later

## Ubuntu 14.04 or earlier
Ansible ships with Ubuntu 12.04 or 14.04 in version `1.x`.
However we need version `2.x` or higher.
```
sudo apt-get update
sudo apt-get install \
    software-properties-common \
    ca-certificates \
    git
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

