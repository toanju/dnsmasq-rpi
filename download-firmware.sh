#!/bin/bash

# Files as described here: https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4
set -e

BRANCH="master" # or use a tag e.g. 1.20220830
DL_URL="https://github.com/raspberrypi/firmware/raw/${BRANCH}/boot"
FW_FILES="" # bcm2711-rpi-4-b.dtb fixup4.dat start4.elf
FW_OVERLAYS="miniuart-bt.dbto"
TFTP_DIR="tftpboot"
RPI_FW="${TFTP_DIR}/rpi4uefiboot"

function download_uefi_firmware() {
 pushd ${RPI_FW}
  FW_VERSION=$(curl --silent "https://api.github.com/repos/pftf/RPi4/releases/latest" | jq -r .tag_name)
  curl -LO https://github.com/pftf/RPi4/releases/download/${FW_VERSION}/RPi4_UEFI_Firmware_${FW_VERSION}.zip
  unzip RPi4_UEFI_Firmware_${FW_VERSION}.zip
  rm RPi4_UEFI_Firmware_${FW_VERSION}.zip
 popd
}

function download_rpi_firmware() {
 for f in $FW_FILES; do
  curl --output-dir "$RPI_FW" -O ${DL_URL}/$f
 done

 for f in $FW_OVERLAYS; do
  curl --output-dir $RPI_FW/overlays -O ${DL_URL}/overlays/$f
 done
}

# see https://github.com/poseidon/dnsmasq/blob/main/get-tftp-files
function download_pxe_fw() {
 curl -s -o $TFTP_DIR/undionly.kpxe http://boot.ipxe.org/undionly.kpxe
 cp $TFTP_DIR/undionly.kpxe $TFTP_DIR/undionly.kpxe.0
 curl -s -o $TFTP_DIR/ipxe.efi http://boot.ipxe.org/ipxe.efi
 curl -s -o $TFTP_DIR/ipxe.arm64.efi https://boot.ipxe.org/arm64-efi/ipxe.efi
}

function create_config() {
 cat <<EOF > ${RPI_FW}/config.txt
arm_64bit=1
enable_uart=1
enable_gic=1
armstub=RPI_EFI.fd
disable_commandline_tags=1
device_tree_address=0x1f0000
device_tree_end=0x200000
EOF

 for o in ${FW_OVERLAYS}; do
  echo "dtoverlay=$(basename $o .dbto)" >> ${RPI_FW}/config.txt
 done
}

mkdir -p ${RPI_FW}/overlays
download_pxe_fw
download_rpi_firmware
download_uefi_firmware
create_config
