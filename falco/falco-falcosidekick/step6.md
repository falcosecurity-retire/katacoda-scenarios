You can subscribe a Kubeless function (_playbook_) to a NATS queue, so the function will be invoked for every message in the queue.

Delete Offending Pod
--------------------

Our first playbook will respond to an incident directly killing the Pod that triggered the security alert. This is done connecting to the Kubernetes API and deleting that Pod.

`cd ~/kubernetes-response-engine/playbooks
./deploy_playbook -p delete -s "falco.notice.terminal_shell_in_container"`{{execute}}

This deploys the Kubeless function that subscribes to the NATS "falco.notice.terminal_shell_in_container" topic.

To see whether the function is ready we execute
`kubeless function ls falco-delete | head`{{execute}}

Taint a Node and Stop Scheduling
--------------------------------

A very interesting response would be to put aside the node where the offending container was running, so nothing else is scheduled there. You can assign flags ([taints and tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/)) to the Kubernetes node where the alert originated to achieve different effects.

`./deploy_playbook -p taint -s "falco.notice.contact_k8s_api_server_from_container"`{{execute}}

We can pass several paraments with the option `-e`:

- `TAINT_KEY`: This is the taint key. Default value: `falco/alert`
- `TAINT_VALUE`: This is the taint value. Default value: `true`
- `TAINT_EFFECT`: This is the taint effect. Default value: `NoSchedule`

In the example, as we are executing it without parameters, it will use the default taint `falco/alert=true:NoSchedule` so no news Pods will be scheduled in this node unless they can tolerate that specific taint. You can use a more aggressive approach and set `-e TAINT_EFFECT=NoExecute`, which will drain the affected node.

After raising the event, we would see one of our nodes got tainted:

`kubectl describe node | grep Taint`{{execute}}
