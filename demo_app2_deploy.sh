#!/usr/bin/env bash

. ./lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# export server certificate and private key
pe "cd app2/deploy/tls/"
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
