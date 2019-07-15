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
  value       = {
    for subnet in google_compute_subnetwork.default:
      subnet.name => subnet.self_link
  }
  description = "the list of subnetworks which belong to the network"
}

output "service_network_address" {
  value = {
    for service in google_compute_global_address.default:
      service.name => service.address
  }
  description = "Address of the service network"
}

output "service_network_selflink" {
  value = {
    for service in google_compute_global_address.default:
      service.name => service.self_link
  }
  description = "Self Link of the service network"
}