# Create a VPC network
resource "google_compute_network" "gvpc" {
  name = var.gvpc
  auto_create_subnetworks = false
}

# Create multiple subnets
resource "google_compute_subnetwork" "gsnweb" {
  for_each = var.subnets

  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.gvpc.self_link
}