#!/bin/bash
# TODO: License, author, etc

# A collection of random bash hacks. Not really intended to be executed/sourced
# obviously -- if something looks useful, just copy paste it somewhere else.

# Note: Some of these aren't all that useful and are mostly there to showcase
# random neat stuff. But some of them are pretty golden!


random_string()
# A random "normal" string of length $1 (useful for file names and stuff where
# you might not want spaces or escape characters)
{
    # Usage:  random_string $len
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$1" | head -n 1
}

random_file()
# Generate a random file of $1 bytes with name $2
{
    # Usage:  random_file $name $size
    head -c "$2" < /dev/urandom > "$1"
}

copypwd()
# If you don't have a terminal that lets you navigate through stdout, this one's
# golden. But also, check out termite.
{
    require xclip
    pwd | xclip -selection clipboard
}

local_ip_with_mask()
# Doesn't work if your local ip doesn't start with 192.168 :) clearly
# improvable -- mostly here to show that grep -o is really sweet
{
    # Usage: local_ip_with_mask [$device]
    ip addr show "$1" \
        | grep -o "192\\.168\\.[0-9]*\\.[0-9]*/[0-9]*"
}

errcho()
# just like echo, but to stderr!
{
    # Usage:  errcho [-flags] $string
    echo -n "ERROR: " 1>&2
    echo "$*" 1>&2
}

require()
# Give up early rather than late! (this one's actually amazing)
# Note: you can actually require require! I.e. command -v works for binaries,
# shell built-ins, aliases, everything.
{
    # Usage:  require $app1 $app2 $app3 ...
    for cmd in "$@" ; do
        command -v "$cmd" > /dev/null || {
            errcho "$cmd not found!"
            exit 1
        }
    done
}

justfuckingCOMPILEALREADY()
# When you'd really rather prefer the Linux kernel to make the decisions for you
{
    # Usage:  alias make=justfuckingCOMPILEALREADY
    require yes make
    yes "" | make "$*"
}

mountie()
# Because typing mount commands is really boring
{
    # Usage:  mountie [$dev]
    mpoint=/mnt/"$1"
    sudo mkdir -p "$mpoint"

    # Ensure moint point is empty, then mount (this works because ls $dir/*
    # errors out if $dir is empty -- mm, tasty hacks...)
    ls "$mpoint/*" > /dev/null 2>&1 && \
        sudo mount /dev/"$1" "$mpoint" && echo "Mounted on $mpoint"
}
