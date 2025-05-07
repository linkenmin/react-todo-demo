#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

echo "Deleting kind cluster: $CLUSTER_NAME..."
kind delete cluster --name $CLUSTER_NAME
