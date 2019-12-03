#!/usr/bin/env bash

# Runs Terraform commands to create the demo
# Runs tf init, plan and apply in succession.
# If you want to see what was created, run terraform show after

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR/stacks/nginx_demo/infrastructure

terraform version
terraform init
terraform plan -var-file=../configuration/dev.tfvars -out=tf.plan
terraform apply tf.plan