We have set up a Kubernetes cluster just for you.  
On the right you can see the terminal of the `master` node, from which you can interact with the cluster using the `kubectl` tool, which is already configured.

For instance, you can get the details of the cluster executing `kubectl cluster-info`{{execute}}

You can view the nodes in the cluster with the command `kubectl get nodes`{{execute}}

You should see 2 nodes: one master and a worker.

Check that you are admin: `kubectl auth can-i create node`{{execute}}

You can view the current status of our cluster using the command `kubectl get pod -n kube-system`{{execute}}
