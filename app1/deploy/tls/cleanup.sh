#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset
SCRIPT_PATH="$(dirname -- ${BASH_SOURCE[0]})";

for f in certs/ server.crt server.csr tls.crt tls.key; do
    rm -rf "$SCRIPT_PATH/$f"
done
