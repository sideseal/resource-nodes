#!/usr/bin/env bash

# Script Path
SCRIPTPATH='$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )'
echo "ScriptPath: $SCRIPTPATH"

# Install Cinder packages and tgt (for block storage)
echo "Install Packages"
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y cloud-archive:yoga
sudo apt install -y cinder-volume tgt

# Install LVM, thin-provisioning-tools
$SCRIPTPATH/lvm.sh

# Install pip and OpenStack client
echo "Install OpenStack Client"
sudo apt install python3-pip
pip install python-openstackclient

echo "Starting Services"
sudo systemctl restart tgt
sudo systemctl enable tgt
sudo systemctl restart cinder-volume
sudo systemctl enable cinder-volume
