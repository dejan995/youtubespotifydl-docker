FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt/app

COPY ./* /opt/app/

RUN apt install python3-pip && \
    cd /opt/app && \
    pip3 install -r requirements.txt