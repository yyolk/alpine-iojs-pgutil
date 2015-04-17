FROM gliderlabs/alpine:3.1

#ENV VERSION=v0.10.38 CMD=node DOMAIN=nodejs.org
#ENV VERSION=v0.12.2 CMD=node DOMAIN=nodejs.org
ENV VERSION=v1.7.1 CMD=iojs DOMAIN=iojs.org

RUN apk update && \
  apk add make gcc g++ python paxctl curl && \
  curl -sSL https://${DOMAIN}/dist/${VERSION}/${CMD}-${VERSION}.tar.gz | tar -xz && \
  cd /${CMD}-${VERSION} && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  export CFLAGS="$CFLAGS -D__USE_MISC" && \
  ./configure --prefix=/usr && \
  make -j${NPROC} -C out mksnapshot && \
  paxctl -c -m out/Release/mksnapshot && \
  make -j${NPROC} && \
  make install && \
  paxctl -cm /usr/bin/${CMD} && \
  apk del make gcc g++ python paxctl curl && \
  apk add libgcc libstdc++ && \
  apk add postgresql-client && \
  apk add bash && \
  cd / && \
  rm -rf /${CMD}-${VERSION} /var/cache/apk/* /tmp/* /root/.npm \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html
