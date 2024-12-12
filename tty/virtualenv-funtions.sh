#!/bin/bash

# Activate Python virtual environment
#
# Prerequisites:
#   Python virtual environment in either . or ./.venv
e() {
  for f in ./bin/activate .venv/bin/activate; do
    if [ -e "$f" ]; then
      . "$f"
      break
    fi
  done
}

# Create and activate new Python virtual environment
#
# Args:
#   directory-path
nv () {
  local opts args posarg
  eval opts=($(getopt --options h --long system-site-packages,symlinks,copies,clear,upgrade,without-pip,prompt:,upgrade-deps -- "$@"))
  args=("${opts[@]}")
  posarg=''
  for ((i=0; i<${#opts[*]}; ++i)); do
    if [ -n "$posarg" ]; then
      opts[i]="${opts[i]}/.venv"
    elif [ "${opts[i]}" = '--' ]; then
      posarg=$((i + 1))
    fi
  done
  local dir="${args[posarg]}"
  local edir="$dir/.venv"
  mkdir -p "$dir"
  python -mvenv --upgrade-deps --prompt "$dir" "${opts[@]}" && cd "$dir" && e
}

# Deactivate virtual environment
alias d="deactivate"
