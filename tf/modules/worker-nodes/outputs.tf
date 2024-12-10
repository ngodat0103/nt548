output "public-ips" {
  description = "Public IP of worker nodes"
  value       = google_compute_instance.k8s-worker-instances[*].network_interface[*].access_config[*].nat_ip
}
output "worker-nodes-elb-ip" {
  description = "Worker nodes LB IP"
  value       = module.gce-lb-http.external_ip
}