Steps to generate Root CA:

```
# initialize directory structure
mkdir certs db private
chmod 700 private/
touch db/index
openssl rand -hex 16  > db/serial
echo 1001 > db/crlnumber
# generate private key and certificate signing request
openssl req -new -config root-ca.conf -out root-ca.csr -keyout private/root-ca.key
# self-sign root certificate
openssl ca -selfsign -config root-ca.conf -in root-ca.csr -out root-ca.crt -extensions ca_ext
```
