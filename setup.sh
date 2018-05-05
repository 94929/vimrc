#!/usr/bin/env bash

declare -r CONFIG=$PWD/config.vim   # absolute path to source config file
declare -r VIMRC=$HOME/.vimrc       # absolute path to destination vimrc file

readonly E_SUCC=0       # exit with success

readonly E_XCURL=66     # cannot download from the url
readonly E_XOS=67       # cannot detect ostype
readonly E_XCP=68       # cannot perform cp
readonly E_XINS=69      # cannot install plugins

PLATFORM=''

main() {
  # if no argument passed (i.e. install mode)
  if [ -z ${1+x} ]; then
    detect_ostype
    install_plugin_manager
    link_vimrc
    install_plugins
  fi;
}

detect_ostype() {
  echo 'Detecting your ostype..'

  case $OSTYPE in
    darwin*	) PLATFORM='MAC';;
    linux*	) PLATFORM='LNX';;
    *	      ) echo "unknown: $OSTYPE"; exit $E_XOS;;
  esac

  echo "Your OS: ${PLATFORM}!!"
  sleep 2s
  return $E_SUCC
}

install_plugin_manager() {
  echo 'Attempting to install vim-plug on your machine..'

  # install vim-plug, if not installed
  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs $url || {
      echo 'Installing the vim plugin manager is failed.' >&2
      exit $E_XCURL
    }
    echo 'The vim plugin manager is installed!'
  else
    echo 'The vim plugin manager is already installed in your machine.'
  fi

  sleep 2s
  return $E_SUCC
}

link_vimrc() {
  echo 'Attempting to install new .vimrc on your machine..'

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

  sleep 2s
  return $E_SUCC
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

  echo 'The vimrc is now installed in your machine!!'
}

install_plugins() {
  echo 'Attempting to install plugins specified in the vimrc..'
  vim +PlugInstall +qall || {
    echo 'Cannot install plugins' >&2
    exit $E_XINS
  }

  echo 'Succesfully installed the plugins!!'
  sleep 2s
  return $E_SUCC
}

main "$@"

