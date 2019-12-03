#!/usr/bin/env bash


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ansible-playbook \
$SCRIPT_DIR/../../stacks/build/create_ami.yml \
-i $SCRIPT_DIR/../../stacks/build/inventories/hosts \
-e demo_server=docker \
-v