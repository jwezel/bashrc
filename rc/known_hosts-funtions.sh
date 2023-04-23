khd () 
{ 
    echo "$@" | xargs -n1 | sort -nr | xargs -i sed -i '{}d' ~/.ssh/known_hosts
}
