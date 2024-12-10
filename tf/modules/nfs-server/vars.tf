variable "name" {
  description = "The name"
  type        = string
}
variable "machine_type" {
  description = "Machine type for instances"
  type        = string
  default     = "e2-medium"
}
variable "zone" {
  description = "Zone for instances"
  type        = string
}

variable "environment" {
  description = "Environment for instances"
  type        = string
}
variable "image" {
  description = "Image for instances"
  type        = string
  default     = "ubuntu-2204-jammy-v20240927"
}
variable "pub_key_paths" {
  description = "Path to public key"
  type        = list(string)
}
variable boot_disk_size {
  description = "Size of boot disk"
  type        = number
  default     = 30
}
variable "network" {
  description = "Network for instances"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork "
  type        = string
}
variable "region" {
  description = "Region for the master load balancer"
  type        = string
}
variable "project_id" {
  description = "The project ID"
  type        = string
}
variable "nfs-server-tags" {
    type = set(string)
    description = ""
}

