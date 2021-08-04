#!/bin/bash

ssh root@host01 curl -Lo /root/falco_rules_4.yaml https://raw.githubusercontent.com/katacoda-scenarios/sysdig-scenarios/master/falco/sysdig-falco/assets/falco_rules_4.yaml
ssh root@host01 curl -Lo /root/falco_rules_5.yaml https://raw.githubusercontent.com/katacoda-scenarios/sysdig-scenarios/master/falco/sysdig-falco/assets/falco_rules_5.yaml

ssh root@host01 "echo 127.0.0.1 docker >> /etc/hosts"
