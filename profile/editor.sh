export EDITOR="$(which micro || which mcedit || which joe || which nano || which vi || which vim || echo /dev/null)"
export VISUAL="$( (which sublww) || (which subl) || (which sublime_text) || echo $EDITOR)"
