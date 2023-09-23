# syntax=docker/dockerfile:1.5
FROM python:3.11

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN <<EOF
    set -eu

    apt-get update

    apt-get install -y \
        gosu \
        wait-for-it

    apt-get clean
    rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
    set -eu

    useradd -o -u 1000 -U -m user
EOF

ADD ./requirements.txt /tmp/
RUN <<EOF
    set -eu

    gosu user pip3 install -r /tmp/requirements.txt
EOF

WORKDIR /work

RUN <<EOF
    set -eu

    mkdir -p /work
    chown -R user:user /work
EOF

ADD ./code /code
