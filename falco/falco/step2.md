In this fist exercise, you will detect an attacker running an interactive shell in any of your containers. This alert is included in the default rule set. Let's trigger it first, and then you can look the rule definition.

Run any container on your Docker host, _nginx_ for example:

`docker run -d -P --name example1 nginx`{{execute}}

`docker ps`{{execute}}

Now spawn an interactive shell:

`docker exec -it example1 bash`{{execute}}

You can play around a little if you want, then execute `exit`{{execute}} to leave the container shell.

## Log event

If you tail the log file with `tail /var/log/falco_events.log | grep "A shell was spawned"`{{execute}} you should be able to read:

```log
08:46:43.798834868: Notice A shell was spawned in a container with an attached terminal (user=root user_loginuid=-1 example1 (id=07b87bc077d1) shell=bash parent=runc cmdline=bash terminal=34816 container_id=07b87bc077d1 image=nginx)
```

## The rule: terminal shell in container

This is the specific `/etc/falco/falco_rules.yaml` rule that fired the event:

```yaml
- rule: Terminal shell in container
  desc: A shell was used as the entrypoint/exec point into a container with an attached terminal.
  condition: >
    spawned_process and container
    and shell_procs and proc.tty != 0
    and container_entrypoint
    and not user_expected_terminal_shell_in_container_conditions
  output: >
    A shell was spawned in a container with an attached terminal (user=%user.name user_loginuid=%user.loginuid %container.info
    shell=%proc.name parent=%proc.pname cmdline=%proc.cmdline terminal=%proc.tty container_id=%container.id image=%container.image.repository)
  priority: NOTICE
  tags: [container, shell, mitre_execution]
```

## Anatomy of a rule definition

This is a rather complex rule, don't worry if you don't fully understand every section at this moment. You can identify:

- Rule name
- Description
- Trigger conditions
- Event output (with context aware variables like `%proc.name` or `%container.info`)
- Priority
- Tags
