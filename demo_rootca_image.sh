#!/usr/bin/env bash

. ./lib/demo-magic.sh
TYPE_SPEED=20
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
clear

# enters interactive mode and allows newly typed command to be executed
cmd

# build image
pe "cd ca/root-ca/"
pe "podman build -t example.com/ubi9-quarkus-micro-image:latest ."

# enter interactive mode
repl
