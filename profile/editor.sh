export EDITOR=$(which mcedit || which joe || which nedit || which vi || which vim || echo /dev/null)
export VISUAL=$(which sublw || which subl || sublime_text || echo $EDITOR)
