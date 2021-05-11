# Installing Falcosidekick

The process is quite the same:

`helm install falcosidekick falcosecurity/falcosidekick --set config.kubeless.namespace=kubeless --set config.kubeless.function=delete-pod -n falco`{{execute}}

You should get this output:

```
NAME: falcosidekick
LAST DEPLOYED: Thu Jan 14 23:55:12 2021
NAMESPACE: falco
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace falco -l "app.kubernetes.io/name=falcosidekick,app.kubernetes.io/instance=falcosidekick" -o jsonpath="{.items[0].metadata.name}")
  kubectl port-forward $POD_NAME 2801:2801
  echo "Visit http://127.0.0.1:2801 to use your application"
```

We check the logs:

`kubectl logs deployment/falcosidekick -n falco`{{execute}}

```
2021/01/14 22:55:31 [INFO]  : Enabled Outputs : Kubeless 
2021/01/14 22:55:31 [INFO]  : Falco Sidekick is up and listening on port 2801
```

Kubeless is displayed as enabled output, everything is good 👍.

A brief explanation of parameters:

config.kubeless.namespace: is the namespace where our Kubeless will run
config.kubeless.function: is the name of our Kubeless function
That's it, we really tried to get a nice UX 😉.