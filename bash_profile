[ -z "$HOME" ] && {
    export HOME="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
    echo HOME not set in ${BASH_SOURCE[0]}. Detected $HOME
}
[ -n "$BASH_DEBUG" ] && echo Running ${BASH_SOURCE[0]}
[ -f ~/.bashrc ] && . ~/.bashrc
[ -f ~/.bash/run.sh ] && {
	source ~/.bash/run.sh profile
	source ~/.bash/run.sh tty
}
#-------------------------------------------------
