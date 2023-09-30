changedir () {
    local olddir newdir nextDir currentDir level p;
    olddir="$OLDPWD";
    source <(
        for newdir in $(
            (
                p=$(realpath --quiet --relative-to="$OLDPWD" "$PWD")
                until [ "$p" = . ]; do
                    echo $(realpath --quiet "$OLDPWD/$p")
                    p=$(dirname "$p")
                done
            ) | tac
        ); do
            [ -v DEBUG_CHANGEDIR ] && echo "echo $olddir '->' $newdir"
            nextDir="$olddir"
            currentDir=''
            level=''
            while [[ "$nextDir" != "$currentDir" ]]; do
                currentDir="$nextDir"
                nextDir=$(realpath "$nextDir"/..)
                [ -v DEBUG_CHANGEDIR ] && echo "echo Checking old '$currentDir' at level ${level:-0}"
                [ -x "$currentDir/.leave$level" ] && {
                    [ -v DEBUG_CHANGEDIR ] && echo "echo Running '$currentDir/.leave$level'"
                    OLDDIR="$olddir" NEWDIR="$newdir" "$currentDir/.leave$level"
                }
                [ $(dirname "$olddir") = "$newdir" -a -x "$currentDir/.out$level" ] && {
                    [ -v DEBUG_CHANGEDIR ] && echo "echo Running '$currentDir/.out$level'"
                    OLDDIR="$olddir" NEWDIR="$newdir" "$currentDir/.out$level"
                }
                let level=${level:-0}+1
            done
            nextDir="$newdir"
            currentDir=''
            level=''
            while [[ "$nextDir" != "$currentDir" ]]; do
                currentDir="$nextDir"
                nextDir=$(realpath "$nextDir"/..)
                [ -v DEBUG_CHANGEDIR ] && echo "echo Checking new '$currentDir' at level ${level:-0}"
                [ -x "$currentDir/.enter$level" ] && {
                    [ -v DEBUG_CHANGEDIR ] && echo "echo Running '$currentDir/.enter$level'"
                    OLDDIR="$olddir" NEWDIR="$newdir" "$currentDir/.enter$level"
                }
                [ $(dirname "$newdir") = "$olddir" -a -x "$currentDir/.in$level" ] && {
                    [ -v DEBUG_CHANGEDIR ] && echo "echo Running '$currentDir/.in$level'"
                    OLDDIR="$olddir" NEWDIR="$newdir" "$currentDir/.in$level"
                }
                let level=${level:-0}+1
            done
            olddir="$newdir"
        done
    )
}

cd () {
    [[ "$1" == '--' ]] && shift
    builtin cd "${1:-$HOME}" &&
    changedir
}

pushd () {
    [[ "$1" == '--' ]] && shift;
    builtin pushd "${1:-$HOME}" &&
    changedir
}

popd () {
    builtin popd &&
    changedir
}

OLDPWD=/ changedir
