type -p moar > /dev/null && {
    export PAGER="$(which moar)"
    export MOAR="-style onedark"
    alias t='moar -no-clear-on-exit -quit-if-one-screen'
} || {
    alias t='less -XF'
}
