FROM registry.access.redhat.com/ubi9/ubi-minimal:9.6 as nativelibs
RUN microdnf install -y p11-kit

FROM quay.io/quarkus/ubi9-quarkus-micro-image:2.0

COPY --from=nativelibs /usr/bin/p11-kit /usr/bin/trust /usr/bin/
COPY --from=nativelibs /usr/lib64/libp11-kit.so.0 /usr/lib64/libtasn1.so.6 \
    /usr/lib64/libffi.so.8 /usr/lib64/p11-kit-proxy.so /usr/lib64/
COPY --from=nativelibs /usr/lib64/pkcs11/p11-kit-trust.so /usr/lib64/pkcs11/
COPY --from=nativelibs /usr/share/p11-kit/modules/p11-kit-trust.module \
    /usr/share/p11-kit/modules/

# Regenerate JSSE keystore
COPY root-ca.crt /etc/pki/ca-trust/source/anchors/example_root_ca.crt
RUN set -eux; \
    mkdir -p /etc/pki/ca-trust/extracted/java/; \
    trust extract --filter=ca-anchors --format=java-cacerts --overwrite \
    --purpose server-auth /etc/pki/ca-trust/extracted/java/cacerts
