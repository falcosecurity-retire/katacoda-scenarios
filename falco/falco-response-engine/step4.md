NATS is a simple, high performance open source messaging system for cloud native applications, IoT messaging, and microservices architectures.  It is a Cloud Native Computing Foundation member project.

Once you have all of the prerequisites, you can deploy NATS using a Kubernetes Operator and the Kubeless framework that makes use of Kubernetes Custom Resource.

`git clone https://github.com/falcosecurity/kubernetes-response-engine.git
cd kubernetes-response-engine/deployment/cncf
make`{{execute}}

In case `make` fails, just run `make`{{execute}} again.
