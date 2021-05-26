#!/bin/bash

wait.sh

#install Helm 3 and sysdig-agent ns
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm version
helm repo update