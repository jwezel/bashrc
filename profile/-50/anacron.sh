set -x
if [ -n "$(type -p anacron)" -a -e "$HOME/.local/etc/anacrontab" ]; then
  mkdir -vp "$HOME/.local/var/anacron-spool"
  anacron -t "$HOME/.local/etc/anacrontab" -S "$HOME/.local/var/anacron-spool" 'profile-*'
fi
set +x
