
# Ansible Configuration for Kubernetes Cluster Setup

## Overview
This documentation outlines the use and structure of Ansible playbooks and configurations used to deploy and manage a Kubernetes cluster. Ansible is utilized to automate the setup of Kubernetes dependencies, cluster configuration, NFS storage setup, and resource initialization.

## Project Structure
The `ansible` directory contains several key files and subdirectories:

### YAML Files
- **0-k8s-deps.yaml**: Installs Kubernetes dependencies necessary for the cluster.
- **1-setup-cluster.yaml**: Configures and sets up the Kubernetes cluster.
- **100-k8s-reset.yaml**: Resets or tears down the Kubernetes cluster to a clean state.
- **2-setup-nfs.yaml**: Sets up NFS (Network File System) for the cluster to provide persistent storage solutions.
- **3-install-nfs-retain-sc.yaml**: Installs NFS server and configures a Storage Class in Kubernetes that retains data.
- **4-k8s-resource-init.yaml**: Initializes resources in the Kubernetes cluster to ensure they are ready for use.

### Configuration and Script Files
- **ansible.cfg**: Contains configuration settings for Ansible, defining defaults and behavioral aspects of playbook execution.
- **clear-key.sh**: Bash script to clear SSH keys, useful in resetting or reconfiguring access.
- **inventory**: Defines the hosts and their groupings for Ansible, crucial for targeting specific machines during playbook execution.
- **group_vars**: Directory that contains variable definitions for different groups, allowing for customized playbook runs based on group-specific variables.

### Miscellaneous Files
- **.gitignore**: Specifies intentionally untracked files to ignore.
- **readme.md**: Provides basic information or instructions about the Ansible configurations (not detailed here).
- **Vagrantfile**: Used to configure Vagrant environments, typically for local development and testing of the Ansible playbooks.

## Usage
To use these playbooks and configurations:
1. **Ensure Ansible is installed** on your system or the control node.
2. **Configure the inventory file** to reflect your environment's host setup and groupings.
3. **Run the playbooks** in the order specified, adjusting any variables in `group_vars` as necessary.

## Troubleshooting
- Check Ansible outputs and logs if you encounter issues during playbook execution.
- Ensure all hosts are accessible via SSH and the control machine has the necessary permissions to execute commands on remote hosts.

## Additional Resources
- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
