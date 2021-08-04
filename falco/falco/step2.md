Our fist example is an easy one: detecting an attacker running an interactive shell in any of your containers. This alert is included in the default rule set. Let's trigger it first, and then we can look the rule definition.

Run any container on your Docker host, _Nginx_ for example:

`docker run -d -P --name example1 nginx`{{execute}}

`docker ps`{{execute}}

Now spawn an interactive shell:

`docker exec -it example1 bash`{{execute}}

You can play around a little if you want, then execute `exit`{{execute}} to leave the container shell.

If we tail the log file with `tail /var/log/falco_events.log`{{execute}} we should be able to read:

```log
17:13:24.357351845: Notice A shell was spawned in a container with an attached terminal (user=root example1 (id=604aa46610dd) shell=bash parent=<NA> cmdline=bash terminal=34816)
```

This is the specific `/etc/falco/falco_rules.yaml` rule that fired the event:

```yaml
- rule: Terminal shell in container
  desc: A shell was spawned by a program in a container with an attached terminal.
  condition: >
    spawned_process and container
    and shell_procs and proc.tty != 0
  output: "A shell was spawned in a container with an attached terminal (user=%user.name %container.info shell=%proc.name parent=%proc.pname cmdline=%proc.cmdline terminal=%proc.tty)"
  priority: NOTICE
  tags: [container, shell]
```

This is a rather complex rule, don't worry if you don't fully understand every section at this moment. We can identify a rule name, description, some trigger conditions, event output with some context-aware variables provided by Falco like `%proc.name` or `%container.info`, the priority and some tags.
