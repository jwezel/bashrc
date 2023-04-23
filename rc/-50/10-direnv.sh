[ -z "$(type -tP direnv)" ] && return
eval "$(direnv hook bash)"
