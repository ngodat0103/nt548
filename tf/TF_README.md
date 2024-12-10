
# Terraform Configuration for Kubernetes Cluster

## Overview
This Terraform project automates the deployment of a scalable Kubernetes cluster, integrating master nodes, worker nodes, and an NFS server for shared storage. The setup ensures that all components are interconnected and configured to provide a robust and resilient infrastructure for containerized applications.

## Modules Description
- **Master Nodes**: This module provisions the Kubernetes master nodes, which manage and orchestrate the entire cluster. It includes configurations for network settings, security groups, and master-specific parameters.
- **Worker Nodes**: Sets up the worker nodes that host the application containers. It configures network connections to the master nodes and the NFS server, ensuring communication and storage access.
- **NFS Server**: Deploys an NFS server to provide persistent network storage accessible by both master and worker nodes, crucial for stateful applications that require persistent data.

## Project Structure
- `modules/`: Contains the core infrastructure modules used in the Kubernetes cluster setup.
  - `master-nodes/`: Configuration for master nodes.
  - `worker-nodes/`: Configuration for worker nodes.
  - `nfs-server/`: Configuration for the NFS server.
- `scripts/`: Contains scripts to assist in deployment and management tasks.
- `staging/`: Holds configurations specific to the staging environment.

## Prerequisites
- Terraform v0.14 or higher.
- Access to a cloud provider account (e.g., AWS, Azure, GCP).
- Kubernetes command-line tool (kubectl) installed on your local machine.

## Deployment Steps
1. **Initialize Terraform**:
   Navigate to the `tf` directory and run:
   ```bash
   terraform init
   ```
2. **Plan and apply Terraform configuration**:
   Review the deployment plan:
   ```bash
   terraform plan
   ```
   Execute the plan to start the deployment:
   ```bash
   terraform apply
   ```

## Configuration Details
Detailed descriptions of the configurations within each module are available in their respective directories, providing insights into the specific resources and settings employed.

## Networking Diagram
Refer to the network diagram provided to understand how the components are interconnected within the cluster.

## Additional Resources
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Terraform by HashiCorp](https://www.terraform.io/docs)

## Contributors
- **Your Name** - _Initial work_ - [Your GitHub](https://github.com/yourusername)
