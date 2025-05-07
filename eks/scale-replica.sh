#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <replica-count>"
  exit 1
fi

switch_context

echo "Scaling $DEPLOYMENT_NAME to $1 replicas"
kubectl scale deployment/"$DEPLOYMENT_NAME" --replicas="$1" -n "$NAMESPACE"
kubectl get deployment/"$DEPLOYMENT_NAME" -n "$NAMESPACE"
