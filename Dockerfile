FROM debian:11

WORKDIR /opt

RUN apt update && \
    apt install -y gcc git make upx && \
    git clone https://github.com/TheWover/donut.git && \
    cd donut && \
    make

WORKDIR /root/bubblewrap

ENTRYPOINT ["/bin/bash", "./bubblewrap.sh"]