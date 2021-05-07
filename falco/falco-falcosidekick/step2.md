
# Installing Kubeless

Following the official docs: 

`export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml`{{execute}}


# Installing Falco

`kubectl create ns falco
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm install falco falcosecurity/falco --set falco.jsonOutput=true --set falco.httpOutput.enabled=true --set falco.httpOutput.url=http://falcosidekick:2801 -n falco`{{execute}}



# Installing Falcosidekick

It will be installed in the same namespace as *Falco*.

`helm install falcosidekick falcosecurity/falcosidekick --set config.kubeless.namespace=kubeless --set config.kubeless.function=delete-pod -n falco`{{execute}}

You can check the logs to see how it went:

`kubectl logs deployment/falcosidekick -n falco`{{execute}}


# Creating a Kubeless function

The function look like this: 

```
from kubernetes import client,config

config.load_incluster_config()

def delete_pod(event, context):
    rule = event['data']['rule'] or None
    output_fields = event['data']['output_fields'] or None

    if rule and rule == "Terminal shell in container" and output_fields:
        if output_fields['k8s.ns.name'] and output_fields['k8s.pod.name']:
            pod = output_fields['k8s.pod.name']
            namespace = output_fields['k8s.ns.name']
            print (f"Deleting pod \"{pod}\" in namespace \"{namespace}\"")
            client.CoreV1Api().delete_namespaced_pod(name=pod, namespace=namespace, body=client.V1DeleteOptions())
```

#

In general terms, when one condition in a *Falco* rule is meet, it sends an event to *Falcosidekick*. *Falcosidekick* triggers a function in *Kubeless*. *Kubeless* performs the action associated with the function (for example, deleting a pod).