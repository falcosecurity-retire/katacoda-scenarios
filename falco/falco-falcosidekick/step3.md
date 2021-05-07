_[Kubeless](https://kubeless.io/)_ is a Kubernetes-native Serverless Framework. You can use Kubeless to deploy your functions without worrying about the underlying infrastructure, and trigger them in response to events.

Deploy Kubeless in Kubernetes
-----------------------------

Next let's create a `kubeless` namespace and deploy the latest release of kubeless.

`kubectl create ns kubeless
export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml`{{execute}}

You can see:

- the pods created:  
  `kubectl get pods -n kubeless`{{execute}}
- the deployment:  
  `kubectl get deployment -n kubeless`{{execute}}
- and the `functions` [Custom Resource Definition](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/):  
  `kubectl get customresourcedefinition`{{execute}}

Local kubeless command line
---------------------------

Finally, install the Kubeless CLI:

`export OS=$(uname -s| tr '[:upper:]' '[:lower:]')
curl -OL https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless_$OS-amd64.zip
unzip kubeless_$OS-amd64.zip
sudo mv bundles/kubeless_$OS-amd64/kubeless /usr/local/bin/`{{execute}}
