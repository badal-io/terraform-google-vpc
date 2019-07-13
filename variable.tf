variable "name" {
    description = "The name of the VPC being created.[[[=]]]"
    type        = "string"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    type        = "string"
    default     = ""
}

# VPC Settings
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

# Subnetworks
variable "subnetworks" {
    description = "Define subnetwork detail for VPC"
    type        = list(object({
        name            = string   # name of the subnetwork
        region          = string
        cidr            = string   # The IP address range that machines in this network are assigned to, represented as a CIDR block.
        secondary_ip_range = list(object({
            name = string # The name associated with this subnetwork secondary range, used when adding an alias IP range to a VM instance.
            cidr = string # The range of IP addresses belonging to this subnetwork secondary range.
        }))
    }))
    default     = null
}

variable "private_ip_google_access" {
    description = "Whether the VMs in this subnet can access Google services without assigned external IP addresses."
    type        = bool
    default     = true
}

variable "enable_flow_logs" {
    description = "Whether to enable flow logging for this subnetwork."
    type        = bool
    default     = true
}

# Private Service Connection

variable "services_address" {
    description = "This object sets Private service connection"
    type        = list(object({
        name        = string
        description = string
        address     = string
        prefix      = number
    }))
    default = null
}

variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency. Output from another module can be passed down in order to enforce dependencies"
}