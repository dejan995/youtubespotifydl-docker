FROM python:3.8-slim

WORKDIR /opt/app

COPY ./* /opt/app/

RUN cd /opt/app && \
    pip3 install -r requirements.txt && \
    chmod +x entrypoint.sh

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]
# CMD [ "python3", "/opt/app/main.py" ]
