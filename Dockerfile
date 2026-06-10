FROM docker.io/alpine:3.24.0@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4

# renovate: datasource=repology depName=alpine_3_23/curl versioning=loose
ARG CURL_VERSION="8.19.0-r0"
# renovate: datasource=repology depName=alpine_3_23/dnsmasq versioning=loose
ARG DNSMASQ_VERSION="2.91-r1"

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
