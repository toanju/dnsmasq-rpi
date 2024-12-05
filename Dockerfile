FROM docker.io/alpine:3.21.0@sha256:e323a465c03a31ad04374fc7239144d0fd4e2b92da6e3e0655580476d3a84621

# renovate: datasource=repology depName=alpine_3_20/curl versioning=loose
ARG CURL_VERSION=8.11.0-r2
# renovate: datasource=repology depName=alpine_3_20/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.90-r3

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
