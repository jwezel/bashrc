KITTY_INSTALLATION_DIR=/opt/kitty.app

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    source "$KITTY_INSTALLATION_DIR/lib/kitty/shell-integration/bash/kitty.bash"
fi
