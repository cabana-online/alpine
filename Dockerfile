ARG ALPINE_VER
ARG ALPINE_DEV

FROM alpine:${ALPINE_VER}

ARG USER=cabana
ARG CABANA_USER_ID=1000
ARG CABANA_GROUP_ID=1000

ENV HOME /home/$USER

RUN set -xe; \
    \
    apk add --update --no-cache \
        bash \
        ca-certificates \
        curl \
        gzip \
        tar \
        unzip \
        wget \
        git \
        perl; \
    rm -rf /var/cache/apk/*

# Creates work user.
RUN \
    addgroup -g "${CABANA_USER_ID}" -S $USER; \
    adduser -u "${CABANA_GROUP_ID}" -D -S -s /bin/bash -G $USER $USER;

# Sets working directory.
WORKDIR $HOME

# Creates the tools folder.
RUN mkdir data tools

# Sets ownership.
RUN chown -R $USER:$USER $HOME

# Changes to work user.
USER $USER
