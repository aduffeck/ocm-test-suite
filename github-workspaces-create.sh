#!/bin/bash

set -e

git clone --branch=main https://github.com/pondersource/nc-sciencemesh
git clone --branch=main https://github.com/pondersource/oc-sciencemesh
git clone --branch=ocm2 https://github.com/aduffeck/reva
git clone --branch=main https://github.com/michielbdejong/ocm-stub

/bin/bash ./gencerts.sh
/bin/bash ./rebuild.sh

docker pull jlesage/firefox:v1.17.1
docker pull mariadb:latest
