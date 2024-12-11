## How to Add the Local Cluster to K8s Config

The `add-kubeconfig.bash` script adds a custom Kubernetes configuration file to the `KUBECONFIG` environment variable if it isn't already included.

### Prerequisites
- A Bash-compatible shell.
- Kubernetes configuration file located at `./configs/config` (relative to the project root, which is generated after running `vagrant up`).

### How to Use

1. **Run the script**:
   To add the custom Kubernetes config to the `KUBECONFIG` environment variable, run:

   ```bash
   source scripts/add-kubeconfig.bash

### What it does:
- The script checks if the Kubernetes config at `./configs/config` is already included in the `KUBECONFIG` environment variable.
- If it's not already present, it appends the path to `KUBECONFIG`.
- If it is present, it outputs a message saying nothing needs to be done.
