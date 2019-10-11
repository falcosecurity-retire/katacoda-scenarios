We will create the same three pods (client, mysql, ping) as in our previous scenario.  As you might remember:

- The `mysql` pod hosts a database of users and passwords.
- The `ping` pod hosts a form written in PHP, which allows authenticated users to ping a machine.
- We will use the `client` pod to send HTTP requests to `ping`'s web server.

![Topology](/sysdig/courses/falco/forensics-k8s/assets/01b_topology.png)

`cd
kubectl create namespace ping
kubectl create -f mysql-deployment.yaml --namespace=ping
kubectl create -f mysql-service.yaml --namespace=ping
kubectl create -f ping-deployment.yaml --namespace=ping
kubectl create -f ping-service.yaml --namespace=ping
kubectl create -f client-deployment.yaml --namespace=ping`{{execute}}

As usual, we make sure the pods are ready (it may take one or two minutes):

`kubectl get pods -n ping`{{execute}}

If we open a shell in a container,

`kubectl -n ping -it exec client /bin/bash
ls
exit`{{execute}}

the playbook created in the previous step will delete that Pod.  We can check it running

`kubectl -n ping get pods`{{execute}}

In a production environment we should probably be using deployments or ReplicaSets, so that a new Pod is created.  Here we can do it manually:

`kubectl create -f ~/client-deployment.yaml --namespace=ping`{{execute}}
