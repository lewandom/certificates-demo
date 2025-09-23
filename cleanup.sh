#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset

./app1/deploy/tls/cleanup.sh
./app2/deploy/tls/cleanup.sh
./ca/root-ca/cleanup.sh
./ca/sub-ca/cleanup.sh
