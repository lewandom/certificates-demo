#!/usr/bin/env bash

. ./lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# export server certificate chain file
# note: the chain starts with server certificate and ends with root CA certificate
pe "cd app1/deploy/tls/"
pe "openssl x509 -in server.crt > tls.crt"
pe "openssl x509 -in ../../../ca/sub-ca/sub-ca.crt >> tls.crt"
pe "openssl x509 -in ../../../ca/root-ca/root-ca.crt >> tls.crt"
# export server private key file
pe "openssl pkey -in private/server.key -pass file:private/server.keypwd > tls.key"
pe "cat tls.crt"
pe "cat tls.key"
pe "clear"
pei ""
# build the application image
pe "cd ../../"
pe "podman build -f src/main/docker/Dockerfile.native-micro -t \$(minikube ip):5000/certificates-demo-app1 ."
pe "podman push \$(minikube ip):5000/certificates-demo-app1"
# deploy the application
pe "kubectl apply -k deploy/"
pe "clear"
# show secret
pei ""
pe "kubectl get secrets"
secret_name="$(kubectl get secret -oname | sed 's#^secret/##')"
pe "kubectl describe secret $secret_name"
pe "watch kubectl get pods"
pe "clear"
# call the application
pei ""
pe "cd .."
pe "curl --cacert ca/root-ca/root-ca.crt https://certificates-demo-app1.example.com/hello"
# enter interactive mode
repl
