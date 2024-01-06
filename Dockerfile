FROM docker.io/alpine:3.19.0

# renovate: datasource=repology depName=alpine_3_19/curl versioning=loose
ARG CURL_VERSION=8.4.0.6
# renovate: datasource=repology depName=alpine_3_19/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.89

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
