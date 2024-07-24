FROM docker.io/alpine:3.20.2@sha256:33d84999a8f227f8eaf1631272f9db170ff2043f4d49833653e2d48fe3b4cc91

# renovate: datasource=repology depName=alpine_3_20/curl versioning=loose
ARG CURL_VERSION=8.9.0-r0
# renovate: datasource=repology depName=alpine_3_20/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.90-r3

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
