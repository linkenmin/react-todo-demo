#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

switch_context

echo "Deleting deployment $DEPLOYMENT_NAME and service $SERVICE_NAME"
kubectl delete deployment/"$DEPLOYMENT_NAME" -n "$NAMESPACE" || true
kubectl delete service/"$SERVICE_NAME" -n "$NAMESPACE" || true

echo "\nRemaining deployments:"
kubectl get deployment -n "$NAMESPACE"

echo "\nRemaining services:"
kubectl get service -n "$NAMESPACE"
