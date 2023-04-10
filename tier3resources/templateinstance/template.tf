
# Resources
# Create a managed instance group for web servers
resource "google_compute_instance_template" "instance_template" {
  name_prefix = "${var.name_prefix}-instance-template-"
  machine_type = var.machine_type
  can_ip_forward = false
  tags = [var.tag]
  // Create a new boot disk from an image
  disk {
    source_image      = var.source_image
    auto_delete       = true
    boot              = true
  }
  network_interface {
    network = var.vpc
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}
