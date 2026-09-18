FROM docker.io/alpine:3.24.2@sha256:31b6477333eb8257db9e5d7c3a7264fd0467928756f0bbcc27d35bea5d28cdbd

# renovate: datasource=repology depName=alpine_3_24/curl versioning=loose
ARG CURL_VERSION="8.22.0-r0"
# renovate: datasource=repology depName=alpine_3_24/dnsmasq versioning=loose
ARG DNSMASQ_VERSION="2.92_p2-r0"

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
