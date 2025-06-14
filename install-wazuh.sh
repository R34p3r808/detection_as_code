#!/bin/bash
apt-get update
apt-get install -y curl apt-transport-https lsb-release gnupg

curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh
bash wazuh-install.sh -a
