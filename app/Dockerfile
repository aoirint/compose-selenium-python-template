FROM python:3.11

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

WORKDIR /work

RUN apt-get update && \
    apt-get install -y \
        gosu \
        wait-for-it && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -o -u 1000 -U -m user

RUN mkdir -p /work && \
    chown -R user:user /work

ADD ./requirements.txt /tmp/
RUN gosu user pip3 install -r /tmp/requirements.txt

ADD ./code /code
