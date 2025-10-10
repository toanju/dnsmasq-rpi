FROM docker.io/alpine:3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

# renovate: datasource=repology depName=alpine_3_22/curl versioning=loose
ARG CURL_VERSION=8.14.1-r2	
# renovate: datasource=repology depName=alpine_3_22/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.91-r0

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
