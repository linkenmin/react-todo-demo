#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

IMAGE_NAME="react-todo-demo:latest"
echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "Loading image into kind"
kind load docker-image $IMAGE_NAME --name "$CLUSTER_NAME"
