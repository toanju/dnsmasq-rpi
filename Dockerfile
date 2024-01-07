FROM docker.io/alpine:3.19.0@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48N

# renovate: datasource=repology depName=alpine_3_19/curl versioning=loose
ARG CURL_VERSION=8.5.0-r0
# renovate: datasource=repology depName=alpine_3_19/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.89-r6

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
