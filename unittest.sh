#!/usr/bin/env bash

. setup.sh test

test_equality() {
  assertEquals 1 1
}

test_detect_ostype() {
  detect_ostype
  assertEquals $E_SUCC $?
}

test_install_plugin_manager() {
  install_plugin_manager
  assertEquals $E_SUCC $?
}

test_link_vimrc() {
  link_vimrc
  assertEquals $E_SUCC $?
}

. shunit2-2.1.6/src/shunit2
