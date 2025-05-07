#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

echo "Deleting EKS cluster: $CLUSTER_NAME..."
eksctl delete cluster --name $CLUSTER_NAME --region $REGION
