#!/usr/bin/env bash

declare -r CONFIG=$PWD/config.vim   # absolute path to source config file
declare -r VIMRC=$HOME/.vimrc       # absolute path to destination vimrc file

readonly E_XCURL=66     # cannot download from the url
readonly E_XOS=67       # cannot detect ostype
readonly E_XCP=68       # cannot perform cp
readonly E_XINS=69      # cannot install plugins

PLATFORM=''

detect_ostype() {
  case $OSTYPE in
    darwin*	) PLATFORM='MAC';;
    linux*	) PLATFORM='LNX';;
    *	      ) echo "unknown: $OSTYPE"; exit $E_XOS;;
  esac
}

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

link_vimrc() {
  # if no pre-installed .vimrc, then
  if [[ ! -f $VIMRC ]]; then
    # simply copy config.vim as .vimrc for current system
    copy_vimrc
  # else, if there is a pre-installed .vimrc
  else
    # check if they're identical, if not, install one
    if ( cmp --silent $CONFIG $VIMRC ); then
      echo 'The most recent .vimrc is already installed in your machine.'
    else
      copy_vimrc
    fi
  fi
}

copy_vimrc() {
  # set appropriate cp command depending on the ostype
  case $PLATFORM in
    'MAC'	  ) cp="ln -fs";;
    'LNX'	  ) cp="cp -bs";;
  esac

  # copy the vim file
  $cp $CONFIG $VIMRC || {
    echo "Cannot create symbolic link to $CONFIG" >&2
    exit $E_XCP;
  }
  echo 'The .vimrc is now installed in your machine!'
}

install_plugins() {
  vim +PlugInstall +qall || {
    echo 'Cannot install plugins' >&2
    exit $E_XINS
  }
}

install_plugin_dependencies() {
  # install powerline fonts for 'powerline'
  sudo apt-get install fonts-powerline || {
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
  }
}

main() {
  detect_ostype
  install_plugin_manager
  link_vimrc
  install_plugins
  install_plugin_dependencies
}

main

