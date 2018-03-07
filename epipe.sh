#!/bin/bash

# Usage -- if you're on emacs --daemon, this can be used as an alternative to a
# pager like 'more' or 'less'. Typical example:
#     man mount | epipe
# ------------------------------------------------------------------------------

# Clever way of detecting if the program is being called as a pager:
tty > /dev/null  && {
    emacsclient -nc
    exit 0
}

tmpfile=$(mktemp --tmpdir=/tmp epipe.XXXXXX)
cat > $tmpfile
emacsclient -n $tmpfile &
sleep 0.1
rm $tmpfile
