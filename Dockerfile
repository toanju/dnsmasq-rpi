FROM docker.io/alpine:3.24.3@sha256:b3413572228e34bd1c9245f5565e6cd127005655e8a7899aef33d8e83255c9e6

# renovate: datasource=repology depName=alpine_3_24/curl versioning=loose
ARG CURL_VERSION="8.22.0-r0"
# renovate: datasource=repology depName=alpine_3_24/dnsmasq versioning=loose
ARG DNSMASQ_VERSION="2.92_p2-r0"

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
