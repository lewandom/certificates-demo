# certificates-demo

Demo project to showcase PKIX certificate management for business applications.
Uses a slightly customized Quarkus default hello world project.

## Demo scripts and their order of execution

Preparing local certification authority:

1. Create Root CA: `cd ca/root-ca; ./demo_rootca.sh`.
2. Create Subordinate CA: `cd ca/sub-ca; ./demo_subca.sh`.

The actual application demo:

1. Create a certificate for application 1: `./demo_app1_cert.sh`.
2. Create a certificate for application 2: `./demo_app2_cert.sh`.
3. Create container base image : `./demo_rootca_image.sh`.
4. Deploy application 1: `./demo_app1_deploy.sh`.
5. Deploy application 2: `./demo_app2_deploy.sh`.
