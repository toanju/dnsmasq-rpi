FROM docker.io/alpine:3.23.2@sha256:c93cec902b6a0c6ef3b5ab7c65ea36beada05ec1205664a4131d9e8ea13e405d

# renovate: datasource=repology depName=alpine_3_23/curl versioning=loose
ARG CURL_VERSION="8.17.0-r1"
# renovate: datasource=repology depName=alpine_3_23/dnsmasq versioning=loose
ARG DNSMASQ_VERSION="2.91-r0"

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
