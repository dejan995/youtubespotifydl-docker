FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt/app

COPY ./* /opt/app/

RUN apt update -y && \
    apt install -y python3-pip && \
    cd /opt/app && \
    pip3 install -r requirements.txt && \
    chmod +x entrypoint.sh

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]
CMD [ "python3 /opt/app/main.py" ]
