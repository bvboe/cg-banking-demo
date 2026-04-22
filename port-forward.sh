#!/usr/bin/env bash
# Port-forward the banking-app service. Ctrl-C to stop.
# Usage: ./port-forward.sh [namespace]  (default: banking-demo)
set -euo pipefail

NAMESPACE="${1:-banking-demo}"

echo "==> Port-forwarding banking-app in namespace '$NAMESPACE'"
echo "    http://localhost:8081"
echo ""
echo "==> Press Ctrl-C to stop."
kubectl port-forward svc/banking-app 8081:3000 -n "$NAMESPACE"
