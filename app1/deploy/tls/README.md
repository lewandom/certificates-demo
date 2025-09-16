# Server certificate

## Generate server certificate

```
openssl genpkey -out private/server.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -aes-128-cbc
openssl req -new -config server.conf -key private/server.key -out server.csr
pushd ../../../ca/sub-ca/
openssl ca -config sub-ca.conf -in ../../app1/deploy/tls/server.csr -out ../../app1/deploy/tls/server.crt -extensions server_ext
popd
```

## Exporting server certificate and key into format usable by the application

The tls.crt file must contain the entire certificate chain and doesn't need to
contain textual information about the certificate.

The tls.key file must be unencrypted.

```
# create server certificate chain file
# note: the chain starts with server certificate and ends with root CA certificate
openssl x509 -in server.crt > tls.crt
openssl x509 -in ../../../ca/sub-ca/sub-ca.crt >> tls.crt
openssl x509 -in ../../../ca/root-ca/root-ca.crt >> tls.crt

# create server private key file
openssl pkey -in private/server.key > tls.key
```
