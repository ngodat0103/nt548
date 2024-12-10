provider "google" {
  credentials = file("~/.config/gcloud/application_default_credentials.json")
  project     = var.project_id
  region      = "asia-southeast1"
  zone        = "asia-southeast1-a"
}
locals {
  master-node-region = "asia-southeast1"
  worker-node-region = "asia-southeast2"
  nfs-server-region = local.master-node-region

  master-node-zone = "asia-southeast1-a"
  worker-node-zone = "asia-southeast2-a"

  master-node-subnet-ip = "172.20.0.0/16"
  worker-node-subnet-ip = "172.21.0.0/16"
  nfs-server-subnet-ip = "172.22.0.0/16"

  network_name = "k8s-network"

  worker-nodes-tags = ["worker-nodes"]
  master-nodes-tags = ["master-nodes"]
  cluster-tag = concat(local.master-nodes-tags, local.worker-nodes-tags)

  master-node-subnet-name = "master-node-subnet"
  worker-node-subnet-name = "worker-node-subnet"

  n-master-nodes = 1
  n-worker-nodes = 4
  master-machine-type = "e2-medium"
  worker-machine-type = local.master-machine-type

  environment = "staging"
}

module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "9.3.0"
  network_name = local.network_name
  project_id   = var.project_id
  subnets = [
    {
      subnet_name   = local.master-node-subnet-name
      subnet_ip     = local.master-node-subnet-ip
      subnet_region = local.master-node-region
      description   = "Subnet for k8s-network"
    },
    {
      subnet_name = "nfs-servers-subnet"
      subnet_ip= local.nfs-server-subnet-ip
      subnet_region = local.nfs-server-region
      description = "Subnet for nfs-servers"
    },
    {
      subnet_name   = local.worker-node-subnet-name
      subnet_ip     = local.worker-node-subnet-ip
      subnet_region = local.worker-node-region
      description   = "Subnet for worker nodes"
    }
  ]
  firewall_rules = [
    {
      name      = "allow-ping-ingress"
      direction = "INGRESS"
      allow = [
        {
          protocol = "icmp"
        }
      ]
    },
    {
      name = "allow-ssh-ingress"
      # network       = "k8s-network"
      direction = "INGRESS"
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      source_ranges = ["0.0.0.0/0"]
    },
    {
      name      = "allow-ports-ingress-controller-for-worker-nodes"
      direction = "INGRESS"
      allow = [
        {
          protocol = "tcp"
          ports    = ["30080", "30443"]
        }
      ]
      source_ranges = ["0.0.0.0/0"]
      target_tags   = local.worker-nodes-tags
    },
    {
      name          = "allow-api-server-endpoint-for-master-nodes"
      source_tags = local.cluster-tag
      target_tags =  local.master-nodes-tags
      priority =  100
      enable_log = true
      allow = [
        {
          protocol = "tcp"
          ports    = ["6443"]
        }
      ]
    },
    {
      name = "allow-kubelet-port"
      direction = "INGRESS"
      allow = [
          {
          protocol = "tcp"
          ports    = ["10250"]
          }
      ]
      source_tags = local.cluster-tag
      target_tags = local.cluster-tag
    }
    ,
    {
      name = "allow-calico-port"
        direction = "INGRESS"
        allow = [
            {
            protocol = "tcp"
            ports    = ["179"]
            }
        ]
        source_tags = local.cluster-tag
        target_tags = local.cluster-tag
    }
  ]
}
module "master-nodes" {
  depends_on     = [module.network]
  source         = "../modules/master-nodes"
  region         = local.master-node-region
  zone           = local.master-node-zone
  project_id     = var.project_id
  environment = local.environment
  n-master-nodes = local.n-master-nodes
  network        = local.network_name
  subnetwork     = module.network.subnets["${local.master-node-region}/${local.master-node-subnet-name}"].name
  master-nodes-tag = local.master-nodes-tags
  worker-nodes-tag = local.worker-nodes-tags
  cluster-tag = local.cluster-tag
  pub_key_paths = ["~/.ssh/id_rsa.pub" ]
  machine_type = local.master-machine-type
}
module "worker-nodes" {
  depends_on     = [module.network]
  n-worker-nodes = local.n-worker-nodes
  source         = "../modules/worker-nodes"
  region         = local.worker-node-region
  zone           = local.worker-node-zone
  network        = local.network_name
  subnetwork     = module.network.subnets["${local.worker-node-region}/${local.worker-node-subnet-name}"].name
  project_id     = var.project_id
  pub_key_paths= ["~/.ssh/id_rsa.pub" ]
  worker-nodes-tag = local.worker-nodes-tags
  master-nodes-tag = local.master-nodes-tags
  environment = local.environment
  machine_type = local.worker-machine-type
}

# module "nfs-server" {
#   source = "../modules/nfs-server"
#   region = var.master-nodes-region
#   zone = var.master-nodes-zone
#   network = module.network.network_name
#   subnetwork =
# }