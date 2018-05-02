#!/usr/bin/env bash

declare -r CONFIG=$PWD/config.vim	# absolute path to source config file
declare -r VIMRC=$HOME/.vimrc	    # absolute path to destination vimrc file

readonly E_XCURL=66			# cannot download from the url
readonly E_XOS=67				# cannot detect ostype
readonly E_XCP=68				# cannot perform cp

platform='unknown'	

install_plugin_manager() {
  # install vim-plug, if not installed
	if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
		url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs $url || {
			echo 'Installing the vim plugin manager is failed.' >&2
			exit $E_XCURL
		}
		echo 'The vim plugin manager is installed!'
	fi
}

detect_ostype() {
	case $OSTYPE in
		darwin*	) platform='mac';;
		linux*	) platform='linux';;
		*		) echo "unknown: $OSTYPE"; exit $E_XOS;;
	esac
}

link_vimrc() {

	# if no pre-installed .vimrc, then
	if [[ ! -f $VIMRC ]]; then
		# simply copy config.vim as .vimrc for current system
        copy_vimrc_linux
	
    # else, if there is a pre-installed .vimrc
	else
		# check if they're identical, if not, install one
		if ( cmp --silent $CONFIG $VIMRC ); then
			echo 'The most recent .vimrc is already installed in your machine.'
		else
            copy_vimrc_linux
		fi
	fi
}

copy_vimrc_linux() {
    cp -bs $CONFIG $VIMRC || {
        echo "Cannot create symbolic link to $CONFIG" >&2
        exit $E_XCP;
    }
    echo 'The .vimrc is now installed in your machine!'
}

copy_vimrc_mac() {
    ln -s $CONFIG $VIMRC || {
        echo "Cannot create symbolic link to $CONFIG" >&2
        exit $E_XCP;
    }
}

main() {
    install_plugin_manager
    detect_ostype
    link_vimrc
}

main

