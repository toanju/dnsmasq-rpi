FROM docker.io/alpine:3.19.1@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

# renovate: datasource=repology depName=alpine_3_19/curl versioning=loose
ARG CURL_VERSION=8.5.0-r0
# renovate: datasource=repology depName=alpine_3_19/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.90-r1

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
