#!/bin/bash

argind() {
  local args=(`getopt "$@"`)
  for ((i=0; i<${#args[@]}; ++i)); do
    if [[ "${args[$i]}" = '--' ]]; then
      echo $i
      break
    fi
  done
}
