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
pe "openssl req -new -config root-ca.conf -out root-ca.csr -keyout private/root-ca.key"
pei ""
# self-sign root certificate
pe "openssl ca -selfsign -config root-ca.conf -in root-ca.csr -out root-ca.crt -extensions ca_ext"
pei ""

# enter interactive mode
repl
