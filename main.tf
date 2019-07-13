/******************************************
	PROJECT ID (if not passed through)
 *****************************************/
data "google_client_config" "default" {}

locals {
  project-id = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
}

/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "default" {
    name                    = "${var.name}"
    project                 = "${local.project-id}"
    auto_create_subnetworks = "${var.auto_create_subnetworks}"
    routing_mode            = "${var.routing_mode}"
}

/******************************************
	SUBNET configuration
 *****************************************/
  resource "google_compute_subnetwork" "default" {
      count         = "${var.auto_create_subnetworks == "false" ? length(var.subnetworks) : 0}"
      project       = "${local.project-id}"
      
      name          = "${var.subnetworks[count.index].name}-${var.subnetworks[count.index].region}" 
      ip_cidr_range = "${var.subnetworks[count.index].cidr}"
      region        = "${var.subnetworks[count.index].region}"
      network       = "${google_compute_network.default.self_link}" 

      private_ip_google_access  = "${var.private_ip_google_access}"
      enable_flow_logs          = "${var.enable_flow_logs}"

      dynamic "secondary_ip_range" {
          iterator = ip
          for_each = var.subnetworks[count.index].secondary_ip_range

          content {
              range_name    = ip.value.name
              ip_cidr_range = ip.value.cidr
          }
      }
  }

/******************************************
	Private Connection to services
*****************************************/

resource "google_compute_global_address" "default" {
    count         = "${var.services_address != null ? length(var.services_address) : 0}"
    project       = "${local.project-id}"

    purpose       = "VPC_PEERING"
    address_type  = "INTERNAL"
    network       = "${google_compute_network.default.self_link}"

    name          = "${var.services_address[count.index].name}"
    description   = "${var.services_address[count.index].description}"
    address       = "${var.services_address[count.index].address}"
    prefix_length = "${var.services_address[count.index].prefix}"
}

resource "google_service_networking_connection" "default" {
    count   = "${var.services_address != null ? 1 : 0}"

    network                 = "${google_compute_network.default.self_link}"
    service                 = "servicenetworking.googleapis.com"
    reserved_peering_ranges = "${google_compute_global_address.default[*].name}"
}