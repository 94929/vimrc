#!/usr/bin/env bash

CONFIG=$PWD/config.vim	# absolute path to source config file
VIMRC=~/.vimrc			# path to destination vimrc file

E_XCURL=66				# cannot download from the url
E_XOS=67				# cannot detect ostype
E_XCP=68				# cannot perform cp

platform='unknown'	

install_plugin_manager() {
	# install vim-plug if not installed
	if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
		url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs $url || {
			echo 'The vim plugin manager was not installed.' >&2
			exit $E_XCURL
		}
		echo 'The vim plugin manager is installed!'
	fi
}

detect_ostype() {
	case "$OSTYPE" in
		darwin*	) platform='mac';;
		linux*	) platform='linux';;
		*		) echo "unknown: $OSTYPE"; exit $E_XOS;;
	esac
}

copy_vimrc() {

	# if no pre-installed .vimrc, then
	if [[ ! -f $VIMRC ]]; then

		# simply copy config.vim as .vimrc for current system
		cp -s $CONFIG $VIMRC || {
			echo 'Cannot perform cp.' >&2
			exit $E_XCP;
		}
	# else, if there is a pre-installed .vimrc
	else
		# check if it's identical, if not, install one
		if ( cmp --silent $CONFIG $VIMRC ); then
			echo 'The most recent .vimrc is already installed in your machine.'
		else
			cp -bs $CONFIG $VIMRC || {
				echo 'Cannot perform cp.' >&2
				exit $E_XCP;
			}
			echo 'The .vimrc is now installed in your machine!'
		fi
	fi
}

main() {
	install_plugin_manager
	detect_ostype
	copy_vimrc
}

main

