#!/bin/bash

install_plugin_manager() {
	# install vim-plug if not installed
	if [ ! -f ~/.vim/autoload/plug.vim ]; then
		uri=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs $uri
		echo "the vim plugin manager is installed!"
	fi
}

copy_vimrc() {
	# set config.vim path
	if [ ! $1 ]; then cpath=$PWD; else cpath=$1; fi

	# if no pre-installed .vimrc, then
	if [ ! -f ~/.vimrc ]
	then
		# simply copy config.vim as .vimrc for current system
		cp -s $cpath/config.vim ~/.vimrc
	# else, if there is a pre-installed .vimrc
	else
		# check if it's identical, if not, install one
		cmp -s $cpath/config.vim ~/.vimrc || cp -bs $cpath/config.vim ~/.vimrc 
	fi
	echo "the vim configuration file is now set!"
}

main() {
	install_plugin_manager
	copy_vimrc
	exit 0
}

main

