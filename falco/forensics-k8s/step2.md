You will install **Falco** using _Helm_ (already installed in the cluster), a package manager for *Kubernetes*.

Let's add the *Helm chart* and deploy Falco executing:

```
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
kubectl create ns falco
helm install falco -n falco falcosecurity/falco
```{{execute}}

This will result in a Falco Pod being deployed to each node, and thus the ability to monitor any running containers for abnormal behavior.

The deployment may take a couple of minutes. Check that all the pods are in `Running` state:

`kubectl get pods -n falco`{{execute}}
