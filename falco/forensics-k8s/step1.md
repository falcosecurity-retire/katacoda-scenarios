A Kubernetes cluster has been set up just for you. On the right, you can see the terminal of the `master` node, from which you can interact with the cluster using the `kubectl` (already configured).

For instance, you can get the details of the cluster executing `kubectl cluster-info`{{execute}}

You can view the nodes in the cluster with the command `kubectl get nodes`{{execute}}. You should see 2 nodes: a master and a worker.

You can view the current status of the cluster using the command `kubectl get pod -n kube-system | grep -v katacoda`{{execute}}. Make sure that all the pods are in `Running` state. Othewise, wait a few moments and try again.
