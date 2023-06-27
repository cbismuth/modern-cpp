FROM ubuntu:latest

RUN    apt-get    update                    \
    && apt-get -y upgrade                   \
    && apt-get -y dist-upgrade              \
    && apt-get -y install build-essential   \
                          cmake             \
                          clang-format      \
                          clang-tidy        \
                          valgrind          \
                          libboost-all-dev

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=1024&format=b" .skipcache

COPY    . /opt/modern-cpp
WORKDIR   /opt/modern-cpp
RUN       /opt/modern-cpp/docker-entrypoint.sh
