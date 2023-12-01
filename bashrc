[ -z "$HOME" ] && {
    export HOME="$(dirname $(readlink -f $BASH_SOURCE))"
    echo HOME not set in $BASH_SOURCE. Detected $HOME
}
[ -n "$BASH_DEBUG" ] && echo Running $BASH_SOURCE
[ -f ~/.bash_debug ] && source ~/.bash_debug
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f $(dirname $(readlink -f $BASH_SOURCE))/.bash/run.sh ] && {
  source $(dirname $(readlink -f $BASH_SOURCE))/.bash/run.sh rc
  [[ $- =~ i ]] && {
    source $(dirname $(readlink -f $BASH_SOURCE))/.bash/run.sh tty
  }
}
#---------------------------------------------------
