[ -z "$BASH_PROFILE" ] && {
  export BASH_PROFILE=running
  [ -z "$HOME" ] && {
    export HOME="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
    echo HOME not set in ${BASH_SOURCE[0]}. Detected $HOME
  }
  [ -f ~/.bash/run.sh ] && {
  	source ~/.bash/run.sh profile
  }
  export BASH_PROFILE=done
}
#-------------------------------------------------
