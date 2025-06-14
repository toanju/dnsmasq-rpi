FROM docker.io/alpine:3.22.0@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715

# renovate: datasource=repology depName=alpine_3_22/curl versioning=loose
ARG CURL_VERSION=8.14.1-r0	
# renovate: datasource=repology depName=alpine_3_22/dnsmasq versioning=loose
ARG DNSMASQ_VERSION=2.91-r0

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
