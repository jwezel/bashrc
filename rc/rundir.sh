rundir () {
  local usage='
Run all shellscripts in a directory named *.sh.

Usage:
  rundir [options] DIRECTORY ...

Options:
  -r, --recursive Run scripts in the whole directory tree, not just the top level.
  -s, --silent    Be silent about non-accessible directories.
  -v, --verbose   Comment actions.
  -h, --help      Display this help message.
'

  declare maxdepth='-maxdepth 1' silent verbose dirs errors=0

  for arg in $(
    getopt --options rsvh --longoptions recursive,silent,verbose,help --alternative --shell bash --name "$0" -- "$@"
  ); do
    case "$arg" in
      -r|--recursive)
      maxdepth=''
      ;;

      -s|--silent)
      silent=yes
      ;;

      -v|--verbose)
      verbose=yes
      ;;

      -h|--help)
      echo "$usage"
      return 0
      ;;

      --)
      ;;

      *)
      dirs="$dirs $arg"
      ;;
    esac
  done

  [ -z "$dirs" ] && {
    echo "rundir: directory required"
    return 1
  }
  eval dirs=($dirs)
  for dir in $dirs; do
    [ -d "$dir" ] || {
      [ -z "$silent" ] && echo "rundir: $dir is not a directory"
      errors=1
      continue
    }
    [ -x "$dir" ] || {
      [ -z "$silent" ] && echo "rundir: Cannot access directory $dir"
      errors=1
      continue
    }
    [ -n "$verbose" ] && echo "rundir: Running $dir"
    {
      find "$dir"/ $maxdepth -type f,l -name '*.sh' | LC_ALL=C.UTF8 sort |
      while read -r file; do
          [ -n "$verbose" ] && echo "rundir: Sourcing $file"
          source "$file"
      done
    }
  done
  return $errors
}
