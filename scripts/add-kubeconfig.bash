#!/bin/bash

kubeconfig_path="$(pwd)/configs/config"

if [[ "$KUBECONFIG" == *"$kubeconfig_path"* ]]; then
    echo "$kubeconfig_path is already in KUBECONFIG, nothing to do."
else
    echo "$kubeconfig_path is not in KUBECONFIG, adding it now."
    export KUBECONFIG="$KUBECONFIG:$kubeconfig_path"

    echo ""
    echo "To use the newly added context, run:"
    echo "kubectl config use-context kubernetes-admin@kubernetes"
fi
