# Use Alpine Linux as our base image so that we minimize the overall size our final container, and minimize the surface area of packages that could be out of date.
FROM alpine:3.8@sha256:a4d41fa0d6bb5b1194189bab4234b1f2abfabb4728bda295f5c53d89766aa046

LABEL description="Docker container for building websites with the Hugo static site generator."
LABEL maintainer="Juan Villela <https://www.juanvillela.dev/>"

# Config
ENV HUGO_VER=0.55.5
ENV HUGO_BINARY =hugo_extended_${HUGO_VER}_Linux-64bit
ENV HUGO_URL=https://github.com/gohugoio/hugo/releases/download
ENV HUGO_TGZ=v${HUGO_VER}/${HUGO_BINARY}.tar.gz

# Build dependencies
RUN apk update && apk upgrade
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    openssh-client \
    nodejs \
    nodejs-npm \
    python3 \
    py-pip

# Site dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied where available
COPY package*.json ./

RUN pip3 install --upgrade pip setuptools
RUN pip3 install Pygments
RUN npm install

RUN curl -L ${HUGO_URL}/${HUGO_TGZ} | tar -xz \
    && mv hugo /usr/local/bin/hugo \
    && hugo version