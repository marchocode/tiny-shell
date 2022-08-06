#!/bin/bash

SHELL="bash"

function test {
  
  local SHELL="sh"
  echo $SHELL
}

echo $SHELL
test

echo $SHELL

echo 