The fist example is an easy one: detecting an attacker running an interactive shell in any of your containers. This alert is included in the default rule set. Let's trigger it first, and then you can look the rule definition.

Run any container on your Docker host, _Nginx_ for example:

`docker run -d -P --name example1 nginx`{{execute}}

`docker ps`{{execute}}

Now spawn an interactive shell:

`docker exec -it example1 bash`{{execute}}

You can play around a little if you want, then execute `exit`{{execute}} to leave the container shell.

## Log event

If you tail the log file with `tail /var/log/falco_events.log`{{execute}} you should be able to read:

```log
17:13:24.357351845: Notice A shell was spawned in a container with an attached terminal (user=root example1 (id=604aa46610dd) shell=bash parent=<NA> cmdline=bash terminal=34816)
```

## The rule: terminal shell in container

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

## Anatomy of a rule definition

This is a rather complex rule, don't worry if you don't fully understand every section at this moment. You can identify:

- Rule name, 
- Description,
- Trigger conditions, 
- Event output (with context aware variables like `%proc.name` or `%container.info`),
- Priority and
- Tags.
