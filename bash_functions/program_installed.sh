#!/bin/bash
program_installed() {
	if hash "$1" 2>/dev/null; then
		return 0 # true
	else
		echo "$1 does not seem to be installed"
		return 1 # false
	fi
}
