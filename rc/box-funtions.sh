#!/bin/bash

box() {
    local TMPFILE="/tmp/$$.tmp"
    bash -c "$@" > "$TMPFILE"
    cat "$TMPFILE"
    kdialog --title "$*" --textbox "$TMPFILE" 1280 1024
    rm -f "$TMPFILE"
}
