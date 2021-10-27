Docker best practices recommend running just one main process per container. This has a significant security impact because you know exactly which processes you expect to see running.

For example, the _nginx_ containers should only be executing the `nginx` process. Anything else is an indicator of an anomaly.

You will use a new version of the configuration file for this example:

`sudo cp falco_rules_3.yaml /etc/falco/falco_rules.yaml`{{execute}}

Now, pay attention to the following rule at the end of the file:

```yaml
# Our nginx containers should only be running the 'nginx' process
- rule: Unauthorized process on nginx containers
  desc: There is a process running in the nginx container that is not described in the template
  condition: spawned_process and container and container.image startswith nginx and not proc.name in (nginx)
  output: Unauthorized process (%proc.cmdline) running in (%container.id)
  priority: WARNING
```

Let's dissect the conditions for this rule:

- `spawned_process` (a macro: a new process was executed (execve-ed) succesfully)
- `container` (a macro: the namespace where it was executed belongs to a container and not the host)
- `container.image startswith nginx` (container property: the container image name must start with _nginx_)
- `not proc.name in (nginx)` (process property: the process name cannot be `nginx`)

To apply the new configuration file you will restart the Falco container: `docker restart falco`{{execute}}.

Next, run a new _nginx_ container:

`docker run -d -P --name example2 nginx`{{execute}}

Then, execute any command in the `example2` container, `ls` for example:

`docker exec -it example2 ls`{{execute}}

If you look at the falco events log file with `tail /var/log/falco_events.log | grep "Unauthorized process (ls)"`{{execute}} you will be able to read:

```log
08:48:54.096496481: Warning Unauthorized process (ls) running in (e4b2097bbf15)
```

Good catch! The Falco notification shows that it recognized an unexpected process.
