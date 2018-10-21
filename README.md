# Various configurations scripts

* vim
* zsh
* i3wm (i3-gaps)
* polybar
* autorandr
* python (virtualenv)
* tmux
* htop
* ranger (to be added)

# Setup
Execute the platform- and version-specific instructions below **first**.
Then, execute the following:
```
mkdir -p ~/repos/configs
git clone https://github.com/patzm/configs.git ~/repos/configs
ansible-playbook ~/repos/configs/setup.yml -K [-i <inventory_file>] [--tags ui,dotfiles-root]
# only copy the dotfiles
ansible-playbook ~/repos/configs/setup.yml [-i <inventory_file>] --tags dotfiles
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
```
sudo apt-get update
sudo apt-get install git ansible
```

## Ubuntu 14.04 or earlier
Ansible ships with Ubuntu 12.04 or 14.04 in version `1.x`.
However we need version `2.x` or higher.
```
sudo apt-get update
sudo apt-get install software-properties-common ca-certificates git
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible
```
