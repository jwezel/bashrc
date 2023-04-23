[ -n "$BASH_DEBUG" ] && echo Running $0
[ -f ~/.bash_debug ] && source ~/.bash_debug
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f /opt/bash/run.sh ] && {
  source /opt/bash/run.sh rc
  [[ $- =~ i ]] && {
    source /opt/bash/run.sh tty
  }
}
#---------------------------------------------------