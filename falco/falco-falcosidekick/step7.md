# Testing our function

We start by creating a simple pod:

`kubectl run alpine -n default --image=alpine --restart='Never' -- sh -c "sleep 600"`{{execute}}

We check that it is running with:

`kubectl get pods -n default`{{execute}}

```bash
NAME     READY   STATUS    RESTARTS   AGE
alpine   1/1     Running   0          9s
```

Let's run a shell command inside and see what happens:

`kubectl exec -i --tty alpine -n default -- sh -c "uptime"`{{execute}}

```bash
23:44:25 up 1 day, 19:11,  load average: 0.87, 0.77, 0.77
```

As expected we got the result of our command, but, after a few minutes, if we get the status of the pod, we can see that is has been terminated:

`kubectl get pods -n default`{{execute}}

```bash
NAME     READY   STATUS        RESTARTS   AGE
alpine   1/1     Terminating   0          103s
```

## Forensics

We can check the logs of for the varios components to furtner investigate what happened.
(Wait one minute before running these commands)

For Falco:

`kubectl logs daemonset/falco -n falco | grep "Notice A shell"`{{execute}}

```bash
{"output":"23:39:44.834631763: Notice A shell was spawned in a container with an attached terminal (user=root user_loginuid=-1 k8s.ns=default k8s.pod=alpine container=5892b41bcf46 shell=sh parent=<NA> cmdline=sh terminal=34817 container_id=5892b41bcf46 image=<NA>) k8s.ns=default k8s.pod=alpine container=5892b41bcf46","priority":"Notice","rule":"Terminal shell in container","time":"2021-01-14T23:39:44.834631763Z", "output_fields": {"container.id":"5892b41bcf46","container.image.repository":null,"evt.time":1610667584834631763,"k8s.ns.name":"default","k8s.pod.name":"alpine","proc.cmdline":"sh","proc.name":"sh","proc.pname":null,"proc.tty":34817,"user.loginuid":-1,"user.name":"root"}}
```

For Falcosidekick:

`kubectl logs deployment/falcosidekick -n falco`{{execute}}

```bash
2021/01/14 23:39:45 [INFO]  : Kubeless - Post OK (200)
2021/01/14 23:39:45 [INFO]  : Kubeless - Function Response : 
2021/01/14 23:39:45 [INFO]  : Kubeless - Call Function "delete-pod" OK
```

(Notice, the function returns nothing, this is why the message log is empty)

For delete-pod function:

`kubectl logs deployment/delete-pod -n kubeless`{{execute}}

```bash
10.42.0.31 - - [14/Jan/2021:23:39:45 +0000] "POST / HTTP/1.1" 200 0 "" "Falcosidekick" 0/965744
Deleting pod "alpine" in namespace "default"
```
