First, we will put some working configuration files built for this course and place them under `/etc/falco`:

`sudo -s
mkdir /etc/falco
cp falco.yaml falco_rules.yaml /etc/falco
touch /var/log/falco_events.log`{{execute}}

As you can guess:

- `falco.yaml` configures the Falco service
- `falco_rules.yaml` contains the threat detection patterns
- `falco_events.log` will be used as the events log file.

Then, we can pull and launch the Falco container, mounting the configuration files we defined previously:

`docker pull falcosecurity/falco
docker run -d --name falco --privileged \
  -v /var/run/docker.sock:/host/var/run/docker.sock \
  -v /dev:/host/dev \
  -v /proc:/host/proc:ro \
  -v /boot:/host/boot:ro \
  -v /lib/modules:/host/lib/modules:ro \
  -v /usr:/host/usr:ro \
  -v /etc/falco/falco.yaml:/etc/falco/falco.yaml \
  -v /etc/falco/falco_rules.yaml:/etc/falco/falco_rules.yaml \
  -v /var/log/falco_events.log:/var/log/falco_events.log \
  falcosecurity/falco`{{execute}}

**Note: if you accidentally terminate the container or want to reload the configuration files, you can always `docker restart falco`{{execute}} from the host.**
