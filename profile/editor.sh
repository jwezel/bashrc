export EDITOR=$(which mcedit || which joe || which nedit || which vi || which vim || echo /dev/null)
export VISUAL=$((which sublw && echo sublw --wait) || (which subl && echo subl --wait) || (which sublime_text && echo sublime_text --wait) || echo $EDITOR)
alias v="$EDITOR"
