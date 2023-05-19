changedir () { 
    local OLDDIR NEWDIR d p;
    OLDDIR="$OLDPWD";
    source <(
        for NEWDIR in `(p=$(realpath --quiet --relative-to="$OLDPWD" "$PWD") ; until [ "$p" = . ]; do echo $(realpath --quiet "$OLDPWD/$p"); p=$(dirname "$p"); done) | tac`; do
            [ -v DEBUG_CHANGEDIR ] && echo "# $OLDDIR -> $NEWDIR";
            [ -x "$OLDDIR/.leave" ] && OLDDIR="$OLDDIR" NEWDIR="$NEWDIR" "$OLDDIR/.leave";
            [ -x "$NEWDIR/.enter" ] && OLDDIR="$OLDDIR" NEWDIR="$NEWDIR" "$NEWDIR/.enter";
            [ $(dirname "$NEWDIR") = "$OLDDIR" -a -x "$NEWDIR/.in" ] && OLDDIR="$OLDDIR" NEWDIR="$NEWDIR" "$NEWDIR/.in";
            [ $(dirname "$OLDDIR") = "$NEWDIR" -a -x "$OLDDIR/.out" ] && OLDDIR="$OLDDIR" NEWDIR="$NEWDIR" "$OLDDIR/.out";
            OLDDIR="$NEWDIR";
        done
    )
}

cd () {
    builtin cd "${1:-$HOME}" &&
    changedir
}

pushd () {
    builtin pushd "${1:-$HOME}" &&
    changedir
}

popd () {
    builtin popd &&
    changedir
}

OLDPWD=/ changedir
