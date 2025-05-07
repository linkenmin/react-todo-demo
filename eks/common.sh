#!/bin/bash
set -e

# Namespace and resource names for EKS
NAMESPACE="default"
DEPLOYMENT_NAME="react-todo-deployment"
SERVICE_NAME="react-todo-service"
CLUSTER_NAME="eks-react-todo"
REGION="ap-southeast-2"

# Switch to the first context matching eks-react-todo
function switch_context() {
  CTX=$(kubectl config get-contexts -o name | grep eks-react-todo | head -n1)
  if [[ -z "$CTX" ]]; then
    echo "ERROR: no EKS context matching 'eks-react-todo'"
    exit 1
  fi
  echo "Switching to EKS context: $CTX"
  kubectl config use-context "$CTX"
}
