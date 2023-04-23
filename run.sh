[ -z "$1" ] && {
    echo $0: directory required
    return 1
}
[ -d "$(dirname ${BASH_SOURCE[0]})/$1" ] || return 1
find "$(dirname ${BASH_SOURCE[0]})/$1" -type f -name '*.sh' | LC_ALL=C.UTF8 sort > /tmp/$$.tmp
while read file; do
    [ -n "$DEBUG" ] && echo Sourcing $file
    source "$file"
done < /tmp/$$.tmp
rm -f /tmp/$$.tmp
