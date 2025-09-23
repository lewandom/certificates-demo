#!/usr/bin/env bash

. ./lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# generate private key and certificate
pei "cd app2/deploy/tls/"
pei "mkdir -p private"
pei "chmod 0700 private/"
pei "openssl genpkey -out private/server.key -pass file:private/server.keypwd -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -aes-128-cbc"
pei "openssl req -new -config server.conf -key private/server.key -passin file:private/server.keypwd -out server.csr"
pei "pushd ../../../ca/sub-ca/"
pei "yes | openssl ca -config sub-ca.conf -passin file:private/sub-ca.keypwd -in ../../app2/deploy/tls/server.csr -out ../../app2/deploy/tls/server.crt -extensions server_ext"
pei "popd"
# export server certificate and private key
pei "openssl x509 -in server.crt > tls.crt"
pei "openssl x509 -in ../../../ca/sub-ca/sub-ca.crt >> tls.crt"
pei "openssl x509 -in ../../../ca/root-ca/root-ca.crt >> tls.crt"
pei "openssl pkey -in private/server.key -passin file:private/server.keypwd > tls.key"
pe "clear"
# build the application image
pei ""
pe "cd ../../"
pe "podman build -f src/main/docker/Dockerfile.native-micro -t \$(minikube ip):5000/certificates-demo-app2 ."
pe "podman push \$(minikube ip):5000/certificates-demo-app2"
pe "clear"
# deploy the application
pei ""
pe "kubectl apply -k deploy/"
pe "watch kubectl get pods"
# call the application
pe "cd .."
pe "curl --cacert ca/root-ca/root-ca.crt https://certificates-demo-app2.example.com/hello"
# enter interactive mode
pei ""
repl
