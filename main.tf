/******************************************
	PROJECT ID (if not passed through)
 *****************************************/
data "google_client_config" "default" {}

/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "default" {
    name                    = "${var.name}"
    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    auto_create_subnetworks = "${var.auto_create_subnetworks}"
    routing_mode            = "${var.routing_mode}"
}

/******************************************
	SUBNET configuration
 *****************************************/
  resource "google_compute_subnetwork" "default" {
      count         = "${var.auto_create_subnetworks == "false" ? length(var.subnetworks) : 0}"
      
      name          = "${lookup(var.subnetworks[count.index], "region")}" 
      project       = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
      ip_cidr_range = "${lookup(var.subnetworks[count.index], "cidr")}"
      region        = "${lookup(var.subnetworks[count.index], "region")}"
      network       = "${google_compute_network.default.self_link}" 

      enable_flow_logs          = "${lookup(var.subnetworks[count.index], "enable_flow_logs", "false")}"
      private_ip_google_access  = "${lookup(var.subnetworks[count.index], "private_ip_google_access", "true")}" 
  }