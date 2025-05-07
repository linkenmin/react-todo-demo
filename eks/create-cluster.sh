#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

NODE_TYPE="t3.medium"
NODE_COUNT=2

echo "Creating EKS cluster: $CLUSTER_NAME"
eksctl create cluster \
  --name "$CLUSTER_NAME" \
  --region "$REGION" \
  --nodes "$NODE_COUNT" \
  --node-type "$NODE_TYPE" \
  --with-oidc \
  --managed

echo "Updating kubeconfig for $CLUSTER_NAME"
aws eks update-kubeconfig --name "$CLUSTER_NAME" --region "$REGION"
