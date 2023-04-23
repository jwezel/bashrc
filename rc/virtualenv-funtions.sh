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
  local args=("$@")
  dir="${args[-1]}"
  args[-1]="${args[-1]}/.venv"
  mkdir -p "${args[-1]}"
  python -mvenv "${args[*]}" --prompt="$dir" && cd "${args[-1]}" && e
  cd ..
}

