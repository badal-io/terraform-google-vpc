output "name" {
  value       = "${google_compute_network.default.name}"
  description = "Name of the created VPC"
}

output "gateway_ipv4" {
  value       = "${google_compute_network.default.gateway_ipv4}"
  description = "The IPv4 address of the gateway"
}

output "self_link" {
  value       = "${google_compute_network.default.self_link}"
  description =  "The URI of the VPC created."
}

output "subnetworks_self_links" {
  value       = ["${google_compute_subnetwork.default.*.self_link}"]
  description = "the list of subnetworks which belong to the network"
}