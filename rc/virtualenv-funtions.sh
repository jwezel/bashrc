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
  local dir="${args[-1]}"
  local edir="${args[-1]}/.venv"
  mkdir -p "$dir"
  python -mvenv "${args[*]}" --upgrade-deps --prompt="$dir" && cd "$dir" && e
}
