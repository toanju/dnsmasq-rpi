FROM docker.io/alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

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
