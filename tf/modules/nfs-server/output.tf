output "nfs-server-public-ip" {
  value = google_compute_address.nfs-server-public-ip.address
}
output "nfs-server-internal-ip" {
  value = google_compute_address.nfs-server-ip.address
}