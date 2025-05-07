#!/bin/bash
set -e

# Namespace and resource names for kind
NAMESPACE="default"
DEPLOYMENT_NAME="react-todo-deployment"
SERVICE_NAME="react-todo-service"
CLUSTER_NAME="kind-react-todo"

# Switch to the kind context for this cluster
function switch_context() {
  CTX="kind-${CLUSTER_NAME}"
  echo "Switching to kind context: $CTX"
  kubectl config use-context "$CTX"
}
