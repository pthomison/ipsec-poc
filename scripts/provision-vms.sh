#!/bin/bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
PROJECT_DIR="$(realpath $SCRIPTS_DIR/../)"

pushd $PROJECT_DIR

docker run -d -p 8089:80 --name ipsec-image-hosting --rm -v $(pwd)/images:/usr/share/nginx/html:Z,ro docker.io/library/nginx:1.15 && \
terraform apply -auto-approve
docker stop ipsec-image-hosting

popd
