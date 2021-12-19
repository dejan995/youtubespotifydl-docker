# Pull git base image for downloading the repo.
FROM alpine/git:latest

# Clone the git repo.
RUN git clone https://github.com/piyx/YoutubeSpotifyDL.git /opt/app

# Pull base image for python.
FROM python:3.8-alpine3.14

# Set the working directory for the app.
WORKDIR /opt/app

# Copy entrypoint.sh and the git repo in the working directory.
COPY /entrypoint.sh /opt/app/entrypoint.sh
COPY --from=0 /opt/app/* /opt/app/

# Copy update script to user path
COPY /update /usr/local/bin

RUN cd /opt/app && \
    # Install build tools
    apk add --no-cache build-base && \
    # Install requirements using pip
    pip3 install --no-cache-dir -r requirements.txt && \
    # Make the entrypoint executable
    chmod +x entrypoint.sh && \
    # Make the update script executable
    chmod +x /usr/local/bin/update && \
    # Fix spotipy to show the URL on terminal instead of trying to open a browser
    sed -i.bak '419s/None/False/' /usr/local/lib/python3.8/site-packages/spotipy/oauth2.py && \
    # Clean up.
    apk del build-base

# Declare mounting points.
VOLUME [ "/app" ]
VOLUME [ "/downloads" ]

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]
CMD [ "/bin/sh" ]