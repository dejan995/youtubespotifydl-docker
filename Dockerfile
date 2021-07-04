FROM python:3.8-slim

WORKDIR /opt/app

COPY ./* /opt/app/

RUN cd /opt/app && \
    pip3 install -r requirements.txt && \
    chmod +x entrypoint.sh && \
    sed -i.bak '419s/None/False/' /usr/local/lib/python3.8/site-packages/spotipy/oauth2.py

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]