provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "rke" {
  name       = "rke"
  public_key = var.ssh_public_key
}

module "rke-kubernetes" {
  source = "vojtechmares/rke-kubernetes/hcloud"
  version = "0.1.0"
  hcloud_token = var.hcloud_token
  kubernetes_cluster_name = var.kubernetes_cluster_name
  kubernetes_upgrade_strategy_drain = var.kubernetes_upgrade_strategy_drain
  kubernetes_upgrade_strategy_max_unavailable_workers = var.kubernetes_upgrade_strategy_max_unavailable_workers
  kubernetes_version = var.kubernetes_version
  load_balancer_type = var.load_balancer_type
  location = var.location
  node_count = var.node_count
  node_image = var.node_image
  node_type = var.node_type
  ssh_public_key = var.ssh_public_key
  ssh_private_key = var.ssh_public_key
}

output "kubeconfig" {
  value     = module.rke-kubernetes.kube_config_yaml
  sensitive = false
}

output "lbipv4" {
  value = module.rke-kubernetes.load_balancer_ipv4
}
