#!/bin/bash
# delete namespace which terminated 

if [ -z "$1" ]; then
    echo "Usage: $0 <namespace>"
    echo "Example: $0 prod-demo"
    exit 1
fi

NS=$1

echo "Namespace '$NS' will be deleted"

kubectl get namespace $NS -o json \
  | jq 'del(.spec.finalizers)' \
  | kubectl replace --raw "/api/v1/namespaces/$NS/finalize" -f -

if [ $? -eq 0 ]; then
  echo "✅ Namespace '$NS' deleted successfully."
else
  echo "❌ Namespace '$NS' deletion failed."
fi