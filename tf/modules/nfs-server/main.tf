resource "google_compute_address" "nfs-server-ip" {
  name         = "${var.name}-internal-ip"
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = var.subnetwork
}
resource "google_compute_address" "nfs-server-public-ip" {
  name         = "${var.name}-public-ip"
  region       = var.region
  address_type = "EXTERNAL"
}


resource "google_compute_instance" "nfs-server-instance" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.nfs-server-tags
  labels = {
    environment = var.environment
  }
  boot_disk {
    initialize_params {
      image = var.image
      size = var.boot_disk_size
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = google_compute_address.nfs-server-ip.address
    access_config {
      nat_ip = google_compute_address.nfs-server-public-ip.address
    }
  }

  metadata = {
    ssh-keys =  join("\n",[for path in var.pub_key_paths : "k8s-admin:${file(path)}"])
  }
  metadata_startup_script = <<-EOT
    #!/bin/bash
    useradd -m -s /bin/bash datnvm
    echo "k8s-admin:k8s-admin" | chpasswd
    usermod -aG sudo k8s-admin
  EOT
}