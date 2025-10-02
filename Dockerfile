FROM docker.io/alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

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
