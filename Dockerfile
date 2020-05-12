# Use Alpine Linux as our base image so that we minimize the overall size our final container, and minimize the surface area of packages that could be out of date.
FROM node:12.6.0-alpine as hugo

LABEL description="Docker container for building websites with the Hugo static site generator and Gulp."
LABEL maintainer="Juan Villela <https://www.juanvillela.dev>"

# Build dependencies
RUN apk upgrade -U -a \
  && apk add --no-cache \
  curl \
  libstdc++ \
  && rm -rf /var/cache/* \
  && mkdir /var/cache/apk

# Install HUGO
RUN TAG_LATEST_URL="$(curl -LsI -o /dev/null -w %{url_effective} https://github.com/gohugoio/hugo/releases/latest)" \
    && echo ${TAG_LATEST_URL} \
    && HUGO_VERSION="$(echo ${TAG_LATEST_URL} | egrep -o '[0-9]+\.[0-9]+\.?[0-9]*')" \
    && echo ${HUGO_VERSION} \
    && wget -qO- "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz" | tar xz \
    && mv hugo /usr/local/bin/hugo \
    && chmod +x /usr/local/bin/hugo

RUN hugo version

FROM node:12.6.0-alpine

COPY --from=hugo /usr/local/bin/hugo /usr/local/bin/hugo

# Install npm dependencies
COPY package*.json ./
RUN npm install