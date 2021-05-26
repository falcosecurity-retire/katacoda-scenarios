Containers usually have a well defined set of mountpoints that rarely changes. If a container tries to mount a different host directory, or read/write a file outside of the allowed directory set, that means that either someone is trying to breakout the container, or a team member has been given excessive visibility to the container.

Let's install a new version of the configuration file for this example:

`sudo cp falco_rules_5.yaml /etc/falco/falco_rules.yaml`{{execute}}

This is the rule that watches for sensitive mounts inside containers:

```yaml
- rule: Launch Sensitive Mount Container
  desc: >
    Detect the initial process started by a container that has a mount from a sensitive host directory
    (i.e. /proc). Exceptions are made for known trusted images.
  condition: evt.type=execve and proc.vpid=1 and container and sensitive_mount and not trusted_containers
  output: Container with sensitive mount started (user=%user.name command=%proc.cmdline %container.info)
  priority: INFO
  tags: [container, cis]
```

The macro `sensitive_mount` includes the _forbidden_ directories. By default it just watches _/proc_ but in our configuration file it has been modified to include _/mnt_ as well.

```yaml
- macro: sensitive_mount
  condition: (container.mount.dest[/proc*] != "N/A" or container.mount.dest[/mnt*] != "N/A")
```

To apply the new configuration file you will restart the Falco container: `docker restart falco`{{execute}}.

Now, you can spawn a new container and try to mount `/mnt`:

`docker run -d -P --name example4 -v /mnt:/tmp/mnt alpine`{{execute}}

If you look at the log with `tail /var/log/falco_events.log`{{execute}} you will be able to read:

```yaml
13:32:41.070491862: Notice Container with sensitive mount started (user=root command=sh -g daemon off; example4 (id=c46fa3bf0651))
```

The Falco notification shows that it detected a sensitive mount.
