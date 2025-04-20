#!/bin/bash
#
# Install .bashrc and .bash_profile

(
	[ -z "$HOME" ] && {
		echo HOME is not set
		exit 1
	}
	DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
	cp -sbv "$DIR/bashinit" ~/.bashrc
	cp -sbv "$DIR/bashinit" ~/.bash_profile
)
