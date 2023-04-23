[ -n "$BASH_DEBUG" ] && echo Running $0
[ -f ~/.bashrc ] && . ~/.bashrc
for dir in /opt/bash ~/.bash; do
  [ -f $dir/run.sh ] && source $dir/run.sh profile
done
#-------------------------------------------------
