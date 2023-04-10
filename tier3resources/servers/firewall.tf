
# Create a firewall rule to allow incoming application traffic to app servers
resource "google_compute_firewall" "firewall" {
  name = "${var.name_prefix}-firewall"
  network = var.vpc
  allow {
    protocol = var.protocol
    ports = [var.ports]
  }
  source_ranges = [var.cidr]
  target_tags = [var.tag]
}
