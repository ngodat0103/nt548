output "master-nodes-public-ip" {
  description = "Public IP of master nodes"
  value       = module.master-nodes.public-ips
}
output "worker-nodes-public-ip" {
  description = "Public IP of worker nodes"
  value       = module.worker-nodes.public-ips
}
output "worker-nodes-elb-ip" {
  value = module.worker-nodes.worker-nodes-elb-ip
}

output "nfs-server-public-ip" {
  description = "Public IP of NFS server"
  value       = module.nfs-server.nfs-server-public-ip
}
output "nfs-server-internal-ip" {
  description = "Internal IP of NFS server"
  value       = module.nfs-server.nfs-server-internal-ip
}