#insprefix -q "/py/usr/$(ls -1 /py/usr 2> /dev/null | sort -V | tail -n1)"
export PYTHONPYCACHEPREFIX="$HOME/.cache/python"
