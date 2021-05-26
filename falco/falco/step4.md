Container immutability means that running containers are exactly the same, they don't have any changes in the software running from the image and any user data is in a externally mounted volume. Let's trigger an alarm when any process tries to write to a non data directory.

Let's install a new version of the configuration file for this example:

`sudo cp falco_rules_4.yaml /etc/falco/falco_rules.yaml`{{execute}}

Pay attention to the macro that defines the write-allowed directories that you customized for _Nginx_:

```yaml
- macro: user_data_dir
  condition: fd.name startswith /userdata or fd.name startswith /var/log/nginx or fd.name startswith /var/run/nginx or fd.name startswith /root or fd.name startswith /var/log/falco
```

The rule for this step is right below:

```yaml
- rule: Write to non user_data dir
  desc: attempt to write to directories that should be immutable
  condition: open_write and container and not user_data_dir
  output: "Writing to non user_data dir (user=%user.name command=%proc.cmdline file=%fd.name)"
  priority: ERROR
```

Let's take a look at the *open_write* macro used above:

```yaml
- macro: open_write
condition: (evt.type=open or evt.type=openat) and evt.is_open_write=true and fd.typechar='f'
```

These conditions are based on the Sysdig system call filters- In this case you filter `open` or `openat` system calls, open write mode, and for file descriptors that are files. If you want to learn more about Sysdig filters, take our [Sysdig: container troubleshooting and visibility](https://katacoda.com/sysdig/scenarios/sysdig-container-visibility) course or check out these [Sysdig examples](https://github.com/draios/sysdig/wiki/Sysdig-Examples).

To apply the new configuration file you will restart the Falco container:  
`docker restart falco`{{execute}}.

Now, you can spawn a new container and try this rule:

`docker run -d -P --name example3 nginx`{{execute}}

While this should trigger the rule:

`docker exec example3 touch /usr/foo`{{execute}}

This one shouldn't (excluded from the condition by `user_data_dir` macro):

```
mkdir /userdata
docker exec example3 touch /userdata/foo
```{{execute}}

Now look at the log file:

`cat /var/log/falco_events.log | grep "foo"`{{execute}}.

You will find this event:

```log
21:15:58.476945006: Error Writing to non user_data dir (user=root command=touch /usr/foo file=/usr/foo)
```

Falco detected an anomalous file write to `/usr`. You can define any particular macro following the same structure to get notified whenever a particular file/directory are opened.
