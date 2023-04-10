
resource "google_compute_instance_group_manager" "instance_group" {
  name        = "${var.name_prefix}-instance-group"
  base_instance_name = "${var.name_prefix}-instance"
  target_size = var.instance_count
  named_port {
    name = var.protocol
    port = var.ports
  }
  version {
    instance_template  = var.instance_template
  }
}
