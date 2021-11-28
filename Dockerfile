FROM debian:11

WORKDIR /opt

RUN apt update && \
    apt install -y gcc git make upx && \
    git clone https://github.com/TheWover/donut.git && \
    cd donut && \
    make

RUN mkdir /root/bubblewrap

WORKDIR /root/bubblewrap

COPY ./ ./

ENTRYPOINT ["/bin/bash", "./bubblewrap.sh"]