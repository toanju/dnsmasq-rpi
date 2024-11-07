FROM docker.io/alpine:3.20.3@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

# renovate: datasource=repology depName=alpine_3_20/curl versioning=loose
ARG CURL_VERSION=8.11.0-r1
# renovate: datasource=repology depName=alpine_3_20/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.90-r3

RUN apk -U add \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
