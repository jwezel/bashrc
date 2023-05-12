export EDITOR="$(which mcedit || which joe || which nano || which vi || which vim || echo /dev/null)"
export VISUAL="$( (which sublw && echo --wait) || (which subl && echo --wait) || (which sublime_text && echo --wait) || echo $EDITOR)"
