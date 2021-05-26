Falco has a synthetic event generator that shows off all the capabilities of the default ruleset. This is great to fully understand all the capabilities of Falco.

Let's pull and launch the event generator:

`docker pull falcosecurity/falco-event-generator
docker run -d --name falco-event-generator falcosecurity/falco-event-generator`{{execute}}

If you look at the log with `tail -f /var/log/falco_events.log`{{execute}} you'll see lots of suspicious activity detected, as that container simulates all sorts of typicall container break-in and break-out attempts:

```log
19:00:55.362191761: Error File created below /dev by untrusted program (user=root command=event_generator  file=/dev/created-by-event-generator-sh)
19:00:56.365043165: Notice Database-related program spawned process other than itself (user=root program=sh -c ls > /dev/null parent=mysqld)
19:00:57.367928872: Warning Sensitive file opened for reading by non-trusted program (user=root name=event_generator command=event_generator  file=/etc/shadow)
19:00:59.370589147: Error File below known binary directory renamed/removed (user=root command=event_generator  operation=rename file=<NA> res=0 oldpath=/bin/true newpath=/bin/true.event-generator-sh )
...
```
