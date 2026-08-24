eval "$(zoxide init bash)"

# Do not use builtin cd
__zoxide_cd ()
{
    cd -- "$@"
}
