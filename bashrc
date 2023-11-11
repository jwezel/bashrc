[ -n "$BASH_DEBUG" ] && echo Running $BASH_SOURCE
[ -f ~/.bash_debug ] && source ~/.bash_debug
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash/run.sh ] && {
  source ~/.bash/run.sh rc
  [[ $- =~ i ]] && {
    source ~/.bash/run.sh tty
  }
}
#---------------------------------------------------
