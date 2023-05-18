#!/bin/bash

set -e

REPO_ROOT=`pwd`

git clone --branch=sciencemesh https://github.com/pondersource/nc-sciencemesh
git clone --branch=oc-10-take-2 https://github.com/pondersource/nc-sciencemesh oc-sciencemesh
git clone --branch=master https://github.com/cs3org/reva
git clone --branch=main https://github.com/michielbdejong/ocm-stub

/bin/bash ./gencerts.sh
/bin/bash ./rebuild.sh

docker run -v $REPO_ROOT/ocm-stub:/ocm-stub stub npm install
docker run -v $REPO_ROOT/reva:/reva \
  -e"PATH=/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
  --workdir /reva revad bash -c "git config --global --add safe.directory /reva && make build-revad && make build-reva"
docker run -v $REPO_ROOT/nc-sciencemesh:/var/www/html/apps/sciencemesh --workdir /var/www/html/apps/sciencemesh nc1 make composer
docker run -v $REPO_ROOT/oc-sciencemesh:/var/www/html/apps/sciencemesh --workdir /var/www/html/apps/sciencemesh oc1 make composer

docker pull jlesage/firefox:v1.17.1
docker pull mariadb:latest
