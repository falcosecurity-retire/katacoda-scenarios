You will install Falco using Helm, a package manager for Kubernetes that we have already installed in the cluster.
In other environments, you will probably have to install it yourself.

`cd
helm install --name falco --set integrations.natsOutput.enabled=true -f custom_rules.yaml stable/falco`{{execute}}

Notice that each falco pod has two containers, `falco` and `falco-nats`:

`kubectl get pods
kubectl get po -o jsonpath="{.items[*].spec.containers[*].name" | tr -s '[[:space:]]' '\n' | sort | uniq`{{execute}}
