# Various configurations scripts

* autorandr
* git
* htop
* i3wm (i3-gaps)
* polybar
* python (virtualenv)
* tmux
* vim
* zsh

# Setup
Execute the platform- and version-specific instructions below **first**.
Then, execute the following:
```bash
mkdir -p ~/repos/dotfiles
git clone https://github.com/patzm/dotfiles.git ~/repos/dotfiles
ansible-playbook ~/repos/dotfiles/setup.yml -K [-i <inventory_file>] [--tags i3,dotfiles-root]
# only copy the dotfiles
ansible-playbook ~/repos/dotfiles/setup.yml [-i <inventory_file>] --tags dotfiles
```
The switch `-K` requests root priviliges on the current machine.
This is not required if running the tag `dotfiles` only.
The `localhost` is the default installation target.

Other inventory files can easily be used.
Attention: all hosts specified in the inventory file are used.
Use `--extra-vars custom_hosts=GROUP` to select a group specified in `<inventory_file>`.
If no inventory file is available or you want to run this playbook for a temporary target, pass `-i '<host_1>,[host_2]'`.
Note, that the `,` after the first host is important.

## Ubuntu 16.04 or later
On modern distributions, installation is quite straight forward:
```bash
sudo apt-get update
sudo apt-get install git ansible
```

## Ubuntu 14.04 or earlier
Ansible ships with Ubuntu 12.04 or 14.04 in version `1.x`.
However we need version `2.x` or higher.
```bash
sudo apt-get update
sudo apt-get install software-properties-common ca-certificates git
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible
```

# Configuration

## `i3`

### Wallpaper
There are various ways to set the wallpaper.
The recommended way is to use `nitrogen` to set the wallpaper.
This will also persist across sessions.

An alternative is to use `hsetroot`.
