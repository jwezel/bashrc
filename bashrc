[ -z "$BASHRC" ] && {
  [ -z "$HOME" ] && {
      export HOME="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
      echo HOME not set in ${BASH_SOURCE[0]}. Detected $HOME
  }
  [ -n "$BASH_DEBUG" ] && echo Running ${BASH_SOURCE[0]}
  [ -f ~/.bash_debug ] && source ~/.bash_debug
  [ -f ~/.bash_functions ] && source ~/.bash_functions
  [ -f ~/.bash_aliases ] && source ~/.bash_aliases
  [ -f ~/.bash/run.sh ] && {
    [ -n "$BASH_DEBUG" ] && echo Running rc
    source ~/.bash/run.sh rc
    [[ $- =~ i && $BASHOPTS != *login_shell* ]] && {
      [ -n "$BASH_DEBUG" ] && echo Running tty
      source ~/.bash/run.sh tty
    }
  }
}
export BASHRC=done
#---------------------------------------------------
