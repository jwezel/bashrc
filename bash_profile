[ -n "$BASH_DEBUG" ] && echo Running $BASH_SOURCE
[ -f ~/.bashrc ] && . ~/.bashrc
[ -f $(dirname $(readlink -f $BASH_SOURCE))/run.sh ] && source $(dirname $(readlink -f $BASH_SOURCE))/run.sh profile
#-------------------------------------------------
