#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

switch_context

echo "Deploying to kind"
kubectl apply -f $(dirname "$0")/todo-deployment.yml
kubectl apply -f $(dirname "$0")/todo-service.yml

echo "Waiting for deployment to be available"
kubectl wait --for=condition=available deployment/"$DEPLOYMENT_NAME" -n "$NAMESPACE" --timeout=60s

echo "Port-forwarding service to localhost:8080"
kubectl port-forward service/"$SERVICE_NAME" 8080:80  -n "$NAMESPACE"
