#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset
SCRIPT_PATH="$(dirname -- ${BASH_SOURCE[0]})";

for f in certs/ db/ private/ root-ca.crt root-ca.csr; do
    rm -rf "$SCRIPT_PATH/$f"
done
