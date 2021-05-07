#!/bin/bash

while ! kubectl get pods -n kube-system | grep tiller | grep Running &> /dev/null; do
    echo "Please wait while the environment is set up..."
    sleep 4
done
echo "The environment is ready!"
