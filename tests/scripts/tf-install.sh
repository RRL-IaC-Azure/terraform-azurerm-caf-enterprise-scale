#!/usr/bin/bash

echo "==> Creating directory..."
mkdir -p /home/runner/.terraform/bin/

echo "==> Downloading archive..."
wget 'https://releases.hashicorp.com/terraform/0.14.0/terraform_'$TF_VERSION'_linux_amd64.zip' -P /tmp

echo "==> Expanding archive..."
unzip '/tmp/terraform_'$TF_VERSION'_linux_amd64.zip' -d /tmp

echo "==> Moving binaries..."
mv /tmp/terraform /home/runner/.terraform/bin/terraform

echo "==> Exporting path..."
echo "/home/runner/.terraform/bin" >> $GITHUB_PATH