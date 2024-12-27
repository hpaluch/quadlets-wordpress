#!/bin/bash
set -xeuo pipefail
IGNITION_CONFIG="`pwd`/example.ign"
IMAGE="/opt/iso/fedora-coreos-41.20241122.3.0-qemu.x86_64.qcow2"
VM_NAME="fcos41-wp"
VCPUS="4"
RAM_MB="4096"
DISK_GB="10"
# For x86 / aarch64,
IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}")

# Setup the correct SELinux label to allow access to the config
#chcon --verbose --type svirt_home_t ${IGNITION_CONFIG}

# NOTE: has to manually shutdown/reboot at the end...
virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora40" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --network bridge=virbr0 "${IGNITION_DEVICE_ARG[@]}"
