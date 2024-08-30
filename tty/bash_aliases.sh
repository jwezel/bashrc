if type -p lsd > /dev/null; then
 alias l="lsd --hyperlink=auto --group-directories-first --date '+%F %T'"
 alias ll="lsd --hyperlink=auto --group-directories-first --long --date '+%F %T'"
 alias la="lsd --hyperlink=auto --group-directories-first --all --date '+%F %T'"
 alias lla="lsd --hyperlink=auto --group-directories-first --long --all --date '+%F %T'"
 alias lld="lsd --hyperlink=auto --group-directories-first --long --directory-only --date '+%F %T'"
 alias llda="lsd --hyperlink=auto --group-directories-first --long --all --directory-only --date '+%F %T'"
 alias llad="lsd --hyperlink=auto --group-directories-first --long --all --directory-only --date '+%F %T'"
 alias llt="lsd --hyperlink=auto --group-directories-first --long --sort time --date '+%F %T'"
 alias llat="lsd --hyperlink=auto --group-directories-first --long --all --sort time --date '+%F %T'"
 alias llta="lsd --hyperlink=auto --group-directories-first --long --all --sort time --date '+%F %T'"
 alias tl="lsd --hyperlink=auto --tree --group-directories-first --date '+%F %T'"
 alias tll="lsd --hyperlink=auto --tree --group-directories-first --long --date '+%F %T'"
 alias tla="lsd --hyperlink=auto --tree --group-directories-first --all --date '+%F %T'"
 alias tlla="lsd --hyperlink=auto --tree --group-directories-first --long --all --date '+%F %T'"
 alias tlld="lsd --hyperlink=auto --tree --group-directories-first --long --directory-only --date '+%F %T'"
 alias tllda="lsd --hyperlink=auto --tree --group-directories-first --long --all --directory-only --date '+%F %T'"
 alias tllad="lsd --hyperlink=auto --tree --group-directories-first --long --all --directory-only --date '+%F %T'"
 alias tllt="lsd --hyperlink=auto --tree --group-directories-first --long --sort time --date '+%F %T'"
 alias tllat="lsd --hyperlink=auto --tree --group-directories-first --long --all --sort time --date '+%F %T'"
 alias tllta="lsd --hyperlink=auto --tree --group-directories-first --long --all --sort time --date '+%F %T'"
elif type -p exa > /dev/null; then
 alias l="exa --time-style long-iso"
 alias ll="exa --long --time-style long-iso"
 alias la="exa --all --time-style long-iso"
 alias lla="exa --long --all --time-style long-iso"
 alias lld="exa --long --directory-only --time-style long-iso"
 alias llda="exa --long --all --directory-only --time-style long-iso"
 alias llad="exa --long --all --directory-only --time-style long-iso"
 alias llt="exa --long --sort time --time-style long-iso"
 alias llat="exa --long --all --sort time --time-style long-iso"
 alias llta="exa --long --all --sort time --time-style long-iso"
elif type -p lc > /dev/null; then
 alias l="lc --excl=dot"
 alias ll="lc -sj"
 alias la="lc"
 alias lla="lc -sja"
 alias lld="lc -sj --dirs"
 alias llda="lc -sja --dirs"
 alias llad="lc -sja --dirs"
 alias llt="lc -sj --order=m"
 alias llat="lc -sja --order=m"
 alias llta="lc -sja --order=m"
fi

alias beep="printf '\a'"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../../..'
