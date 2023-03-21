#!/usr/bin/env bash

for ((m=1;m<=1;m++)); do
    kubectl delete deployment perf-deployment -n demo --grace-period=0
    read -p "waiting for 240 seconds for deployment to delete" -t 240
    kubectl rollout restart deployment ratify
    read -p "waiting for 240 seconds for rollout to restart" -t 240
    # kubectl wait --for delete pod --selector=<label>=<value>
    # kubectl apply -f 5sigs100subjects.yaml
    kubectl apply -f 20jobs1parallel40containers.yaml
    read -p "waiting for 10 seconds for operations to complete" -t 10
    kubectl logs deployment/ratify -n default | grep -m 1 -o "mutation: execution time for request: [0-9]*ms" | grep -o "[0-9]*"
    kubectl logs deployment/ratify -n default | grep -m 1 -o "verification: execution time for request: [0-9]*ms" | grep -o "[0-9]*"
done