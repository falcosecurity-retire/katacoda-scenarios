# [Kubeless](https://kubeless.io/)

Kubeless is a Kubernetes-native Serverless Framework. You can use Kubeless to deploy your functions without worrying about the underlying infrastructure, and trigger them in response to events.

## Installing Kubeless

From the official [quick start](https://kubeless.io/docs/quick-start/) page:

`export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml`{{execute}}

After a few seconds, we can check that the controller is up and running:

`kubectl get pods -n kubeless`{{execute}}

```bash
NAME                                          READY   STATUS    RESTARTS   AGE
kubeless-controller-manager-99459cb67-tb99d   3/3     Running   3          2m34s
```
