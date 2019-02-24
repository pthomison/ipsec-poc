#!/bin/bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
PROJECT_DIR="$(realpath $SCRIPTS_DIR/../)"

pushd $PROJECT_DIR

terraform destroy -auto-approve

popd
