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
  set -x
  local opts args posarg
  eval opts=(
    $(
      getopt \
        --options hp: \
        --long system-site-packages,symlinks,copies,clear,upgrade,without-pip,prompt:,upgrade-deps,python: \
        -- \
        "$@"
    )
  )
  args=("${opts[@]}")
  posarg=''
  lopts=${#opts[*]}
  for ((i=0; i<$lopts; ++i)); do
    if [ -n "$posarg" ]; then
      opts[i]="${opts[i]}/.venv"
    else
      case "${opts[i]}" in

        '-p' | '--python')
        interp="${opts[i + 1]}"
        unset opts[i]
        unset "opts[i+1]"
        ;;

        '--')
        posarg=$((i + 1))
        ;;
      esac
    fi
  done
  echo $posarg
  echo "${opts[*]}"
  local dir="${args[posarg]}"
  local edir="$dir/.venv"
  mkdir -p "$dir"
  ${interp:-python3} -mvenv --upgrade-deps --prompt "$dir" "${opts[@]}" && cd "$dir" && e
  set +x
}

# Deactivate virtual environment
alias d="deactivate"
