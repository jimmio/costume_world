#!/bin/bash

# Everything here gets run inside the container

if [ $# -eq 0 ]; then
    echo "Usage: ./bubblewrap.sh <executable>"
    exit 0
fi

/opt/donut/donut -a 2 -f 3 /root/bubblewrap/$1
# tail -n +2 loader.rb | head -n -1 | less
# upx --ultra-brute /root/bubblewrap/$1 -o /root/bubblewrap/packed.exe
