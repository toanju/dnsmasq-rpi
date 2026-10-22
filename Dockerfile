FROM docker.io/alpine:3.24.3@sha256:1b7232cda4ca3dc20b5d1247bdc9bfb631f2661d15d323bdd6fccc035ed1a9e7

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
