#!/bin/bash

setup_ubuntu () {
	if ! program_installed "ansible"; then
		echo "Ansible is not installed, installing ..."
		sudo apt-get -qq update
		sudo apt-get -qq install -y software-properties-common
		sudo apt-add-repository -y -u ppa:ansible/ansible
		sudo apt-get -qq install -y ansible
	fi
	echo "now run 'ansible-playbook $DIR/setup.yml -K'"
}

setup_macosx () {
	if ! program_installed "brew"; then
		echo "Homebrew is not installed, installing ..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	if ! program_installed "ansible"; then
		echo "Ansible is not installed, installing ..."
		brew install ansible
	fi
	echo "now run 'ansible-playbook $DIR/setup.yml'"
}

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

# detect OS
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

echo "Detected ${OS}-${VER}"

case "$OS" in
	Ubuntu*)	setup_ubuntu;;
	Darwin*)	setup_macosx;;
	*)			echo "OS is not supported"
				exit 1;;
esac

