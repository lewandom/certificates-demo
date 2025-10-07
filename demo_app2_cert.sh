#!/usr/bin/env bash

. ./lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# make directory structure
pei "cd app2/deploy/tls/"
pei "mkdir -p private"
pei "chmod 0700 private/"
# create password file
echo -n 'Enter key passphrase: '
read -s PASSPHRASE
echo
echo "$PASSPHRASE" > private/server.keypwd
# generate private key
pei "openssl genpkey -out private/server.key -pass file:private/server.keypwd -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -aes-128-cbc"
# generate csr
pei "openssl req -new -config server.conf -key private/server.key -passin file:private/server.keypwd -out server.csr"
# sign certificate
pei "pushd ../../../ca/sub-ca/"
pei "yes | openssl ca -config sub-ca.conf -passin file:private/sub-ca.keypwd -in ../../app2/deploy/tls/server.csr -out ../../app2/deploy/tls/server.crt -extensions server_ext"
pei "popd"
# enter interactive mode
pei ""
repl
