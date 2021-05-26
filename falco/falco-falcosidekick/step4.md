# Installing Falco

Firstly, we'll create the namespace that will both Falco and Falcosidekick:

`kubectl create ns falco`{{execute}}

Add the *helm* repo:

`helm repo add falcosecurity https://falcosecurity.github.io/charts`{{execute}}

In a real project, you should get the whole chart with helm pull falcosecurity/falco --untar and then configure the values.yaml. For this tutorial, will try to keep thing as easy as possible and set configs directly by helm install command:

`helm install falco falcosecurity/falco --set falco.jsonOutput=true --set falco.httpOutput.enabled=true --set falco.httpOutput.url=http://falcosidekick:2801 -n falco`{{execute}}

You should get this output:

```
NAME: falco
LAST DEPLOYED: Thu Jan 14 23:43:46 2021
NAMESPACE: falco
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Falco agents are spinning up on each node in your cluster. After a few
seconds, they are going to start monitoring your containers looking for
security issues.
No further action should be required.
```

And executing `kubectl get pods -n falco`{{execute}} you can see your new Falco pods:

```
NAME                           READY   STATUS        RESTARTS   AGE
falco-ctmzg                    1/1     Running       0          111s
falco-sfnn8                    1/1     Running       0          111s
```

The arguments

```
--set falco.jsonOutput=true --set falco.httpOutput.enabled=true --set falco.httpOutput.url=http://falcosidekick:2801 
```
are there configuring the format of events and the URL where Falco will send them. As Falco and Falcosidekick will be in the same namespace, we can directly use the name of the service (falcosidekick).
