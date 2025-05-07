#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REPO_NAME="react-todo-demo"
IMAGE_TAG="latest"
ECR_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG"

echo "Logging in to AWS ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

echo "Building Docker image: $ECR_URI"
docker build --platform linux/amd64 -t "$ECR_URI" .

echo "Pushing image to ECR: $ECR_URI"
docker push "$ECR_URI"
