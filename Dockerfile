FROM docker.io/alpine:3.23.4@sha256:c7989ac7a27b473e1795973c98d714f62b4dd0b134594d36880505ce0bfd716b

# renovate: datasource=repology depName=alpine_3_23/curl versioning=loose
ARG CURL_VERSION="8.17.0-r1"
# renovate: datasource=repology depName=alpine_3_23/dnsmasq versioning=loose
ARG DNSMASQ_VERSION="2.91-r0"

RUN apk -U add --no-cache \
  curl="${CURL_VERSION}" \
  dnsmasq="${DNSMASQ_VERSION}"
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
