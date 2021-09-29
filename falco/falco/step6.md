Falco has a synthetic event generator that shows off all the capabilities of the default ruleset. This is great to fully understand all the capabilities of Falco.

Launch the event generator:

`docker run -d --name falco-event-generator falcosecurity/falco-event-generator`{{execute}}

If you look at the falco events log file with `tail -f /var/log/falco_events.log`{{execute}} you'll see lots of suspicious activity detected, as that container simulates all sorts of typicall container break-in and break-out attempts:

```log
08:52:25.680786700: Error Directory below known binary directory created (user=root user_loginuid=-1 command=event_generator directory=/bin/directory-created-by-event-generator-sh container_id=9236f8202932 image=falcosecurity/falco-event-generator)
08:52:26.681135198: Error File below known binary directory renamed/removed (user=root user_loginuid=-1 command=event_generator pcmdline=docker-entrypoi /docker-entrypoint.sh operation=rename file=<NA> res=0 oldpath=/bin/true newpath=/bin/true.event-generator-sh  container_id=9236f8202932 image=falcosecurity/falco-event-generator)
08:52:26.681167399: Error File below known binary directory renamed/removed (user=root user_loginuid=-1 command=event_generator pcmdline=docker-entrypoi /docker-entrypoint.sh operation=rename file=<NA> res=0 oldpath=/bin/true.event-generator-sh newpath=/bin/true  container_id=9236f8202932 image=falcosecurity/falco-event-generator)
08:52:27.681639333: Notice Unexpected setuid call by non-sudo, non-root program (user=bin user_loginuid=-1 cur_uid=2 parent=event_generator command=event_generator uid=root container_id=9236f8202932 image=falcosecurity/falco-event-generator)
...
```
