#!/usr/bin/env bash

# Runs Terraform destroy to clean up the demo

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR/stacks/nginx_demo/infrastructure

terraform destroy -var-file=../configuration/dev.tfvars