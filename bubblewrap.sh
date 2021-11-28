#!/bin/bash

# Everything here gets run inside the container

if [ $# -eq 0 ]; then
    echo "Missing argument."
    exit 0
fi

echo $1
    
