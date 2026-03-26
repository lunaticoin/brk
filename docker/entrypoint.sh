#!/bin/sh
set -e

# Fix ownership of data directory (Umbrel creates it as root)
chown -R brk:brk /home/brk/.brk

exec gosu brk brk "$@"
