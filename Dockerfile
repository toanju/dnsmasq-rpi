FROM docker.io/alpine:3.20.1@sha256:cf3f1802132e21fa51a6edd5b0c41084de134959fddf9dc5d9faf2920a2985b2

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
