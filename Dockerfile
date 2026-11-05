FROM docker.io/alpine:3.24.4@sha256:93b41ef40b1677fce8fcc64ff4af09daddfacf5040afde618bc46c1e2d1cc7d4

# renovate: datasource=repology depName=alpine_3_24/curl versioning=loose
ARG CURL_VERSION="8.23.0-r0"
# renovate: datasource=repology depName=alpine_3_24/dnsmasq versioning=loose
ARG DNSMASQ_VERSION="2.92_p2-r0"

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
