[ -z "$HOME" ] && {
    export HOME="$(dirname $(readlink -f $BASH_SOURCE))"
    echo HOME not set in $BASH_SOURCE. Detected $HOME
}
[ -n "$BASH_DEBUG" ] && echo Running $BASH_SOURCE
[ -f ~/.bashrc ] && . ~/.bashrc
[ -f ~/.bash/run.sh ] && source ~/.bash/run.sh profile
#-------------------------------------------------
