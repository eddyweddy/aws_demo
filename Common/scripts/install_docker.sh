#!/usr/bin/env bash


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ansible-playbook $SCRIPT_DIR/../../stacks/build/docker.yml \
-i "$1," \
-v