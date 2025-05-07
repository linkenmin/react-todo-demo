#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

switch_context

echo "Deploying to EKS"
kubectl apply -f $(dirname "$0")/todo-deployment.yml
kubectl apply -f $(dirname "$0")/todo-service.yml

# wait for LoadBalancer hostname
echo "Waiting for external hostname..."
for i in {1..60}; do
  HOST=$(kubectl get svc "$SERVICE_NAME" -n "$NAMESPACE" -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  [[ -n "$HOST" ]] && break
  echo "  ($i/60) pending..."
  sleep 5
done

echo "Waiting for DNS to propagate for $HOST..."
for i in {1..60}; do
  # if dig returns an IPv4 address, DNS has propagated
  if dig +short "$HOST" | grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'; then
    echo "DNS resolved: $HOST -> $(dig +short $HOST)"
    break
  fi
  echo "  ($i/60) pending..."
  sleep 5
done

echo "Health check on http://$HOST ..."
for i in {1..60}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://$HOST")
  if [[ "$STATUS" =~ ^(200|301|302|304)$ ]]; then
    echo "Ready at $HOST"
    exit 0
  fi
  echo "  ($i/60) HTTP $STATUS"
  sleep 5
done

echo "Service not ready"
exit 1
