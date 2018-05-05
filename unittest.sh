#!/usr/bin/env bash

. setup.sh test

test_equality() {
  assertEquals 1 1
}

test_detect_ostype() {
  detect_ostype
  ret_val=$?
  echo $ret_val
  assertEquals 0 $ret_val
}

#. shunit2-2.1.6/src/shunit2
. /Users/jsha/Projects/shunit2/shunit2
