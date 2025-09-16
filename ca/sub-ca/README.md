# Subordinate (Intermediate) CA

## Steps to generate Subordinate CA:

```
# initialize directory structure
mkdir certs db private
chmod 700 private/
touch db/index
openssl rand -hex 16  > db/serial
echo 1001 > db/crlnumber
# generate private key and certificate signing request
openssl req -new -config sub-ca.conf -out sub-ca.csr -keyout private/sub-ca.key
# sign certificate using Root CA
cd ../root-ca
openssl ca -config root-ca.conf -in ../sub-ca/sub-ca.csr -out ../sub-ca/sub-ca.crt -extensions sub_ca_ext
```

## Signing server certificate using Subordinate CA

```
openssl genpkey -out server.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -aes-128-cbc
openssl req -new -key server.key -out server.csr
openssl ca -config sub-ca.conf -in server.csr -out server.crt -extensions server_ext
```
