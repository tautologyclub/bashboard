#!/bin/bash

# Usage:    psaux $procname
# WTF WHY?:
#   1) Because who doesn't ps aux | grep $procname constantly?
#   2) The other difference is left as an excercise to the reader :P

arg="$1"
ps aux | grep [${arg:0:1}]${arg:1:${#arg}} | grep -v "${0}"
