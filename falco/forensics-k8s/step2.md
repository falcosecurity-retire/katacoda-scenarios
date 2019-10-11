You will install Falco using _Helm_, a package manager for Kubernetes that we have already installed in the cluster.  In other environments, you will probably have to install it yourself.

Deploying Falco only takes a simple command:

`helm install --name falco stable/falco`{{execute}}

This will result in a Falco Pod being deployed to each node, and thus the ability to monitor any running containers for abnormal behavior.

The deployment may take a couple of minutes. Check that all the pods are in `Running` state before continuing:

`kubectl get pods`{{execute}}
