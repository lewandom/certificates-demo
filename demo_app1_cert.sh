#!/usr/bin/env bash

. ./lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# make directory structure
pei "cd app1/deploy/tls/"
pei "mkdir -p private"
pei "chmod 0700 private/"
# generate private key
pei ""
pe "openssl genpkey -out private/server.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -aes-128-cbc"
pe "cat private/server.key"
pe "clear"
# generate csr
pei ""
pe "openssl req -new -config server.conf -key private/server.key -out server.csr"
pe "cat server.csr"
pe "clear"
# sign certificate
pei ""
pe "pushd ../../../ca/sub-ca/"
pe "openssl ca -config sub-ca.conf -in ../../app1/deploy/tls/server.csr -out ../../app1/deploy/tls/server.crt -extensions server_ext"
pe "popd"
pe "clear"
pei ""
pe "cat server.crt"
# enter interactive mode
pei ""
repl
