# Create directory on the fly
ncd() {
    cd "$1" 2> /dev/null || {
        mkdir -pv "$1"
        cd "$1"
    }
}
