#!/usr/bin/env bash

. ../../lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# put your demo awesomeness here
pei "mkdir certs db private"
pei "chmod 700 private/"
pei "touch db/index"
pei "openssl rand -hex 16  > db/serial"
pei "echo 1001 > db/crlnumber"
pei ""
# generate private key and certificate signing request
pe "openssl req -new -config sub-ca.conf -out sub-ca.csr -keyout private/sub-ca.key"
pei ""
# sign certificate using Root CA
pe "pushd ../root-ca"
pe "openssl ca -config root-ca.conf -in ../sub-ca/sub-ca.csr -out ../sub-ca/sub-ca.crt -extensions sub_ca_ext"
pe "popd"
pei ""

# enter interactive mode
repl
