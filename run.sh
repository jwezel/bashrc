[ -z "$1" ] && {
  echo $0: directory required
  return 1
}
[ -d "$(dirname ${BASH_SOURCE[0]})/$1" ] || return 1
[ -n "$BASH_DEBUG" ] && echo ">> Running $(dirname ${BASH_SOURCE[0]})/$1"
find "$(dirname ${BASH_SOURCE[0]})/$1"/ -type f,l -name '*.sh' | LC_ALL=C.UTF8 sort > "$$-run.tmp"
while read file; do
    [ -n "$BASH_DEBUG" ] && echo ">> Sourcing $file"
    source "$file"
    [ "$(type -t BASH_TRACE)" == "function" ] && BASH_TRACE
done < "$$-run.tmp"
rm -f "$$-run.tmp"
