#!/bin/bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ANSIBLE_DIR="$(realpath $SCRIPTS_DIR/../ansible)"

pushd $ANSIBLE_DIR

ansible-playbook -i inventory.yaml ./main.yml

popd
