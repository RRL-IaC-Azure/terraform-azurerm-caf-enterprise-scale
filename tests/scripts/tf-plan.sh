#!/usr/bin/bash

echo "==> Switching directory..."
cd $PWD/tests/deployment

echo "==> Planning terraform..."
terraform plan \
    -var "root_id='$TF_ROOT_ID'" \
    -var "root_name=ES-'$TF_VERSION'-'$TF_AZ_VERSION'" \
    -parallelism=256 \
    -state="./terraform_'$TF_VERSION'_'$TF_AZ_VERSION'.tfstate" \
    -out="terraform_plan_'$TF_VERSION'_'$TF_AZ_VERSION'"