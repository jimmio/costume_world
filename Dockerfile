FROM debian:11

WORKDIR /opt

RUN apt update && \
    apt install -y gcc git make mingw-w64 upx && \
    git clone https://github.com/TheWover/donut.git && \
    cd donut && \
    make

WORKDIR /root/costume_world

ENTRYPOINT ["/bin/bash", "./costume_world.sh"]