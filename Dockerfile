FROM docker.io/alpine:3.18.4
RUN apk -U add dnsmasq curl
VOLUME /var/lib/tftpboot
EXPOSE 53 67 69
ENTRYPOINT ["/usr/sbin/dnsmasq"]
