# Various configurations scripts

* vim
* zsh
* i3wm
* tmux
* ranger (to be added)

# Setup
Execute the platform- and version-specific instructions below **first**.
Then, execute the following:
```
mkdir -p ~/repos/configs
git clone https://github.com/patzm/configs.git ~/repos/configs
ansible-playbook ~/repos/configs/ansible/setup.yml -K [-i localhost] [--extra-vars "headless=yes"]
```
The switch `-K` requests root priviliges on the current machine.
Here, `localhost` is an inventory file just specifying the current PC as the only host.
This is the default behavior.
Other inventory files can easily be used.
Attention: all hosts specified in the inventory file are used.
If the setup routine shall be run on a headless machine, add `-e headless=yes` to the command.
Then, programs like `i3` will not be installed.

## Ubuntu 16.04 or later
On modern distributions, installation is quite straight forward:
```
sudo apt-get update
sudo apt-get install \
    git \
    ansible
```

## Ubuntu 14.04 or earlier
Ansible ships with Ubuntu 12.04 or 14.04 in version `1.x`.
However we need version `2.x` or higher.
```
sudo apt-get update
sudo apt-get install \
    software-properties-common \
    ca-certificates \
    git
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible
```

