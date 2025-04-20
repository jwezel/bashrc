[ -z "$HOME" ] && {
  export HOME="$(awk -F: "\$3==$UID {print \$6}" /etc/passwd)"
  echo HOME not set in ${BASH_SOURCE[0]}. Detected $HOME
}
[ -f ~/.bash_debug ] && source ~/.bash_debug
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash/run.sh ] && {
  source ~/.bash/run.sh rc
}
#---------------------------------------------------
