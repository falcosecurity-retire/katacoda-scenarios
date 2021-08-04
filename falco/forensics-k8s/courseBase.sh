#!/bin/bash

launch.sh

curl -Lo /tmp/helm-linux-amd64.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz
tar zxf /tmp/helm-linux-amd64.tar.gz -C /tmp/
chmod a+x /tmp/linux-amd64/helm
sudo mv /tmp/linux-amd64/helm /usr/local/bin

kubectl create -f helm-account.yaml
helm init --service-account tiller
helm repo update
