#!/bin/bash

echo "This setup script sets up your system with Ansible"

pushd `dirname $0` > /dev/null                              
DIR=`pwd`                                                      
popd > /dev/null

_dir_bash_functions="$DIR/bash_functions" 
if [ -d $_dir_bash_functions ]; then 
	for file in $_dir_bash_functions/*.sh; do 
		source "$file" 
	done 
fi 
unset _dir_bash_functions

if ! program_installed "ansible"; then
	echo "Ansible is not yet installed, installing..."
	sudo apt-get -qq update
	sudo apt-get -qq install -y software-properties-common
	sudo apt-add-repository -y -u ppa:ansible/ansible
	sudo apt-get -qq install -y ansible
fi

echo "Setting up local machine"
ansible-playbook $DIR/playbooks/setup.yml

