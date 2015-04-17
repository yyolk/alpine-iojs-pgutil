FROM mhart/alpine-iojs:latest


RUN apk update && \
  apk add postgresql-client && \
  apk add bash && \
  rm -rf /var/cache/apk/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app
