# Pull git base image for downloading the repo.
FROM alpine/git:latest

RUN git clone https://github.com/piyx/YoutubeSpotifyDL.git /opt/app

# Pull base image for python.
FROM python:3.8-slim

COPY /entrypoint.sh /opt/app/entrypoint.sh
COPY --from=0 /opt/app/* /opt/app

RUN cd /opt/app && \
    # Install requirements using pip
    pip3 install -r requirements.txt && \
    # Make the entrypoint executable
    chmod +x entrypoint.sh && \
    # Fix spotipy to show the URL on terminal instead of trying to open a browser
    sed -i.bak '419s/None/False/' /usr/local/lib/python3.8/site-packages/spotipy/oauth2.py

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]
CMD [ "/bin/bash" ]