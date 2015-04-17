FROM mhart/alpine-iojs:latest

RUN apk update && \
  apk add postgresql-client && \
  apk add bash && \
  rm -rf /var/cache/apk/*