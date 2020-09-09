#!/usr/bin/env bash

declare -r CONFIG=$PWD/config.vim   # absolute path to source config file
declare -r VIMRC=~/.vimrc           # absolute path to destination vimrc file

readonly E_SUCC=0       # exit with success

readonly E_XCURL=66     # cannot download contents from given url
readonly E_XOS=67       # cannot detect ostype
readonly E_XCP=68       # cannot perform cp command
readonly E_XINS=69      # cannot install plugins or their dependencies

PLATFORM=''

main() {
  # if no argument passed (i.e. install mode)
  if [ -z ${1+x} ]; then
    detect_ostype
    setup_vimrc_dependencies
    install_plugin_manager
    link_vimrc
    install_plugins
    install_plugin_dependencies
  fi;
}

detect_ostype() {
  case $OSTYPE in
    darwin*	) 
      PLATFORM='MAC';;
    linux*	) 
      PLATFORM='LNX'
      sudo apt install vim
      sudo apt install curl
      ;;
    *       ) echo "Un-Supported: $OSTYPE"; exit $E_XOS;;
  esac

  echo "Your OS is [${PLATFORM}]"
  return $E_SUCC
}

setup_vimrc_dependencies() {
  echo 'Setting-up any prerequisites...'

  # setup backup directories for file edit
  mkdir -p ~/.vim/swap ~/.vim/backup || {
    echo 'Cannot mkdir'
    exit $E_XINS
  }

  return $E_SUCC 
}

install_plugin_manager() {
  echo 'Installing vim-plug on your machine...'

  # install vim-plug, if not installed
  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs $url || {
      echo 'Installing the vim plugin manager is failed.' >&2
      exit $E_XCURL
    }
  fi

  return $E_SUCC
}

link_vimrc() {
  echo 'Installing the new .vimrc on your machine...'

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

  return $E_SUCC
}

copy_vimrc() {
  # set appropriate cp command depending on the ostype
  case $PLATFORM in
    'MAC'	  ) CP="ln -fs";;
    'LNX'	  ) CP="cp -bs";;
  esac

  # copy the vim file
  $CP $CONFIG $VIMRC || {
    echo "Cannot create symbolic link to $CONFIG" >&2
    exit $E_XCP;
  }
}

install_plugins() {
  echo 'Installing plugins specified in the vimrc...'

  vim +PlugInstall +qall || {
    echo 'Cannot install plugins' >&2
    exit $E_XINS
  }

  return $E_SUCC
}

install_plugin_dependencies() {
  echo 'Installing plugin dependencies...'

  # if current machine uses macOS, install dependencies with homebrew
  case $PLATFORM in
    'MAC'	  ) CMD="brew update ; brew install cmake";;
    'LNX'	  ) CMD="";;
  esac

  eval $CMD || {
    echo 'Cannot install plugin dependency'
    exit $E_XINS
  }

  return $E_SUCC
}

main "$@"

