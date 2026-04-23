#!/usr/bin/env bash
# Deploy this branch's manifest into a namespace.
# Usage: ./deploy.sh [namespace]  (default namespace: banking-demo)
set -euo pipefail

VERSION="v2"
NAMESPACE="${1:-banking-demo}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/k8s/manifest.yaml"

if [[ ! -f "$MANIFEST" ]]; then
  echo "Manifest not found: $MANIFEST" >&2
  exit 1
fi

echo "==> Deploying $VERSION to namespace '$NAMESPACE'"

sed "s/__NAMESPACE__/$NAMESPACE/g" "$MANIFEST" | kubectl apply -f -

echo ""
echo "==> Waiting for rollouts..."
kubectl rollout status statefulset/banking-postgres -n "$NAMESPACE" --timeout=180s
kubectl rollout status deployment/banking-app       -n "$NAMESPACE" --timeout=300s
kubectl rollout status deployment/banking-worker    -n "$NAMESPACE" --timeout=120s

echo ""
echo "==> $VERSION deployed to '$NAMESPACE'. Use ./port-forward.sh $NAMESPACE to reach services."
