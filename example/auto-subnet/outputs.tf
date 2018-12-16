output "vpc_name" {
  value       = "${module.auto-vpc.name}"
  description = "Name of the created VPC."
}

output "vpc_gateway" {
  value       = "${module.auto-vpc.gateway_ipv4}"
  description = "The IPv4 address of the gateway from the created VPC."
}

output "self_link" {
  value       = "${module.auto-vpc.self_link}"
  description =  "The URI of the created VPC."
}