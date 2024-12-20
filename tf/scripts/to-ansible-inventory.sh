#!/bin/bash

# Input JSON file
terraform output -json > tf-output.json
JSON_FILE="tf-output.json"

# Extract master node public IPs
MASTER_NODES_IP=$(jq -r '."master-nodes-public-ip".value[][][]' "$JSON_FILE")

# Extract worker nodes public IPs
WORKER_NODES_IP=$(jq -r '."worker-nodes-public-ip".value[][][]' "$JSON_FILE")
NFS_SERVER_IP=$(jq -r '."nfs-server-public-ip".value' "$JSON_FILE")

# Define inventory file
INVENTORY_FILE="../../ansible/inventory/k8s-cluster.ini"

# Create Ansible inventory
{
  echo "[master-nodes]"
  for ip in $MASTER_NODES_IP; do
    echo "$ip"
  done

  echo ""
  echo "[worker-nodes]"
  for ip in $WORKER_NODES_IP; do
    echo "$ip"
  done
  echo "[nfs-server]"
  echo "$NFS_SERVER_IP"
} > "$INVENTORY_FILE"

# Output the created inventory file
echo "Ansible inventory file created: $INVENTORY_FILE"
cat "$INVENTORY_FILE"
