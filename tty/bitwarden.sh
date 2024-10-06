[ -e "~/.ssh/bitwarden-session-token" ] && {
  export BW_SESSION="$(cat ~/.ssh/bitwarden-session-token)"
}
