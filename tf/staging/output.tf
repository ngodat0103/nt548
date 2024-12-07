output "master-nodes-public-ip" {
  description = "Public IP of master nodes"
  value       = module.master-nodes.public-ips
}
output "worker-nodes-public-ip" {
  description = "Public IP of worker nodes"
  value       = module.worker-nodes.public-ips
}
output "internal-lb-ip" {
  description = "Internal LB IP"
  value       = module.master-nodes.internal-lb-ip
}