
# Use Alpine Linux as our base image so that we minimize the overall size our final container, and minimize the surface area of packages that could be out of date.
FROM alpine:3.8@sha256:a4d41fa0d6bb5b1194189bab4234b1f2abfabb4728bda295f5c53d89766aa046

LABEL description="Docker container for building websites with the Hugo static site generator."
LABEL maintainer="Juan Villela <https://www.juanvillela.dev/>"

# config
ENV HUGO_VER=0.55.5
ENV HUGO_TYPE=_extended
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VER}
ENV HUGO_SHA=f38f0e8beb3d2fee3935e3b51eb1af62ff38600dce36b37e34f6817fdb33abef
ENV HUGO_URL=https://github.com/gohugoio/hugo/releases/download
ENV HUGO_TGZ=v${HUGO_VER}/${HUGO_ID}_Linux-64bit.tar.gz

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
    python3-pip

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available
COPY package*.json ./

RUN pip install --upgrade pip
RUN pip install Pygments
RUN npm install

RUN curl -Ls ${HUGO_URL}/${HUGO_TGZ} -o /tmp/hugo.tar.gz \
    && echo "${HUGO_SHA} /tmp/hugo.tar.gz" | sha256sum -c - \
    && tar xf /tmp/hugo.tar.gz -C /tmp \
    && mv /tmp/hugo /usr/bin/hugo \
    && rm -rf /tmp/hugo* 