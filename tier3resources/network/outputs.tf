output "vpc_self_link" {
  value = google_compute_network.gvpc.self_link
}

output "subnet_self_links" {
  value = tomap({
    for k, subnets in google_compute_subnetwork.gsnweb : k => subnets.id
      })
}
