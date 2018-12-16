variable "name" {
    description = "The name of the VPC being created.[[[=]]]"
    type        = "string"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    type        = "string"
    default     = ""
}

variable "auto_create_subnetworks" {
    description = "If set to true, this network will be created in auto subnet mode, and Google will create a subnet for each region automatically. If set to false, a custom subnetted network will be created that can support google_compute_subnetwork resources."
    type        = "string"
    default     = "true"
}

variable "routing_mode" {
    description = "Sets the network-wide routing mode for Cloud Routers to use. Accepted values are GLOBAL or REGIONAL."
    type        = "string"
    default     = "GLOBAL"
}

variable "subnetworks" {
    description = "Define subnetwork detail for VPC"
    type        = "list"
    default     = []
}

variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency. Output from another module can be passed down in order to enforce dependencies"
}