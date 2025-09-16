# Application 1

Application 1 is a simple server example. It's an unmodified Quarkus Hello World
code that features a single REST resource. The whole purpose of this PoC is to
showcase how to configure a TLS port with a valid CA-signed certificate.

Follow steps defined in [TLS README](./deploy/tls/README.md) to generate server
certificate. The certificate is automatically pulled in by the Kustomize
configuration which resides in the `deploy` directory.

## Building container image

Tested with native Quarkus build. Run the commands from within project root.

1. Build application binary:
   ```
   ./gradlew :app1:build \
     -Dquarkus.native.enabled=true -Dquarkus.package.jar.enabled=false
   ```
2. Build container image:
   ```
   cd app1/
   podman build -f app1/src/main/docker/Dockerfile.native-micro \
     -t $(minikube ip):5000/certificates-demo-app1 app1/
   ```

## Deploying the application

1. Push container image to the minikube internal registry:
   ```
   podman push $(minikube ip):5000/certificates-demo-app1
   ```
2. Create application resources in minikube:
   ```
   kubectl apply -k app1/deploy/
   ```

## Enabling browser connection from host

The application resources include a LoadBalancer type service, which opens
port 443 (default HTTPS) on a tunnelled connection. To enable tunneling,
run the following command in a separate terminal window/tab:

```
minikube tunnel
```

With this, run `kubectl get svc certificates-demo-app1` to get the IP address
of the exposed service. Use this IP address to configure the host alias matching
the certificate DN in `/etc/hosts`, e.g.:

```
10.102.140.163   certificates-demo-app1.example.com
```

Lastly, import the Root CA into your browser local certificates store.
At this point, navigating to https://certificates-demo-app1.example.com with
the browser should display the hello world message over a secure connection.
