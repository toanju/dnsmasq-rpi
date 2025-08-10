#!/bin/bash

INVENTORY="inventory.yaml"

MATCHBOX_HOST="matchbox.lan"
MATCHBOX_PORT="8080"
MATCHBOX_URL="http://${MATCHBOX_HOST}:${MATCHBOX_PORT}/"
MATCHBOX_IP="10.10.10.1"

INTERFACE="${INTERFACE:-vlan0}"

# use provided BASE_INTERFACE or use first ether interface
BASE_INTERFACE=${BASE_INTERFACE:-$(ip -j l l | jq '[.[]|select(.link_type=="ether")][0] | .ifname')}
NTP_SERVER="10.10.10.1"
DHCP_START="10.10.10.10"
DHCP_END="10.10.10.100"

HOSTSFILE="hosts.rpi4"

function inc_ip() {
  read -r A B C D <<<"${1//./ }"
  (( D += 1 ))
  echo "$A.$B.$C.$D"
}

function write_hostsfile() {
  [ -f "$HOSTSFILE" ] && rm $HOSTSFILE
  CUR_IP="$DHCP_START"
  readarray hosts < <(yq -o=j -I=0 '.hosts[]' ${INVENTORY} )

  for host in "${hosts[@]}"; do
    HOST=$(echo "$host" | yq '.hostname' -)
    MAC=$(echo "$host" | yq '.mac' -)
    SERIAL=$(echo "$host" | yq '.serial' -)

    echo "$MAC,${CUR_IP},$HOST" >> $HOSTSFILE

    # symlink_uefi
    ln -sf rpi4uefiboot "tftpboot/$SERIAL"

    # increment ip... TODO check bounds
    CUR_IP=$(inc_ip "$CUR_IP")
  done
}

# check if the configured $INTERFACE exists
CHECK_INTERFACE=$(ip -j l l | jq ".[] | select(.ifname == \"${INTERFACE}\")")
if [ -z "$CHECK_INTERFACE" ]; then
  echo "Please create $INTERFACE, e.g:
  sudo ip l a  link $BASE_INTERFACE type vlan id 200
  sudo ip l l
  sudo ip l s $INTERFACE up
  sudo firewall-cmd --change-zone=$INTERFACE --zone=trusted
  "
  exit 1
fi
CHECK_ADDRESS=$(ip a l dev "$INTERFACE" scope global)
if [ -z "$CHECK_ADDRESS" ]; then
  echo "Please add an IP address to $INTERFACE, e.g:
  sudo ip a a $MATCHBOX_IP/24 dev $INTERFACE
  "
  exit 1
fi

# download firmware
./download-firmware.sh
# write hostsfile and symlink uefi firmware for hosts in inventory
write_hostsfile
# run dnsmasq
sudo podman run -ti --rm --cap-add=NET_RAW,NET_ADMIN --net=host -v "$PWD/tftpboot":/var/lib/tftpboot:Z -v "$PWD/HOSTSFILE":/etc/$HOSTSFILE:Z ghcr.io/toanju/dnsmasq-rpi:latest \
	--no-daemon \
	--interface=${INTERFACE} \
	--bind-dynamic \
	--enable-tftp \
	--tftp-root=/var/lib/tftpboot \
	--log-queries \
	--log-dhcp \
	--dhcp-range=${DHCP_START},${DHCP_END} \
	--dhcp-hostsfile=/etc/hosts.rpi4 \
	--dhcp-option=option:ntp-server,${NTP_SERVER} \
	--dhcp-ignore=tag:!known \
	--dhcp-mac=set:rpi,e4:5f:01:*:*:* \
	--dhcp-mac=set:rpi,dc:a6:32:*:*:* \
	--pxe-service=tag:rpi,0,"Raspberry Pi Boot" \
	--dhcp-match=set:armefi64,option:client-arch,11 \
	--dhcp-boot=tag:armefi64,ipxe.arm64.efi \
	--dhcp-userclass=set:ipxe,iPXE \
	--dhcp-boot=tag:ipxe,${MATCHBOX_URL}boot.ipxe \
	--no-hosts \
	--address=/${MATCHBOX_HOST}/${MATCHBOX_IP}
