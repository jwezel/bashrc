type changedir >& /dev/null && {

  cd () {
    [[ "$1" == '--' ]] && shift
    [[ "$1" == '-' ]] &&
    . <(changedir "${OLDPWD}") ||
    . <(changedir "${1:-$HOME}")
}

  pushd () {
    [[ "$1" == '--' ]] && shift;
    builtin pushd -n "${1:-$HOME}" &&
    . <(changedir "$(dirs +0)")
  }

  popd () {
    builtin popd -n &&
    . <(changedir "$(dirs +0)")
  }

  . <(changedir . /)
}
