FROM docker.io/alpine:3.20.1@sha256:b89d9c93e9ed3597455c90a0b88a8bbb5cb7188438f70953fede212a0c4394e0

# renovate: datasource=repology depName=alpine_3_20/curl versioning=loose
ARG CURL_VERSION=8.7.1-r0
# renovate: datasource=repology depName=alpine_3_20/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.90-r3

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
