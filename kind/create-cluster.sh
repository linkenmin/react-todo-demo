#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

echo "Creating kind cluster: $CLUSTER_NAME"
kind create cluster --name "$CLUSTER_NAME" --config "$(dirname "$0")/kind-config.yml"

switch_context
