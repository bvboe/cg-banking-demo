#!/usr/bin/env bash
# Build all service images for this branch and load them into kind.
set -euo pipefail

VERSION="v2"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Building images for $VERSION"

docker build -t "banking-app:$VERSION"      "$SCRIPT_DIR/services/banking-app"
docker build -t "banking-postgres:$VERSION" "$SCRIPT_DIR/services/banking-app/database"
docker build -t "banking-worker:$VERSION"   "$SCRIPT_DIR/services/banking-app/worker"

echo ""
echo "==> Loading images into kind"

for svc in banking-app banking-postgres banking-worker; do
  kind load docker-image "$svc:$VERSION" --name kind
done

echo ""
echo "==> Build + load complete for $VERSION"
