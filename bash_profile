if [ -z "$BASH_PROFILE" ]; then
  export BASH_PROFILE=running
  [ -n "$BASH_DEBUG" ] && echo ">> ${BASH_SOURCE[0]}: Running"
  [ -z "$HOME" ] && {
    export HOME="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
    echo ">> ${BASH_SOURCE[0]}: HOME not set. Detected $HOME"
  }
  [ -f ~/.bash/run.sh ] && {
  	source ~/.bash/run.sh profile
  }
  export BASH_PROFILE=done
else
  [ -n "$BASH_DEBUG" ] && echo ">> ${BASH_SOURCE[0]}: Not re-running"
fi
#-------------------------------------------------
