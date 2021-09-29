Containers usually have a well defined set of mountpoints that rarely changes. If a container tries to mount a different host directory, or read/write a file outside of the allowed directory set, that means that either someone is trying to breakout the container, or a team member has been given excessive visibility to the container.

You will use a new version of the configuration file for this example:

`sudo cp falco_rules_5.yaml /etc/falco/falco_rules.yaml`{{execute}}

This is the rule that watches for sensitive mounts inside containers:

```yaml
- rule: Launch Sensitive Mount Container
  desc: >
    Detect the initial process started by a container that has a mount from a sensitive host directory
    (i.e. /proc). Exceptions are made for known trusted images.
  condition: >
    container_started and container
    and sensitive_mount
    and not falco_sensitive_mount_containers
    and not user_sensitive_mount_containers
  output: Container with sensitive mount started (user=%user.name user_loginuid=%user.loginuid command=%proc.cmdline %container.info image=%container.image.repository:%container.image.tag mounts=%container.mounts)
  priority: INFO
  tags: [container, cis, mitre_lateral_movement]
```

The macro `sensitive_mount` defines the _forbidden_ directories. By default it watches a set of mount points. For this exercise, the configuration file has been modified to include _/mnt_ as well (the last line).

```yaml
- macro: sensitive_mount
  condition: (container.mount.dest[/proc*] != "N/A" or
              container.mount.dest[/var/run/docker.sock] != "N/A" or
              container.mount.dest[/var/run/crio/crio.sock] != "N/A" or
              container.mount.dest[/var/lib/kubelet] != "N/A" or
              container.mount.dest[/var/lib/kubelet/pki] != "N/A" or
              container.mount.dest[/] != "N/A" or
              container.mount.dest[/home/admin] != "N/A" or
              container.mount.dest[/etc] != "N/A" or
              container.mount.dest[/etc/kubernetes] != "N/A" or
              container.mount.dest[/etc/kubernetes/manifests] != "N/A" or
              container.mount.dest[/root*] != "N/A" or
              container.mount.dest[/mnt*] != "N/A")
```

To apply the new configuration file, restart the Falco container: `docker restart falco`{{execute}}.

Now, you can spawn a new container and try to mount `/mnt`:

`docker run -d -P --name example4 -v /mnt:/tmp/mnt alpine`{{execute}}

If you look at the falco events log file with `tail /var/log/falco_events.log`{{execute}} you will be able to read:

```yaml
08:51:21.945674576: Notice Container with sensitive mount started (user=root user_loginuid=0 command=container:bec1e29f8d85 example4 (id=bec1e29f8d85) image=alpine:latest mounts=/mnt:/tmp/mnt::true:rprivate)
```

The Falco notification shows that it detected a sensitive mount.
