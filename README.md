
# Kubernetes Infrastructure Deployment

## Overview
This project automates the deployment and configuration of a Kubernetes cluster using Terraform and Ansible. Terraform is used to provision the underlying infrastructure required for a Kubernetes environment, such as virtual machines, networking, and storage solutions. Ansible is utilized to configure these resources, ensuring the cluster is set up with the necessary dependencies and configurations.

### Project Structure
- **Terraform (`/tf`)**: Contains the Terraform modules, scripts, and environment-specific configurations to provision the infrastructure.
- **Ansible (`/ansible`)**: Includes playbooks and scripts to configure the Kubernetes cluster, set up network file storage (NFS), and initialize Kubernetes resources.

## Getting Started

### Prerequisites
- Terraform v0.14+
- Ansible 2.9+
- Access to a cloud provider account (e.g., AWS, GCP, Azure) for infrastructure provisioning
- Kubernetes command-line tool (kubectl) installed on your local machine

### Deployment Steps

1. **Initialize Terraform**:
   - Navigate to the `tf` directory.
   - Run `terraform init` to initialize the environment.

2. **Apply Terraform Configuration**:
   - Execute `terraform plan` to review the changes that will be made.
   - Apply the configuration with `terraform apply`.

3. **Configure Kubernetes with Ansible**:
   - Navigate to the `ansible` directory.
   - Update the `inventory` file to match your environment.
   - Run the playbooks in sequence:
     ```bash
     ansible-playbook 0-k8s-deps.yaml
     ansible-playbook 1-setup-cluster.yaml
     # Continue with other playbooks as necessary
     ```

### Configuration Details
- **Terraform Modules**: Located in `/tf/modules`, these modules are reusable pieces that define various parts of the infrastructure.
- **Ansible Playbooks**: Each playbook in the `/ansible` directory is targeted at a specific part of the cluster setup process, from installing dependencies to initializing resources.

## Troubleshooting
- Ensure all prerequisites are met and credentials are correctly configured before starting the deployment.
- For errors during Terraform apply, check the output for specific error messages.
- Ansible errors are usually detailed; check the output and correct any issues with host connectivity or permissions.

## Additional Resources
- Terraform documentation: [Terraform Docs](https://www.terraform.io/docs)
- Ansible documentation: [Ansible Docs](https://docs.ansible.com/ansible/latest/index.html)

## Contributors
- **Your Name** - _Initial work_ - [Ngodat0103](https://github.com/ngodat0103)
