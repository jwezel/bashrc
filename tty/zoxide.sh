type -p zoxide > /dev/null && eval "$(zoxide init bash)"

# Override, to use customzed cd version
__zoxide_cd() {
  cd "$@"
}
