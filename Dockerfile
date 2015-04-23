FROM mhart/alpine-iojs:latest


RUN apk update && \
  apk add postgresql postgresql-client && \
  apk add bash && \
  apk add git && \
  apk add python && \
  apk add make gcc g++ paxctl curl && \
  rm -rf /var/cache/apk/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app
